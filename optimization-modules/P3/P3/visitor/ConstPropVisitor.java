package visitor;

import syntaxtree.*;
import java.util.*;

public class ConstPropVisitor extends GJDepthFirst<String, ConstPropVisitor.Env> {

    public final StringBuilder out = new StringBuilder();

    private final ProgramModel model = new ProgramModel();
    private final Map<MethodKey, MethodState> methodStates = new LinkedHashMap<>();
    private final Map<MethodKey, Set<CallerId>> callersByCallee = new HashMap<>();
    private final Map<MethodKey, ReachabilityInfo> reachabilityCache = new HashMap<>();
    private final Map<MethodKey, MethodOutput> methodOutputCache = new HashMap<>();
    private final Map<String, Set<String>> keptFieldsByClass = new HashMap<>();
    private final Set<String> keptClasses = new LinkedHashSet<>();
    private final Set<MethodKey> keptMethods = new LinkedHashSet<>();
    private final Set<MethodKey> sideEffectMethods = new HashSet<>();
    private final Set<MethodKey> nonRemovableMethods = new HashSet<>();
    private MainOutput mainOutput;
    private int indent = 0;

    public String optimize(Goal root) {
        model.clear();
        methodStates.clear();
        callersByCallee.clear();
        reachabilityCache.clear();
        methodOutputCache.clear();
        keptFieldsByClass.clear();
        keptClasses.clear();
        keptMethods.clear();
        sideEffectMethods.clear();
        nonRemovableMethods.clear();
        out.setLength(0);
        indent = 0;

        buildModel(root);
        initializeStates();
        runWorklist();
        computeNonRemovableMethods();
        rewriteProgram();
        return out.toString();
    }

    private void buildModel(Goal root) {
        root.accept(new ModelCollector(), null);
    }

    private void initializeStates() {
        for (MethodInfo method : model.methodsInOrder) {
            MethodState state = new MethodState(method);
            for (ParamInfo param : method.params) {
                state.formals.put(param.name, AbsValue.undef());
            }
            state.returnValue = AbsValue.undef();
            methodStates.put(method.key, state);
        }
    }

    private void runWorklist() {
        ArrayDeque<CallerId> worklist = new ArrayDeque<>();
        Set<CallerId> enqueued = new HashSet<>();
        CallerId mainId = CallerId.main();
        worklist.add(mainId);
        enqueued.add(mainId);

        while (!worklist.isEmpty()) {
            CallerId current = worklist.removeFirst();
            enqueued.remove(current);
            // Analysis result contains call edges, return value, hasSideEffect
            AnalysisResult result = current.isMain
                    ? analyzeMainUnit()
                    : analyzeMethodUnit(current.methodKey);

            for (CallEdge edge : result.calls) {
                for (MethodKey callee : edge.callees) {
                    callersByCallee.computeIfAbsent(callee, key -> new LinkedHashSet<>()).add(current);
                }
                boolean changed = meetActualsIntoCallees(edge);
                if (changed) {
                    for (MethodKey callee : edge.callees) {
                        CallerId calleeId = CallerId.method(callee);
                        if (enqueued.add(calleeId)) {
                            worklist.addLast(calleeId);
                        }
                    }
                }
            }

            if (!current.isMain && result.returnValue != null) {
                MethodState state = methodStates.get(current.methodKey);
                if (!Objects.equals(state.returnValue, result.returnValue)) {
                    state.returnValue = result.returnValue;
                    for (CallerId caller : callersByCallee.getOrDefault(current.methodKey, Collections.emptySet())) {
                        if (enqueued.add(caller)) {
                            worklist.addLast(caller);
                        }
                    }
                }
            }

            if (!current.isMain && result.hasSideEffect && sideEffectMethods.add(current.methodKey)) {
                for (CallerId caller : callersByCallee.getOrDefault(current.methodKey, Collections.emptySet())) {
                    if (enqueued.add(caller)) {
                        worklist.addLast(caller);
                    }
                }
            }
        }
    }

    private boolean meetActualsIntoCallees(CallEdge edge) {
        boolean changed = false;
        for (MethodKey calleeKey : edge.callees) {
            MethodState state = methodStates.get(calleeKey);
            if (state == null) {
                continue;
            }
            if (!state.reachable) {
                state.reachable = true;
                changed = true;
            }
            MethodInfo method = state.method;
            for (int i = 0; i < method.params.size(); i++) {
                ParamInfo param = method.params.get(i);
                AbsValue actual = i < edge.actuals.size() ? edge.actuals.get(i) : AbsValue.undef();
                AbsValue merged = AbsValue.meet(state.formals.get(param.name), actual);
                if (!Objects.equals(merged, state.formals.get(param.name))) {
                    state.formals.put(param.name, merged);
                    changed = true;
                }
            }
        }
        return changed;
    }

    private AnalysisResult analyzeMainUnit() {
        MainClass main = model.mainClass;
        Env env = Env.forMain(model);
        simulateStatementList(main.f15, env, new AnalysisResult());
        return env.analysisResult;
    }

    private AnalysisResult analyzeMethodUnit(MethodKey key) {
        MethodInfo method = methodStates.get(key).method;
        Env env = Env.forMethod(model, method, methodStates.get(key).formals);
        simulateStatementList(method.node.f8, env, new AnalysisResult());
        AbsValue returnValue = evalConstOrId(method.node.f10, env, null).value;
        env.analysisResult.returnValue = filterReturnValue(method.returnType, returnValue);
        return env.analysisResult;
    }

    private AbsValue filterReturnValue(String returnType, AbsValue value) {
        if ("int".equals(returnType)) {
            if (value.kind == AbsValue.Kind.CONST_INT || value.kind == AbsValue.Kind.UNDEF) {
                return value;
            }
            return AbsValue.nac();
        }
        if ("boolean".equals(returnType)) {
            if (value.kind == AbsValue.Kind.CONST_BOOL || value.kind == AbsValue.Kind.UNDEF) {
                return value;
            }
            return AbsValue.nac();
        }
        return AbsValue.nac();
    }

    private void simulateStatementList(NodeListOptional statements, Env env, AnalysisResult result) {
        env.analysisResult = result;
        if (statements == null || !statements.present()) {
            return;
        }
        for (Enumeration<Node> e = statements.elements(); e.hasMoreElements();) {
            Statement stmt = (Statement) e.nextElement();
            simulateStatement(stmt, env);
        }
    }

    private void simulateStatement(Node node, Env env) {
        if (node instanceof Statement) {
            simulateStatement(((Statement) node).f0.choice, env);
            return;
        }
        if (node instanceof Block) {
            simulateStatementList(((Block) node).f1, env, env.analysisResult);
            return;
        }
        // If it is a field, mark side effect else, assign the value to variable
        if (node instanceof AssignmentStatement) {
            AssignmentStatement stmt = (AssignmentStatement) node;
            ExprData rhs = evalExpression(stmt.f2, env, null);
            String target = stmt.f0.f0.tokenImage;
            if (env.isField(target) && !env.isLocalOrParam(target)) {
                markAnalysisSideEffect(env);
            } else {
                assignValue(env, target, rhs.value);
            }
            return;
        }
        if (node instanceof VoidMessageSendStatement) {
            evalMessageSend(((VoidMessageSendStatement) node).f0, env, null);
            return;
        }
        if (node instanceof ArrayAssignmentStatement) {
            ArrayAssignmentStatement stmt = (ArrayAssignmentStatement) node;
            evalConstOrId(stmt.f2, env, null);
            evalConstOrId(stmt.f5, env, null);
            invalidateArray(env, stmt.f0.f0.tokenImage);
            return;
        }
        if (node instanceof FieldAssignmentStatement) {
            FieldAssignmentStatement stmt = (FieldAssignmentStatement) node;
            evalConstOrId(stmt.f4, env, null);
            markAnalysisSideEffect(env);
            return;
        }
        if (node instanceof PrintStatement) {
            evalConstOrId(((PrintStatement) node).f2, env, null);
            markAnalysisSideEffect(env);
            return;
        }
        if (node instanceof IfStatement) {
            simulateIf((IfStatement) node, env);
            return;
        }
        if (node instanceof WhileStatement) {
            simulateWhile((WhileStatement) node, env);
            return;
        }
        if (node instanceof ForStatement) {
            simulateFor((ForStatement) node, env);
        }
    }

    private void simulateIf(IfStatement stmt, Env env) {
        AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
        if (cond.kind == AbsValue.Kind.CONST_BOOL) {
            if (cond.boolValue) {
                simulateStatement(stmt.f4, env);
            } else {
                simulateStatement(stmt.f6, env);
            }
            return;
        }

        Env thenEnv = env.copy();
        Env elseEnv = env.copy();
        simulateStatement(stmt.f4, thenEnv);
        simulateStatement(stmt.f6, elseEnv);
        env.mergeFrom(thenEnv, elseEnv);
    }

    private void simulateWhile(WhileStatement stmt, Env env) {
        AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
        if (cond.kind == AbsValue.Kind.CONST_BOOL && !cond.boolValue) {
            return;
        }

        Env current = env.copy();
        while (true) {
            Env bodyEnv = current.copy();
            simulateStatement(stmt.f4, bodyEnv);
            Env joined = current.copy();
            joined.mergeFrom(current, bodyEnv);
            if (joined.sameValues(current)) {
                current = joined;
                break;
            }
            current = joined;
        }
        env.mergeFrom(env, current);
    }

    private void simulateFor(ForStatement stmt, Env env) {
        // f4 is expr, f2 is 'i'
        ExprData init = evalExpression(stmt.f4, env, null);
        assignValue(env, stmt.f2.f0.tokenImage, init.value);

        // f6 is the end condition
        ExprData cond = evalExpression(stmt.f6, env, null);
        if (cond.value.kind == AbsValue.Kind.CONST_BOOL && !cond.value.boolValue) {
            return;
        }

        Env current = env.copy();
        while (true) {
            Env bodyEnv = current.copy();
            simulateStatement(stmt.f12, bodyEnv);
            ExprData step = evalExpression(stmt.f10, bodyEnv, null);
            assignValue(bodyEnv, stmt.f8.f0.tokenImage, step.value);
            Env joined = current.copy();
            joined.mergeFrom(current, bodyEnv);
            if (joined.sameValues(current)) {
                current = joined;
                break;
            }
            current = joined;
        }
        env.mergeFrom(env, current);
    }

    private void markAnalysisSideEffect(Env env) {
        if (env.analysisResult != null) {
            env.analysisResult.hasSideEffect = true;
        }
    }

    private void assignValue(Env env, String name, AbsValue value) {
        if (!env.isLocalOrParam(name)) {
            env.values.put(name, AbsValue.nac());
            return;
        }

        String type = env.lookupType(name);
        if ("int".equals(type)) {
            if (value.kind == AbsValue.Kind.CONST_INT || value.kind == AbsValue.Kind.UNDEF) {
                env.values.put(name, value);
            } else {
                env.values.put(name, AbsValue.nac());
            }
            return;
        }
        if ("boolean".equals(type)) {
            if (value.kind == AbsValue.Kind.CONST_BOOL || value.kind == AbsValue.Kind.UNDEF) {
                env.values.put(name, value);
            } else {
                env.values.put(name, AbsValue.nac());
            }
            return;
        }
        if ("int[]".equals(type)) {
            if (value.kind == AbsValue.Kind.ARRAY || value.kind == AbsValue.Kind.UNDEF) {
                env.values.put(name, value);
            } else {
                env.values.put(name, AbsValue.nac());
            }
            return;
        }
        env.values.put(name, value.kind == AbsValue.Kind.UNDEF ? AbsValue.undef() : AbsValue.nac());
    }

    private void invalidateArray(Env env, String name) {
        if (env.isLocalOrParam(name) && "int[]".equals(env.lookupType(name))) {
            env.values.put(name, AbsValue.nac());
        }
    }

    private ExprData evalExpression(Expression n, Env env, Usage usage) {
        Node choice = n.f0.choice;
        if (choice instanceof CompareExpression) {
            CompareExpression expr = (CompareExpression) choice;
            ExprData left = evalConstOrId(expr.f0, env, usage);
            ExprData right = evalConstOrId(expr.f2, env, usage);
            if (left.value.kind == AbsValue.Kind.CONST_INT && right.value.kind == AbsValue.Kind.CONST_INT) {
                return ExprData.literal(Boolean.toString(left.value.intValue < right.value.intValue),
                        AbsValue.constBool(left.value.intValue < right.value.intValue));
            }
            return ExprData.simple(left.text + " < " + right.text, AbsValue.nac());
        }
        if (choice instanceof PlusExpression) {
            PlusExpression expr = (PlusExpression) choice;
            ExprData left = evalConstOrId(expr.f0, env, usage);
            ExprData right = evalConstOrId(expr.f2, env, usage);
            if (left.value.kind == AbsValue.Kind.CONST_INT && right.value.kind == AbsValue.Kind.CONST_INT) {
                return ExprData.literal(Integer.toString(left.value.intValue + right.value.intValue),
                        AbsValue.constInt(left.value.intValue + right.value.intValue));
            }
            return ExprData.simple(left.text + " + " + right.text, AbsValue.nac());
        }
        if (choice instanceof MinusExpression) {
            MinusExpression expr = (MinusExpression) choice;
            ExprData left = evalConstOrId(expr.f0, env, usage);
            ExprData right = evalConstOrId(expr.f2, env, usage);
            if (left.value.kind == AbsValue.Kind.CONST_INT && right.value.kind == AbsValue.Kind.CONST_INT) {
                return ExprData.literal(Integer.toString(left.value.intValue - right.value.intValue),
                        AbsValue.constInt(left.value.intValue - right.value.intValue));
            }
            return ExprData.simple(left.text + " - " + right.text, AbsValue.nac());
        }
        if (choice instanceof TimesExpression) {
            TimesExpression expr = (TimesExpression) choice;
            ExprData left = evalConstOrId(expr.f0, env, usage);
            ExprData right = evalConstOrId(expr.f2, env, usage);
            if (left.value.kind == AbsValue.Kind.CONST_INT && right.value.kind == AbsValue.Kind.CONST_INT) {
                return ExprData.literal(Integer.toString(left.value.intValue * right.value.intValue),
                        AbsValue.constInt(left.value.intValue * right.value.intValue));
            }
            return ExprData.simple(left.text + " * " + right.text, AbsValue.nac());
        }
        if (choice instanceof ArrayLookup) {
            ArrayLookup expr = (ArrayLookup) choice;
            ExprData base = evalIdentifier(expr.f0, env, usage);
            ExprData index = evalConstOrId(expr.f2, env, usage);
            return ExprData.simple(base.text + "[" + index.text + "]", AbsValue.nac());
        }
        if (choice instanceof ArrayLength) {
            ArrayLength expr = (ArrayLength) choice;
            ExprData base = evalIdentifier(expr.f0, env, usage);
            if (base.value.kind == AbsValue.Kind.ARRAY && base.value.arrayLength != null) {
                return ExprData.literal(Integer.toString(base.value.arrayLength),
                        AbsValue.constInt(base.value.arrayLength));
            }
            return ExprData.simple(base.text + ".length", AbsValue.nac());
        }
        if (choice instanceof MessageSend) {
            return evalMessageSend((MessageSend) choice, env, usage);
        }
        if (choice instanceof FieldRead) {
            FieldRead expr = (FieldRead) choice;
            String receiverName = expr.f0.f0.tokenImage;
            if (usage != null) {
                if (env.isField(receiverName)) {
                    usage.markFieldUsage(env.className, env.resolveFieldOwner(receiverName));
                } else {
                    usage.markVarUsage(receiverName, env);
                }
            }
            String receiverType = env.lookupType(receiverName);
            if (usage != null && receiverType != null) {
                String owner = model.resolveFieldOwner(receiverType, expr.f2.f0.tokenImage);
                usage.markFieldUsage(owner, expr.f2.f0.tokenImage);
                usage.markClassReference(receiverType);
            }
            return ExprData.simple(receiverName + "." + expr.f2.f0.tokenImage, AbsValue.nac());
        }
        if (choice instanceof PrimaryExpression) {
            return evalPrimary((PrimaryExpression) choice, env, usage);
        }
        return ExprData.simple("", AbsValue.nac());
    }

    private ExprData evalConstOrId(ConstOrId n, Env env, Usage usage) {
        Node choice = n.f0.choice;
        if (choice instanceof IntegerLiteral) {
            return evalIntegerLiteral((IntegerLiteral) choice);
        }
        if (choice instanceof Identifier) {
            return evalIdentifier((Identifier) choice, env, usage);
        }
        if (choice instanceof TrueLiteral) {
            return ExprData.literal("true", AbsValue.constBool(true));
        }
        if (choice instanceof FalseLiteral) {
            return ExprData.literal("false", AbsValue.constBool(false));
        }
        return ExprData.simple("", AbsValue.nac());
    }

    private ExprData evalPrimary(PrimaryExpression n, Env env, Usage usage) {
        Node choice = n.f0.choice;
        if (choice instanceof IntegerLiteral) {
            return evalIntegerLiteral((IntegerLiteral) choice);
        }
        if (choice instanceof TrueLiteral) {
            return ExprData.literal("true", AbsValue.constBool(true));
        }
        if (choice instanceof FalseLiteral) {
            return ExprData.literal("false", AbsValue.constBool(false));
        }
        if (choice instanceof Identifier) {
            return evalIdentifier((Identifier) choice, env, usage);
        }
        if (choice instanceof ThisExpression) {
            if (usage != null) {
                usage.markClassReference(env.className);
            }
            return ExprData.withType("this", AbsValue.nac(), env.className);
        }
        if (choice instanceof ArrayAllocationExpression) {
            ArrayAllocationExpression expr = (ArrayAllocationExpression) choice;
            ExprData size = evalConstOrId(expr.f3, env, usage);
            Integer len = size.value.kind == AbsValue.Kind.CONST_INT ? size.value.intValue : null;
            return ExprData.withType("new int[" + size.text + "]", AbsValue.array(len), "int[]");
        }
        if (choice instanceof AllocationExpression) {
            AllocationExpression expr = (AllocationExpression) choice;
            String className = expr.f1.f0.tokenImage;
            if (usage != null) {
                usage.markClassReference(className);
            }
            markAnalysisSideEffect(env);
            return ExprData.effectfulWithType("new " + className + "()", AbsValue.nac(), className);
        }
        if (choice instanceof NotExpression) {
            NotExpression expr = (NotExpression) choice;
            ExprData base = evalIdentifier(expr.f1, env, usage);
            if (base.value.kind == AbsValue.Kind.CONST_BOOL) {
                return ExprData.literal(Boolean.toString(!base.value.boolValue),
                        AbsValue.constBool(!base.value.boolValue));
            }
            return ExprData.simple("!" + base.text, AbsValue.nac());
        }
        return ExprData.simple("", AbsValue.nac());
    }

    private ExprData evalIdentifier(Identifier n, Env env, Usage usage) {
        String name = n.f0.tokenImage;
        AbsValue value = env.lookupValue(name);
        String literal = value.renderLiteral();
        if (literal != null) {
            return ExprData.literal(literal, value);
        }
        if (usage != null) {
            usage.markVarUsage(name, env);
        }
        return ExprData.withType(name, value, env.lookupType(name));
    }

    private ExprData evalIntegerLiteral(IntegerLiteral n) {
        Node choice = n.f0.choice;
        if (choice instanceof PlainIntegerLiteral) {
            int value = Integer.parseInt(((PlainIntegerLiteral) choice).f0.tokenImage);
            return ExprData.literal(Integer.toString(value), AbsValue.constInt(value));
        }
        if (choice instanceof IntegerLiteralWithPosSign) {
            int value = Integer.parseInt(((IntegerLiteralWithPosSign) choice).f1.tokenImage);
            return ExprData.literal(Integer.toString(value), AbsValue.constInt(value));
        }
        int value = -Integer.parseInt(((IntegerLiteralWithNegSign) choice).f1.tokenImage);
        return ExprData.literal(Integer.toString(value), AbsValue.constInt(value));
    }

    private ExprData evalMessageSend(MessageSend n, Env env, Usage usage) {
        ExprData receiver = evalPrimary(n.f0, env, usage);
        String staticType = receiver.staticType;
        List<AbsValue> actuals = new ArrayList<>();
        List<String> actualTexts = new ArrayList<>();
        if (n.f4.present()) {
            ArgList argList = (ArgList) n.f4.node;
            ExprData first = evalConstOrId(argList.f0, env, usage);
            actuals.add(first.value);
            actualTexts.add(first.text);
            for (Enumeration<Node> e = argList.f1.elements(); e.hasMoreElements();) {
                ArgRest rest = (ArgRest) e.nextElement();
                ExprData next = evalConstOrId(rest.f1, env, usage);
                actuals.add(next.value);
                actualTexts.add(next.text);
            }
        }

        LinkedHashSet<MethodKey> targets = model.possibleDispatchTargets(staticType, n.f2.f0.tokenImage);
        if (env.analysisResult != null && !targets.isEmpty()) {
            env.analysisResult.calls.add(new CallEdge(new ArrayList<>(targets), actuals));
        }

        AbsValue returnValue = AbsValue.undef();
        for (MethodKey target : targets) {
            MethodState state = methodStates.get(target);
            AbsValue summary = state == null ? AbsValue.nac() : state.returnValue;
            returnValue = AbsValue.meet(returnValue, summary);
        }

        String text = receiver.text + "." + n.f2.f0.tokenImage + "(" + String.join(", ", actualTexts) + ")";
        boolean removable = true;
        boolean hasSideEffect = false;
        for (MethodKey target : targets) {
            if (sideEffectMethods.contains(target)) {
                hasSideEffect = true;
            }
            if (nonRemovableMethods.contains(target)) {
                removable = false;
            }
        }
        if (env.analysisResult != null && hasSideEffect) {
            env.analysisResult.hasSideEffect = true;
        }
        if (usage != null) {
            usage.recordCallTargets(targets);
        }
        String returnType = null;
        if (!targets.isEmpty()) {
            MethodInfo method = methodStates.get(targets.iterator().next()).method;
            returnType = method.returnType;
        }
        if (targets.isEmpty()) {
            returnValue = AbsValue.nac();
        }
        String literal = null;
        if ("int".equals(returnType) || "boolean".equals(returnType)) {
            literal = returnValue.renderLiteral();
        } else {
            returnValue = AbsValue.nac();
        }
        if (literal != null) {
            return ExprData.call(literal, text, returnValue, removable, targets, returnType);
        }
        return ExprData.call(text, text, returnValue, removable, targets, returnType);
    }

    private void computeNonRemovableMethods() {
        nonRemovableMethods.clear();
        nonRemovableMethods.addAll(sideEffectMethods);
    }

    private ReachabilityInfo computeReachability(MethodKey key) {
        ReachabilityInfo cached = reachabilityCache.get(key);
        if (cached != null) {
            return cached;
        }
        MethodInfo method = methodStates.get(key).method;
        Env env = Env.forMethod(model, method, methodStates.get(key).formals);
        ReachabilityUsage usage = new ReachabilityUsage();
        simulateReachableStatements(method.node.f8, env, usage);
        reachabilityCache.put(key, usage.info);
        return usage.info;
    }

    private void simulateReachableStatements(NodeListOptional statements, Env env, ReachabilityUsage usage) {
        if (statements == null || !statements.present()) {
            return;
        }
        for (Enumeration<Node> e = statements.elements(); e.hasMoreElements();) {
            simulateReachableStatement((Statement) e.nextElement(), env, usage);
        }
    }

    private void simulateReachableStatement(Node node, Env env, ReachabilityUsage usage) {
        if (node instanceof Statement) {
            simulateReachableStatement(((Statement) node).f0.choice, env, usage);
            return;
        }
        if (node instanceof Block) {
            simulateReachableStatements(((Block) node).f1, env, usage);
            return;
        }
        if (node instanceof AssignmentStatement) {
            AssignmentStatement stmt = (AssignmentStatement) node;
            ExprData rhs = evalExpression(stmt.f2, env, usage);
            if (env.isField(stmt.f0.f0.tokenImage) && !env.isLocalOrParam(stmt.f0.f0.tokenImage)) {
                usage.info.hasObservableEffect = true;
            } else {
                assignValue(env, stmt.f0.f0.tokenImage, rhs.value);
            }
            return;
        }
        if (node instanceof VoidMessageSendStatement) {
            evalMessageSend(((VoidMessageSendStatement) node).f0, env, usage);
            return;
        }
        if (node instanceof ArrayAssignmentStatement) {
            ArrayAssignmentStatement stmt = (ArrayAssignmentStatement) node;
            evalConstOrId(stmt.f2, env, usage);
            evalConstOrId(stmt.f5, env, usage);
            invalidateArray(env, stmt.f0.f0.tokenImage);
            return;
        }
        if (node instanceof FieldAssignmentStatement) {
            FieldAssignmentStatement stmt = (FieldAssignmentStatement) node;
            evalConstOrId(stmt.f4, env, usage);
            String receiverType = env.lookupType(stmt.f0.f0.tokenImage);
            usage.markClassReference(receiverType);
            usage.markFieldUsage(model.resolveFieldOwner(receiverType, stmt.f2.f0.tokenImage), stmt.f2.f0.tokenImage);
            usage.info.hasObservableEffect = true;
            return;
        }
        if (node instanceof PrintStatement) {
            evalConstOrId(((PrintStatement) node).f2, env, usage);
            usage.info.hasObservableEffect = true;
            return;
        }
        if (node instanceof IfStatement) {
            IfStatement stmt = (IfStatement) node;
            AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
            if (cond.kind == AbsValue.Kind.CONST_BOOL) {
                if (cond.boolValue) {
                    simulateReachableStatement(stmt.f4, env, usage);
                } else {
                    simulateReachableStatement(stmt.f6, env, usage);
                }
                return;
            }
            Env thenEnv = env.copy();
            Env elseEnv = env.copy();
            simulateReachableStatement(stmt.f4, thenEnv, usage);
            simulateReachableStatement(stmt.f6, elseEnv, usage);
            env.mergeFrom(thenEnv, elseEnv);
            return;
        }
        if (node instanceof WhileStatement) {
            WhileStatement stmt = (WhileStatement) node;
            AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
            if (cond.kind == AbsValue.Kind.CONST_BOOL && !cond.boolValue) {
                return;
            }
            Env current = env.copy();
            while (true) {
                Env bodyEnv = current.copy();
                simulateReachableStatement(stmt.f4, bodyEnv, usage);
                Env joined = current.copy();
                joined.mergeFrom(current, bodyEnv);
                if (joined.sameValues(current)) {
                    current = joined;
                    break;
                }
                current = joined;
            }
            AbsValue fixedCond = current.lookupValue(stmt.f2.f0.tokenImage);
            if (fixedCond.kind != AbsValue.Kind.CONST_BOOL || fixedCond.boolValue) {
                usage.info.hasLoopKeepCondition = true;
            }
            env.mergeFrom(env, current);
            return;
        }
        if (node instanceof ForStatement) {
            ForStatement stmt = (ForStatement) node;
            ExprData init = evalExpression(stmt.f4, env, usage);
            assignValue(env, stmt.f2.f0.tokenImage, init.value);
            ExprData cond = evalExpression(stmt.f6, env, usage);
            if (cond.value.kind == AbsValue.Kind.CONST_BOOL && !cond.value.boolValue) {
                return;
            }
            Env current = env.copy();
            while (true) {
                Env bodyEnv = current.copy();
                simulateReachableStatement(stmt.f12, bodyEnv, usage);
                ExprData step = evalExpression(stmt.f10, bodyEnv, usage);
                assignValue(bodyEnv, stmt.f8.f0.tokenImage, step.value);
                Env joined = current.copy();
                joined.mergeFrom(current, bodyEnv);
                if (joined.sameValues(current)) {
                    current = joined;
                    break;
                }
                current = joined;
            }
            ExprData fixedCond = evalExpression(stmt.f6, current, null);
            if (fixedCond.value.kind != AbsValue.Kind.CONST_BOOL || fixedCond.value.boolValue) {
                usage.info.hasLoopKeepCondition = true;
            }
            env.mergeFrom(env, current);
        }
    }

    // Orchestrates the rewriting of the entire program by processing main and all
    // reachable methods, then emitting the transformed code
    private void rewriteProgram() {
        mainOutput = rewriteMain();
        emitMain(mainOutput);

        ArrayDeque<MethodKey> queue = new ArrayDeque<>(mainOutput.calledMethods);
        while (!queue.isEmpty()) {
            MethodKey key = queue.removeFirst();
            if (!keptMethods.add(key)) {
                continue;
            }
            MethodOutput output = rewriteMethod(key);
            methodOutputCache.put(key, output);
            queue.addAll(output.calledMethods);
        }

        for (String className : keptClassesFromMethodsAndMain()) {
            keptClasses.add(className);
        }
        addAncestorsOfKeptClasses();

        for (ClassInfo classInfo : model.classes.values()) {
            if (classInfo.name.equals(model.mainClassName)) {
                continue;
            }
            boolean keepClass = keptClasses.contains(classInfo.name)
                    || hasKeptField(classInfo.name)
                    || hasKeptMethodInClass(classInfo.name);
            if (!keepClass) {
                continue;
            }
            emitClass(classInfo);
        }
    }

    // Rewrites the main method by collecting variable usage and emitting optimized
    // statements
    private MainOutput rewriteMain() {
        MainClass main = model.mainClass;
        Env collectEnv = Env.forMain(model);
        CollectUsage collect = new CollectUsage();
        collectStatementList(main.f15, collectEnv, collect);
        MainOutput output = new MainOutput();
        output.requiredLocals = collect.requiredLocals;

        Env emitEnv = Env.forMain(model);
        output.lines.addAll(emitStatementList(main.f15, emitEnv, collect, output));
        output.usedFields.addAll(collect.usedFields);
        output.usedClasses.addAll(collect.referencedClasses);
        finalizeMainOutput(output);
        return output;
    }

    // Rewrites a specific method by applying constant propagation and emitting
    // optimized code
    private MethodOutput rewriteMethod(MethodKey key) {
        MethodInfo method = methodStates.get(key).method;
        Env collectEnv = Env.forMethod(model, method, methodStates.get(key).formals);
        CollectUsage collect = new CollectUsage();
        collectStatementList(method.node.f8, collectEnv, collect);
        ExprData ret = evalConstOrId(method.node.f10, collectEnv, collect);
        MethodOutput output = new MethodOutput();
        output.requiredLocals = collect.requiredLocals;
        output.returnText = ret.text;

        Env emitEnv = Env.forMethod(model, method, methodStates.get(key).formals);
        output.lines.addAll(emitStatementList(method.node.f8, emitEnv, collect, output));
        output.returnText = evalConstOrId(method.node.f10, emitEnv, collect).text;
        output.usedFields.addAll(collect.usedFields);
        output.usedClasses.addAll(collect.referencedClasses);
        finalizeMethodOutput(method, output);
        return output;
    }

    // Finalizes main output by cleaning up dead code and updating used classes and
    // methods
    private void finalizeMainOutput(MainOutput output) {
        LinkedHashSet<String> names = new LinkedHashSet<>();
        LinkedHashMap<String, String> typeMap = new LinkedHashMap<>();
        for (VarInfo var : model.mainLocals) {
            names.add(var.name);
            typeMap.put(var.name, var.type);
        }
        List<String> pruned = cleanupRenderedLines(output.lines, names, Collections.emptySet());
        output.lines.clear();
        output.lines.addAll(pruned);
        output.requiredLocals = mentionedLocals(pruned, names);
        refreshUsedClasses(output, pruned);
        refreshCalledMethods(output, pruned, null, typeMap);
    }

    // Finalizes method output by cleaning up dead code and updating used classes
    // and methods
    private void finalizeMethodOutput(MethodInfo method, MethodOutput output) {
        LinkedHashSet<String> allNames = new LinkedHashSet<>();
        LinkedHashSet<String> localNames = new LinkedHashSet<>();
        LinkedHashMap<String, String> typeMap = new LinkedHashMap<>();
        for (ParamInfo param : method.params) {
            allNames.add(param.name);
            typeMap.put(param.name, param.type);
        }
        for (VarInfo var : method.localsInOrder) {
            allNames.add(var.name);
            localNames.add(var.name);
            typeMap.put(var.name, var.type);
        }
        for (FieldInfo field : model.collectFields(method.ownerClass)) {
            typeMap.putIfAbsent(field.name, field.type);
        }
        Set<String> returnLive = mentionedLocals(Collections.singletonList(output.returnText), allNames);
        List<String> pruned = cleanupRenderedLines(output.lines, allNames, returnLive);
        output.lines.clear();
        output.lines.addAll(pruned);
        Set<String> mentions = mentionedLocals(pruned, localNames);
        mentions.addAll(mentionedLocals(Collections.singletonList(output.returnText), localNames));
        output.requiredLocals = mentions;
        refreshUsedClasses(output, pruned);
        refreshCalledMethods(output, pruned, method.ownerClass, typeMap);
    }

    // Removes dead code and unnecessary variable declarations from rendered lines
    private List<String> cleanupRenderedLines(List<String> lines, Set<String> names, Set<String> liveAfter) {
        ParseCursor cursor = new ParseCursor(lines);
        List<RenderedStmt> statements = parseRenderedStatements(cursor, ParseStop.END);
        CleanupBlock cleaned = cleanupRenderedStatements(statements, names, liveAfter);
        return renderRenderedStatements(cleaned.statements, 0);
    }

    // Updates the set of used classes by scanning the rendered code for allocations
    private void refreshUsedClasses(OutputBase output, List<String> lines) {
        output.usedClasses.clear();
        for (String line : lines) {
            for (String className : model.classes.keySet()) {
                if (line.contains("new " + className + "()")) {
                    output.usedClasses.add(className);
                }
            }
        }
    }

    // Updates the set of called methods by scanning the rendered code for method
    // invocations
    private void refreshCalledMethods(OutputBase output, List<String> lines, String currentClass,
            Map<String, String> typeMap) {
        output.calledMethods.clear();
        for (String line : lines) {
            collectCalledMethodsFromLine(output.calledMethods, line, currentClass, typeMap);
        }
    }

    // Extracts method calls from a single line of code using type information
    private void collectCalledMethodsFromLine(Set<MethodKey> out, String line, String currentClass,
            Map<String, String> typeMap) {
        int from = 0;
        while (from < line.length()) {
            int dot = line.indexOf('.', from);
            if (dot < 0 || dot + 1 >= line.length()) {
                return;
            }

            int recvStart = dot - 1;
            while (recvStart >= 0
                    && (Character.isLetterOrDigit(line.charAt(recvStart)) || line.charAt(recvStart) == '_')) {
                recvStart--;
            }
            recvStart++;
            if (recvStart >= dot) {
                from = dot + 1;
                continue;
            }

            int methodStart = dot + 1;
            int methodEnd = methodStart;
            while (methodEnd < line.length()
                    && (Character.isLetterOrDigit(line.charAt(methodEnd)) || line.charAt(methodEnd) == '_')) {
                methodEnd++;
            }
            if (methodEnd >= line.length() || line.charAt(methodEnd) != '(') {
                from = dot + 1;
                continue;
            }

            String receiver = line.substring(recvStart, dot);
            String methodName = line.substring(methodStart, methodEnd);
            String receiverType = "this".equals(receiver) ? currentClass : typeMap.get(receiver);
            if (receiverType != null) {
                out.addAll(model.possibleDispatchTargets(receiverType, methodName));
            } else {
                out.addAll(model.findMethodsByName(methodName));
            }
            from = methodEnd + 1;
        }
    }

    // Performs backward dataflow analysis to remove dead code and track live
    // variables
    private CleanupBlock cleanupRenderedStatements(List<RenderedStmt> statements, Set<String> names,
            Set<String> liveAfter) {
        ArrayDeque<RenderedStmt> kept = new ArrayDeque<>();
        LinkedHashSet<String> live = new LinkedHashSet<>(liveAfter);
        for (int i = statements.size() - 1; i >= 0; i--) {
            CleanupStmt cleaned = cleanupRenderedStatement(statements.get(i), names, live);
            live = cleaned.liveBefore;
            if (cleaned.statement != null) {
                kept.addFirst(cleaned.statement);
            }
        }
        return new CleanupBlock(new ArrayList<>(kept), live);
    }

    // Determines whether a single statement is dead code and tracks which variables
    // it uses
    private CleanupStmt cleanupRenderedStatement(RenderedStmt statement, Set<String> names, Set<String> liveAfter) {
        if (statement instanceof SimpleRenderedStmt) {
            String text = ((SimpleRenderedStmt) statement).text;
            AssignmentLine assignment = parseSimpleAssignment(text, names);
            LinkedHashSet<String> liveBefore = new LinkedHashSet<>(liveAfter);
            if (assignment == null) {
                addMentionedNames(text, liveBefore, names);
                return new CleanupStmt(statement, liveBefore);
            }
            if (!liveAfter.contains(assignment.target)) {
                if (looksLikeMethodCall(assignment.rhs)) {
                    addMentionedNames(assignment.rhs, liveBefore, names);
                    return new CleanupStmt(new SimpleRenderedStmt(assignment.rhs + ";"), liveBefore);
                }
                if (looksLikeAllocation(assignment.rhs)) {
                    addMentionedNames(assignment.rhs, liveBefore, names);
                    return new CleanupStmt(statement, liveBefore);
                }
                return new CleanupStmt(null, liveBefore);
            }
            liveBefore.remove(assignment.target);
            addMentionedNames(assignment.rhs, liveBefore, names);
            return new CleanupStmt(statement, liveBefore);
        }

        if (statement instanceof IfRenderedStmt) {
            IfRenderedStmt ifStmt = (IfRenderedStmt) statement;
            CleanupBlock thenBlock = cleanupRenderedStatements(ifStmt.thenStatements, names, liveAfter);
            CleanupBlock elseBlock = cleanupRenderedStatements(ifStmt.elseStatements, names, liveAfter);

            if (thenBlock.statements.isEmpty() && elseBlock.statements.isEmpty()) {
                return new CleanupStmt(null, new LinkedHashSet<>(liveAfter));
            }

            LinkedHashSet<String> liveBefore = new LinkedHashSet<>(thenBlock.liveBefore);
            liveBefore.addAll(elseBlock.liveBefore);
            addMentionedNames(ifStmt.header, liveBefore, names);
            return new CleanupStmt(
                    new IfRenderedStmt(ifStmt.header, thenBlock.statements, elseBlock.statements),
                    liveBefore);
        }

        if (statement instanceof LoopRenderedStmt) {
            LoopRenderedStmt loop = (LoopRenderedStmt) statement;
            LinkedHashSet<String> liveBefore = new LinkedHashSet<>(liveAfter);
            addLoopMentions(loop, liveBefore, names);
            return new CleanupStmt(statement, liveBefore);
        }

        BlockRenderedStmt block = (BlockRenderedStmt) statement;
        CleanupBlock cleanedBlock = cleanupRenderedStatements(block.statements, names, liveAfter);
        if (cleanedBlock.statements.isEmpty()) {
            return new CleanupStmt(null, cleanedBlock.liveBefore);
        }
        return new CleanupStmt(new BlockRenderedStmt(cleanedBlock.statements), cleanedBlock.liveBefore);
    }

    // Parses rendered code lines into a hierarchical statement structure preserving
    // control flow
    private List<RenderedStmt> parseRenderedStatements(ParseCursor cursor, ParseStop stop) {
        List<RenderedStmt> statements = new ArrayList<>();
        while (cursor.hasMore()) {
            String trimmed = cursor.peek().trim();
            if (stop == ParseStop.BLOCK_END && "}".equals(trimmed)) {
                cursor.advance();
                break;
            }
            if (stop == ParseStop.IF_ELSE && "} else {".equals(trimmed)) {
                break;
            }
            if (trimmed.startsWith("if (") && trimmed.endsWith("{")) {
                String header = trimmed;
                cursor.advance();
                List<RenderedStmt> thenStatements = parseRenderedStatements(cursor, ParseStop.IF_ELSE);
                if (cursor.hasMore() && "} else {".equals(cursor.peek().trim())) {
                    cursor.advance();
                }
                List<RenderedStmt> elseStatements = parseRenderedStatements(cursor, ParseStop.BLOCK_END);
                statements.add(new IfRenderedStmt(header, thenStatements, elseStatements));
                continue;
            }
            if ((trimmed.startsWith("while (") || trimmed.startsWith("for (")) && trimmed.endsWith("{")) {
                String header = trimmed;
                cursor.advance();
                List<RenderedStmt> bodyStatements = parseRenderedStatements(cursor, ParseStop.BLOCK_END);
                statements.add(new LoopRenderedStmt(header, bodyStatements));
                continue;
            }
            if ("{".equals(trimmed)) {
                cursor.advance();
                List<RenderedStmt> bodyStatements = parseRenderedStatements(cursor, ParseStop.BLOCK_END);
                statements.add(new BlockRenderedStmt(bodyStatements));
                continue;
            }
            statements.add(new SimpleRenderedStmt(trimmed));
            cursor.advance();
        }
        return statements;
    }

    // Converts hierarchical statement structure back to indented code lines
    private List<String> renderRenderedStatements(List<RenderedStmt> statements, int depth) {
        List<String> lines = new ArrayList<>();
        for (RenderedStmt statement : statements) {
            if (statement instanceof SimpleRenderedStmt) {
                lines.add(indentLine(((SimpleRenderedStmt) statement).text, depth));
                continue;
            }
            if (statement instanceof IfRenderedStmt) {
                IfRenderedStmt ifStmt = (IfRenderedStmt) statement;
                lines.add(indentLine(ifStmt.header, depth));
                lines.addAll(renderRenderedStatements(ifStmt.thenStatements, depth + 1));
                lines.add(indentLine("} else {", depth));
                lines.addAll(renderRenderedStatements(ifStmt.elseStatements, depth + 1));
                lines.add(indentLine("}", depth));
                continue;
            }
            if (statement instanceof LoopRenderedStmt) {
                LoopRenderedStmt loop = (LoopRenderedStmt) statement;
                lines.add(indentLine(loop.header, depth));
                lines.addAll(renderRenderedStatements(loop.bodyStatements, depth + 1));
                lines.add(indentLine("}", depth));
                continue;
            }
            BlockRenderedStmt block = (BlockRenderedStmt) statement;
            lines.add(indentLine("{", depth));
            lines.addAll(renderRenderedStatements(block.statements, depth + 1));
            lines.add(indentLine("}", depth));
        }
        return lines;
    }

    private String indentLine(String text, int depth) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < depth; i++) {
            builder.append("    ");
        }
        builder.append(text);
        return builder.toString();
    }

    private boolean shouldSeparateCallEffect(ExprData rhs) {
        return !rhs.removable
                && !rhs.callTargets.isEmpty()
                && !rhs.text.equals(rhs.effectText);
    }

    private Env createLoopRenderEnv(Env base, Statement body, String extraAssigned) {
        Env render = base.copy();
        LinkedHashSet<String> assigned = new LinkedHashSet<>();
        collectAssignedNames(body, assigned);
        if (extraAssigned != null) {
            assigned.add(extraAssigned);
        }
        for (String name : assigned) {
            if (render.values.containsKey(name)) {
                render.values.put(name, AbsValue.nac());
            }
        }
        return render;
    }

    private void collectAssignedNames(Node node, Set<String> out) {
        if (node instanceof Statement) {
            collectAssignedNames(((Statement) node).f0.choice, out);
            return;
        }
        if (node instanceof Block) {
            for (Enumeration<Node> e = ((Block) node).f1.elements(); e.hasMoreElements();) {
                collectAssignedNames((Statement) e.nextElement(), out);
            }
            return;
        }
        if (node instanceof AssignmentStatement) {
            out.add(((AssignmentStatement) node).f0.f0.tokenImage);
            return;
        }
        if (node instanceof ArrayAssignmentStatement) {
            out.add(((ArrayAssignmentStatement) node).f0.f0.tokenImage);
            return;
        }
        if (node instanceof IfStatement) {
            collectAssignedNames(((IfStatement) node).f4, out);
            collectAssignedNames(((IfStatement) node).f6, out);
            return;
        }
        if (node instanceof WhileStatement) {
            collectAssignedNames(((WhileStatement) node).f4, out);
            return;
        }
        if (node instanceof ForStatement) {
            ForStatement stmt = (ForStatement) node;
            out.add(stmt.f2.f0.tokenImage);
            out.add(stmt.f8.f0.tokenImage);
            collectAssignedNames(stmt.f12, out);
        }
    }

    private Set<String> mentionedLocals(List<String> lines, Set<String> names) {
        LinkedHashSet<String> mentioned = new LinkedHashSet<>();
        for (String line : lines) {
            addMentionedNames(line, mentioned, names);
        }
        return mentioned;
    }

    private void addMentionedNames(String text, Set<String> out, Set<String> names) {
        for (String name : names) {
            if (containsWord(text, name)) {
                out.add(name);
            }
        }
    }

    private boolean containsWord(String text, String name) {
        int from = 0;
        while (true) {
            int idx = text.indexOf(name, from);
            if (idx < 0) {
                return false;
            }
            boolean left = idx == 0 || (!Character.isLetterOrDigit(text.charAt(idx - 1))
                    && text.charAt(idx - 1) != '_' && text.charAt(idx - 1) != '.');
            int end = idx + name.length();
            boolean right = end >= text.length()
                    || (!Character.isLetterOrDigit(text.charAt(end)) && text.charAt(end) != '_');
            if (left && right) {
                return true;
            }
            from = idx + 1;
        }
    }

    private boolean looksLikeMethodCall(String rhs) {
        return rhs.contains("(") && rhs.contains(")") && rhs.contains(".");
    }

    private boolean looksLikeAllocation(String rhs) {
        return rhs.startsWith("new ");
    }

    private void addLoopMentions(LoopRenderedStmt loop, Set<String> out, Set<String> names) {
        if (loop.header.startsWith("for (")) {
            ForHeader header = parseForHeader(loop.header);
            if (header != null) {
                addMentionedNames(header.initExpr, out, names);
                addMentionedNamesExcept(header.condExpr, out, names, header.initTarget);
                addMentionedNamesExcept(header.stepExpr, out, names, header.initTarget);
                addMentionedNamesExcept(
                        String.join("\n", renderRenderedStatements(loop.bodyStatements, 0)),
                        out,
                        names,
                        header.initTarget);
                return;
            }
        }
        addMentionedNames(loop.header, out, names);
        addMentionedNames(String.join("\n", renderRenderedStatements(loop.bodyStatements, 0)), out, names);
    }

    private void addMentionedNamesExcept(String text, Set<String> out, Set<String> names, String excluded) {
        if (excluded == null) {
            addMentionedNames(text, out, names);
            return;
        }
        for (String name : names) {
            if (name.equals(excluded)) {
                continue;
            }
            if (containsWord(text, name)) {
                out.add(name);
            }
        }
    }

    private ForHeader parseForHeader(String header) {
        int open = header.indexOf('(');
        int close = header.lastIndexOf(')');
        if (open < 0 || close < 0 || close <= open) {
            return null;
        }
        String inside = header.substring(open + 1, close);
        String[] parts = inside.split(";", 3);
        if (parts.length != 3) {
            return null;
        }
        String init = parts[0].trim();
        String cond = parts[1].trim();
        String step = parts[2].trim();
        int initEq = init.indexOf(" = ");
        int stepEq = step.indexOf(" = ");
        if (initEq < 0 || stepEq < 0) {
            return null;
        }
        return new ForHeader(
                init.substring(0, initEq).trim(),
                init.substring(initEq + 3).trim(),
                cond,
                step.substring(stepEq + 3).trim());
    }

    private AssignmentLine parseSimpleAssignment(String line, Set<String> names) {
        int eq = line.indexOf(" = ");
        if (eq <= 0 || !line.endsWith(";")) {
            return null;
        }
        String target = line.substring(0, eq).trim();
        if (target.contains(".") || target.contains("[") || !names.contains(target)) {
            return null;
        }
        String rhs = line.substring(eq + 3, line.length() - 1).trim();
        return new AssignmentLine(target, rhs);
    }

    private void collectStatementList(NodeListOptional statements, Env env, CollectUsage usage) {
        if (statements == null || !statements.present()) {
            return;

        }
        for (Enumeration<Node> e = statements.elements(); e.hasMoreElements();) {
            collectStatement((Statement) e.nextElement(), env, usage);
        }
    }

    private void collectStatement(Node node, Env env, CollectUsage usage) {
        if (node instanceof Statement) {
            collectStatement(((Statement) node).f0.choice, env, usage);
            return;
        }
        if (node instanceof Block) {
            collectStatementList(((Block) node).f1, env, usage);
            return;
        }
        if (node instanceof AssignmentStatement) {
            AssignmentStatement stmt = (AssignmentStatement) node;
            ExprData rhs = evalExpression(stmt.f2, env, usage);
            if (env.isLocalOrParam(stmt.f0.f0.tokenImage)) {
                assignValue(env, stmt.f0.f0.tokenImage, rhs.value);
            }
            return;
        }
        if (node instanceof VoidMessageSendStatement) {
            evalMessageSend(((VoidMessageSendStatement) node).f0, env, usage);
            return;
        }
        if (node instanceof ArrayAssignmentStatement) {
            ArrayAssignmentStatement stmt = (ArrayAssignmentStatement) node;
            evalConstOrId(stmt.f2, env, usage);
            evalConstOrId(stmt.f5, env, usage);
            invalidateArray(env, stmt.f0.f0.tokenImage);
            return;
        }
        if (node instanceof FieldAssignmentStatement) {
            FieldAssignmentStatement stmt = (FieldAssignmentStatement) node;
            evalConstOrId(stmt.f4, env, usage);
            String owner = model.resolveFieldOwner(env.lookupType(stmt.f0.f0.tokenImage), stmt.f2.f0.tokenImage);
            usage.markFieldUsage(owner, stmt.f2.f0.tokenImage);
            usage.markClassReference(env.lookupType(stmt.f0.f0.tokenImage));
            return;
        }
        if (node instanceof PrintStatement) {
            evalConstOrId(((PrintStatement) node).f2, env, usage);
            return;
        }
        if (node instanceof IfStatement) {
            IfStatement stmt = (IfStatement) node;
            AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
            if (cond.kind == AbsValue.Kind.CONST_BOOL) {
                if (cond.boolValue) {
                    collectStatement(stmt.f4, env, usage);
                } else {
                    collectStatement(stmt.f6, env, usage);
                }
                return;
            }
            usage.markVarUsage(stmt.f2.f0.tokenImage, env);
            Env thenEnv = env.copy();
            Env elseEnv = env.copy();
            collectStatement(stmt.f4, thenEnv, usage);
            collectStatement(stmt.f6, elseEnv, usage);
            env.mergeFrom(thenEnv, elseEnv);
            return;
        }
        if (node instanceof WhileStatement) {
            WhileStatement stmt = (WhileStatement) node;
            AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
            if (cond.kind == AbsValue.Kind.CONST_BOOL && !cond.boolValue) {
                return;
            }
            usage.markVarUsage(stmt.f2.f0.tokenImage, env);
            Env loopEnv = createLoopRenderEnv(env, stmt.f4, null);
            collectStatement(stmt.f4, loopEnv, usage);
            env.mergeFrom(env, loopEnv);
            return;
        }
        if (node instanceof ForStatement) {
            ForStatement stmt = (ForStatement) node;
            ExprData init = evalExpression(stmt.f4, env, usage);
            assignValue(env, stmt.f2.f0.tokenImage, init.value);
            ExprData cond = evalExpression(stmt.f6, env, usage);
            if (cond.value.kind == AbsValue.Kind.CONST_BOOL && !cond.value.boolValue) {
                return;
            }
            Env bodyEnv = createLoopRenderEnv(env, stmt.f12, stmt.f8.f0.tokenImage);
            evalExpression(stmt.f6, bodyEnv, usage);
            collectStatement(stmt.f12, bodyEnv, usage);
            ExprData step = evalExpression(stmt.f10, bodyEnv, usage);
            assignValue(bodyEnv, stmt.f8.f0.tokenImage, step.value);
            env.mergeFrom(env, bodyEnv);
        }
    }

    private List<String> emitStatementList(NodeListOptional statements, Env env, CollectUsage usage,
            OutputBase output) {
        List<String> lines = new ArrayList<>();
        if (statements == null || !statements.present()) {
            return lines;
        }
        for (Enumeration<Node> e = statements.elements(); e.hasMoreElements();) {
            lines.addAll(emitStatement((Statement) e.nextElement(), env, usage, output));
        }
        return lines;
    }

    private List<String> emitStatement(Node node, Env env, CollectUsage usage, OutputBase output) {
        List<String> lines = new ArrayList<>();
        if (node instanceof Statement) {
            return emitStatement(((Statement) node).f0.choice, env, usage, output);
        }
        if (node instanceof Block) {
            List<String> inner = emitStatementList(((Block) node).f1, env, usage, output);
            lines.add("{");
            for (String line : inner) {
                lines.add("    " + line);
            }
            lines.add("}");
            return lines;
        }
        if (node instanceof AssignmentStatement) {
            AssignmentStatement stmt = (AssignmentStatement) node;
            ExprData rhs = evalExpression(stmt.f2, env, usage);
            String target = stmt.f0.f0.tokenImage;
            boolean dead = env.isLocalOrParam(target) && !usage.requiredLocals.contains(target);
            if (env.isField(target) && !env.isLocalOrParam(target)) {
                lines.add(target + " = " + rhs.text + ";");
                output.usedFields.add(env.resolveFieldOwner(target) + "." + target);
                return lines;
            }
            if (dead) {
                assignValue(env, target, rhs.value);
                if (!rhs.removable) {
                    if (!rhs.callTargets.isEmpty()) {
                        lines.add(rhs.effectText + ";");
                        output.calledMethods.addAll(rhs.callTargets);
                    } else {
                        lines.add(target + " = " + rhs.text + ";");
                    }
                }
                return lines;
            }
            if (shouldSeparateCallEffect(rhs)) {
                lines.add(rhs.effectText + ";");
                lines.add(target + " = " + rhs.text + ";");
                assignValue(env, target, rhs.value);
                output.calledMethods.addAll(rhs.callTargets);
                return lines;
            }
            lines.add(target + " = " + rhs.text + ";");
            assignValue(env, target, rhs.value);
            output.calledMethods.addAll(rhs.callTargets);
            return lines;
        }
        if (node instanceof VoidMessageSendStatement) {
            ExprData call = evalMessageSend(((VoidMessageSendStatement) node).f0, env, usage);
            lines.add(call.text + ";");
            output.calledMethods.addAll(call.callTargets);
            return lines;
        }
        if (node instanceof ArrayAssignmentStatement) {
            ArrayAssignmentStatement stmt = (ArrayAssignmentStatement) node;
            ExprData index = evalConstOrId(stmt.f2, env, usage);
            ExprData value = evalConstOrId(stmt.f5, env, usage);
            lines.add(stmt.f0.f0.tokenImage + "[" + index.text + "] = " + value.text + ";");
            invalidateArray(env, stmt.f0.f0.tokenImage);
            return lines;
        }
        if (node instanceof FieldAssignmentStatement) {
            FieldAssignmentStatement stmt = (FieldAssignmentStatement) node;
            ExprData value = evalConstOrId(stmt.f4, env, usage);
            lines.add(stmt.f0.f0.tokenImage + "." + stmt.f2.f0.tokenImage + " = " + value.text + ";");
            String owner = model.resolveFieldOwner(env.lookupType(stmt.f0.f0.tokenImage), stmt.f2.f0.tokenImage);
            if (owner != null) {
                output.usedFields.add(owner + "." + stmt.f2.f0.tokenImage);
            }
            return lines;
        }
        if (node instanceof PrintStatement) {
            ExprData value = evalConstOrId(((PrintStatement) node).f2, env, usage);
            lines.add("System.out.println(" + value.text + ");");
            return lines;
        }
        if (node instanceof IfStatement) {
            IfStatement stmt = (IfStatement) node;
            AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
            if (cond.kind == AbsValue.Kind.CONST_BOOL) {
                if (cond.boolValue) {
                    return emitStructuredBody(stmt.f4, env, usage, output);
                }
                return emitStructuredBody(stmt.f6, env, usage, output);
            }
            lines.add("if (" + stmt.f2.f0.tokenImage + ") {");
            Env thenEnv = env.copy();
            List<String> thenLines = emitStructuredBody(stmt.f4, thenEnv, usage, output);
            for (String line : thenLines) {
                lines.add("    " + line);
            }
            lines.add("} else {");
            Env elseEnv = env.copy();
            List<String> elseLines = emitStructuredBody(stmt.f6, elseEnv, usage, output);
            for (String line : elseLines) {
                lines.add("    " + line);
            }
            lines.add("}");
            env.mergeFrom(thenEnv, elseEnv);
            return lines;
        }
        if (node instanceof WhileStatement) {
            WhileStatement stmt = (WhileStatement) node;
            AbsValue cond = env.lookupValue(stmt.f2.f0.tokenImage);
            if (cond.kind == AbsValue.Kind.CONST_BOOL && !cond.boolValue) {
                return lines;
            }
            lines.add("while (" + stmt.f2.f0.tokenImage + ") {");
            Env renderEnv = createLoopRenderEnv(env, stmt.f4, null);
            List<String> bodyLines = emitStructuredBody(stmt.f4, renderEnv, usage, output);
            for (String line : bodyLines) {
                lines.add("    " + line);
            }
            lines.add("}");
            Env loopEnv = env.copy();
            simulateStatement(stmt.f4, loopEnv);
            env.mergeFrom(env, loopEnv);
            return lines;
        }
        if (node instanceof ForStatement) {
            ForStatement stmt = (ForStatement) node;
            ExprData init = evalExpression(stmt.f4, env, usage);
            assignValue(env, stmt.f2.f0.tokenImage, init.value);
            ExprData cond = evalExpression(stmt.f6, env, usage);
            if (cond.value.kind == AbsValue.Kind.CONST_BOOL && !cond.value.boolValue) {
                lines.add(stmt.f2.f0.tokenImage + " = " + init.text + ";");
                return lines;
            }
            Env renderEnv = createLoopRenderEnv(env, stmt.f12, stmt.f8.f0.tokenImage);
            ExprData renderCond = evalExpression(stmt.f6, renderEnv, usage);
            ExprData step = evalExpression(stmt.f10, renderEnv, usage);
            lines.add("for (" + stmt.f2.f0.tokenImage + " = " + init.text + "; "
                    + renderCond.text + "; " + stmt.f8.f0.tokenImage + " = " + step.text + ") {");
            List<String> bodyLines = emitStructuredBody(stmt.f12, renderEnv, usage, output);
            for (String line : bodyLines) {
                lines.add("    " + line);
            }
            lines.add("}");
            Env bodyEnv = env.copy();
            simulateStatement(stmt.f12, bodyEnv);
            ExprData stepValue = evalExpression(stmt.f10, bodyEnv, null);
            assignValue(bodyEnv, stmt.f8.f0.tokenImage, stepValue.value);
            env.mergeFrom(env, bodyEnv);
            return lines;
        }
        return lines;
    }

    private List<String> emitStructuredBody(Statement statement, Env env, CollectUsage usage, OutputBase output) {
        if (statement.f0.choice instanceof Block) {
            return emitStatementList(((Block) statement.f0.choice).f1, env, usage, output);
        }
        return emitStatement(statement, env, usage, output);
    }

    // Outputs the main class definition with optimized code to the result buffer
    private void emitMain(MainOutput output) {
        emit("class " + model.mainClassName + " {");
        indent++;
        emit("public static void main(String[] " + model.mainArgName + ") {");
        indent++;
        for (VarInfo var : model.mainLocals) {
            if (output.requiredLocals.contains(var.name)) {
                markClassFromType(var.type);
                emit(var.type + " " + var.name + ";");
            }
        }
        for (String line : output.lines) {
            emit(line);
        }
        indent--;
        emit("}");
        indent--;
        emit("}");
    }

    // Outputs a class definition with only kept fields and methods to the result
    // buffer
    private void emitClass(ClassInfo classInfo) {
        if (classInfo.parentClass == null) {
            emit("class " + classInfo.name + " {");
        } else {
            emit("class " + classInfo.name + " extends " + classInfo.parentClass + " {");
        }
        indent++;

        Set<String> keptFieldNames = keptFieldsByClass.getOrDefault(classInfo.name, Collections.emptySet());
        for (FieldInfo field : classInfo.fieldsInOrder) {
            if (keptFieldNames.contains(field.name)) {
                markClassFromType(field.type);
                emit(field.type + " " + field.name + ";");
            }
        }

        for (MethodInfo method : classInfo.methodsInOrder) {
            if (!keptMethods.contains(method.key)) {
                continue;
            }
            MethodOutput output = methodOutputCache.get(method.key);
            emitMethod(method, output);
        }

        indent--;
        emit("}");
    }

    // Outputs a method definition with optimized code to the result buffer
    private void emitMethod(MethodInfo method, MethodOutput output) {
        StringBuilder params = new StringBuilder();
        for (int i = 0; i < method.params.size(); i++) {
            ParamInfo param = method.params.get(i);
            if (i > 0) {
                params.append(", ");
            }
            params.append(param.type).append(" ").append(param.name);
            markClassFromType(param.type);
        }
        markClassFromType(method.returnType);
        emit("public " + method.returnType + " " + method.name + "(" + params + ") {");
        indent++;
        for (VarInfo var : method.localsInOrder) {
            if (output.requiredLocals.contains(var.name)) {
                markClassFromType(var.type);
                emit(var.type + " " + var.name + ";");
            }
        }
        for (String line : output.lines) {
            emit(line);
        }
        emit("return " + output.returnText + ";");
        indent--;
        emit("}");
    }

    // Appends a properly indented line to the output buffer
    private void emit(String line) {
        for (int i = 0; i < indent; i++) {
            out.append("    ");
        }
        out.append(line).append('\n');
    }

    // Collects all classes that must be kept because they are used by main or kept
    // methods
    private Set<String> keptClassesFromMethodsAndMain() {
        LinkedHashSet<String> result = new LinkedHashSet<>();
        result.addAll(mainOutput.usedClasses);
        for (String fieldRef : mainOutput.usedFields) {
            addKeptField(fieldRef);
        }
        for (MethodKey methodKey : keptMethods) {
            MethodInfo method = methodStates.get(methodKey).method;
            result.add(method.ownerClass);
            MethodOutput output = methodOutputCache.get(methodKey);
            result.addAll(output.usedClasses);
            for (String fieldRef : output.usedFields) {
                addKeptField(fieldRef);
            }
        }
        return result;
    }

    // Marks a field as kept and adds its owner class to the kept set
    private void addKeptField(String fieldRef) {
        int idx = fieldRef.indexOf('.');
        if (idx < 0) {
            return;
        }
        String owner = fieldRef.substring(0, idx);
        String field = fieldRef.substring(idx + 1);
        keptFieldsByClass.computeIfAbsent(owner, key -> new LinkedHashSet<>()).add(field);
        keptClasses.add(owner);
    }

    // Transitively adds parent classes to the kept set to maintain inheritance
    // relationships
    private void addAncestorsOfKeptClasses() {
        boolean changed = true;
        while (changed) {
            changed = false;
            List<String> snapshot = new ArrayList<>(keptClasses);
            for (String className : snapshot) {
                ClassInfo info = model.classes.get(className);
                if (info != null && info.parentClass != null && keptClasses.add(info.parentClass)) {
                    changed = true;
                }
            }
        }
    }

    // Checks if a class has at least one field that must be kept
    private boolean hasKeptField(String className) {
        return keptFieldsByClass.containsKey(className) && !keptFieldsByClass.get(className).isEmpty();
    }

    // Checks if a class has at least one method that must be kept
    private boolean hasKeptMethodInClass(String className) {
        for (MethodKey key : keptMethods) {
            if (key.ownerClass.equals(className)) {
                return true;
            }
        }
        return false;
    }

    // Marks a class as used based on its occurrence in a type annotation
    private void markClassFromType(String type) {
        if (type == null || "int".equals(type) || "boolean".equals(type) || "int[]".equals(type)) {
            return;
        }
        keptClasses.add(type);
    }

    private static final class AnalysisResult {
        final List<CallEdge> calls = new ArrayList<>();
        AbsValue returnValue;
        boolean hasSideEffect;
    }

    private static final class CallEdge {
        final List<MethodKey> callees;
        final List<AbsValue> actuals;

        CallEdge(List<MethodKey> callees, List<AbsValue> actuals) {
            this.callees = callees;
            this.actuals = actuals;
        }
    }

    private static final class MethodState {
        final MethodInfo method;
        final Map<String, AbsValue> formals = new LinkedHashMap<>();
        AbsValue returnValue;
        boolean reachable;

        MethodState(MethodInfo method) {
            this.method = method;
        }
    }

    private static final class CallerId {
        final boolean isMain;
        final MethodKey methodKey;

        private CallerId(boolean isMain, MethodKey methodKey) {
            this.isMain = isMain;
            this.methodKey = methodKey;
        }

        static CallerId main() {
            return new CallerId(true, null);
        }

        static CallerId method(MethodKey key) {
            return new CallerId(false, key);
        }

        @Override
        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof CallerId)) {
                return false;
            }
            CallerId that = (CallerId) other;
            return isMain == that.isMain && Objects.equals(methodKey, that.methodKey);
        }

        @Override
        public int hashCode() {
            return Objects.hash(isMain, methodKey);
        }
    }

    private static final class ExprData {
        final String text;
        final String effectText;
        final AbsValue value;
        final String staticType;
        final boolean removable;
        final List<MethodKey> callTargets;

        private ExprData(String text, String effectText, AbsValue value, String staticType, boolean removable,
                List<MethodKey> callTargets) {
            this.text = text;
            this.effectText = effectText;
            this.value = value;
            this.staticType = staticType;
            this.removable = removable;
            this.callTargets = callTargets;
        }

        static ExprData literal(String text, AbsValue value) {
            return new ExprData(text, text, value, null, true, Collections.emptyList());
        }

        static ExprData simple(String text, AbsValue value) {
            return new ExprData(text, text, value, null, true, Collections.emptyList());
        }

        static ExprData withType(String text, AbsValue value, String staticType) {
            return new ExprData(text, text, value, staticType, true, Collections.emptyList());
        }

        static ExprData effectfulWithType(String text, AbsValue value, String staticType) {
            return new ExprData(text, text, value, staticType, false, Collections.emptyList());
        }

        static ExprData call(String text, String effectText, AbsValue value, boolean removable,
                Set<MethodKey> targets, String staticType) {
            return new ExprData(text, effectText, value, staticType, removable, new ArrayList<>(targets));
        }
    }

    public static final class Env {
        final String className;
        final ProgramModel model;
        final Map<String, String> types = new LinkedHashMap<>();
        final Map<String, AbsValue> values = new LinkedHashMap<>();
        final Set<String> localNames = new HashSet<>();
        final Set<String> paramNames = new HashSet<>();
        final Set<String> fieldNames = new HashSet<>();
        AnalysisResult analysisResult;

        Env(String className, ProgramModel model) {
            this.className = className;
            this.model = model;
        }

        static Env forMain(ProgramModel model) {
            Env env = new Env(model.mainClassName, model);
            for (VarInfo var : model.mainLocals) {
                env.types.put(var.name, var.type);
                env.values.put(var.name, AbsValue.undef());
                env.localNames.add(var.name);
            }
            return env;
        }

        static Env forMethod(ProgramModel model, MethodInfo method, Map<String, AbsValue> inputs) {
            Env env = new Env(method.ownerClass, model);
            for (FieldInfo field : model.collectFields(method.ownerClass)) {
                env.types.put(field.name, field.type);
                env.values.put(field.name, AbsValue.nac());
                env.fieldNames.add(field.name);
            }
            for (ParamInfo param : method.params) {
                env.types.put(param.name, param.type);
                env.values.put(param.name, inputs.getOrDefault(param.name, AbsValue.undef()));
                env.paramNames.add(param.name);
            }
            for (VarInfo var : method.localsInOrder) {
                env.types.put(var.name, var.type);
                env.values.put(var.name, AbsValue.undef());
                env.localNames.add(var.name);
            }
            return env;
        }

        Env copy() {
            Env copy = new Env(className, model);
            copy.types.putAll(types);
            copy.values.putAll(values);
            copy.localNames.addAll(localNames);
            copy.paramNames.addAll(paramNames);
            copy.fieldNames.addAll(fieldNames);
            copy.analysisResult = analysisResult;
            return copy;
        }

        void mergeFrom(Env left, Env right) {
            LinkedHashSet<String> names = new LinkedHashSet<>();
            names.addAll(left.values.keySet());
            names.addAll(right.values.keySet());
            for (String name : names) {
                values.put(name, AbsValue.meet(left.values.get(name), right.values.get(name)));
            }
        }

        boolean sameValues(Env other) {
            return values.equals(other.values);
        }

        String lookupType(String name) {
            return types.get(name);
        }

        AbsValue lookupValue(String name) {
            return values.getOrDefault(name, AbsValue.nac());
        }

        boolean isField(String name) {
            return fieldNames.contains(name);
        }

        boolean isLocalOrParam(String name) {
            return localNames.contains(name) || paramNames.contains(name);
        }

        String resolveFieldOwner(String fieldName) {
            return model.resolveFieldOwner(className, fieldName);
        }
    }

    private interface Usage {
        void markVarUsage(String name, Env env);

        void markFieldUsage(String ownerClass, String fieldName);

        void markClassReference(String className);

        void recordCallTargets(Set<MethodKey> targets);
    }

    private static final class CollectUsage implements Usage {
        final Set<String> requiredLocals = new LinkedHashSet<>();
        final Set<String> usedFields = new LinkedHashSet<>();
        final Set<String> referencedClasses = new LinkedHashSet<>();
        final Set<MethodKey> callTargets = new LinkedHashSet<>();

        @Override
        public void markVarUsage(String name, Env env) {
            if (env.isLocalOrParam(name)) {
                requiredLocals.add(name);
            } else if (env.isField(name)) {
                String owner = env.resolveFieldOwner(name);
                markFieldUsage(owner, name);
            }
        }

        @Override
        public void markFieldUsage(String ownerClass, String fieldName) {
            if (ownerClass != null && fieldName != null) {
                usedFields.add(ownerClass + "." + fieldName);
            }
        }

        @Override
        public void markClassReference(String className) {
            if (className != null && !"int".equals(className) && !"boolean".equals(className)
                    && !"int[]".equals(className)) {
                referencedClasses.add(className);
            }
        }

        @Override
        public void recordCallTargets(Set<MethodKey> targets) {
            callTargets.addAll(targets);
        }
    }

    private static final class ReachabilityUsage implements Usage {
        final ReachabilityInfo info = new ReachabilityInfo();

        @Override
        public void markVarUsage(String name, Env env) {
        }

        @Override
        public void markFieldUsage(String ownerClass, String fieldName) {
        }

        @Override
        public void markClassReference(String className) {
        }

        @Override
        public void recordCallTargets(Set<MethodKey> targets) {
            info.callees.addAll(targets);
        }
    }

    private abstract static class OutputBase {
        final Set<MethodKey> calledMethods = new LinkedHashSet<>();
        final Set<String> usedFields = new LinkedHashSet<>();
        final Set<String> usedClasses = new LinkedHashSet<>();
    }

    private static final class MainOutput extends OutputBase {
        final List<String> lines = new ArrayList<>();
        Set<String> requiredLocals = Collections.emptySet();
    }

    private static final class MethodOutput extends OutputBase {
        final List<String> lines = new ArrayList<>();
        Set<String> requiredLocals = Collections.emptySet();
        String returnText;
    }

    private static final class ReachabilityInfo {
        final Set<MethodKey> callees = new LinkedHashSet<>();
        boolean hasObservableEffect;
        boolean hasLoopKeepCondition;
    }

    private static final class AssignmentLine {
        final String target;
        final String rhs;

        AssignmentLine(String target, String rhs) {
            this.target = target;
            this.rhs = rhs;
        }
    }

    private enum ParseStop {
        END,
        BLOCK_END,
        IF_ELSE
    }

    private static final class ParseCursor {
        final List<String> lines;
        int index;

        ParseCursor(List<String> lines) {
            this.lines = lines;
        }

        boolean hasMore() {
            return index < lines.size();
        }

        String peek() {
            return lines.get(index);
        }

        void advance() {
            index++;
        }
    }

    private interface RenderedStmt {
    }

    private static final class SimpleRenderedStmt implements RenderedStmt {
        final String text;

        SimpleRenderedStmt(String text) {
            this.text = text;
        }
    }

    private static final class IfRenderedStmt implements RenderedStmt {
        final String header;
        final List<RenderedStmt> thenStatements;
        final List<RenderedStmt> elseStatements;

        IfRenderedStmt(String header, List<RenderedStmt> thenStatements, List<RenderedStmt> elseStatements) {
            this.header = header;
            this.thenStatements = thenStatements;
            this.elseStatements = elseStatements;
        }
    }

    private static final class LoopRenderedStmt implements RenderedStmt {
        final String header;
        final List<RenderedStmt> bodyStatements;

        LoopRenderedStmt(String header, List<RenderedStmt> bodyStatements) {
            this.header = header;
            this.bodyStatements = bodyStatements;
        }
    }

    private static final class BlockRenderedStmt implements RenderedStmt {
        final List<RenderedStmt> statements;

        BlockRenderedStmt(List<RenderedStmt> statements) {
            this.statements = statements;
        }
    }

    private static final class CleanupStmt {
        final RenderedStmt statement;
        final LinkedHashSet<String> liveBefore;

        CleanupStmt(RenderedStmt statement, LinkedHashSet<String> liveBefore) {
            this.statement = statement;
            this.liveBefore = liveBefore;
        }
    }

    private static final class CleanupBlock {
        final List<RenderedStmt> statements;
        final LinkedHashSet<String> liveBefore;

        CleanupBlock(List<RenderedStmt> statements, LinkedHashSet<String> liveBefore) {
            this.statements = statements;
            this.liveBefore = liveBefore;
        }
    }

    private static final class ForHeader {
        final String initTarget;
        final String initExpr;
        final String condExpr;
        final String stepExpr;

        ForHeader(String initTarget, String initExpr, String condExpr, String stepExpr) {
            this.initTarget = initTarget;
            this.initExpr = initExpr;
            this.condExpr = condExpr;
            this.stepExpr = stepExpr;
        }
    }

    private static final class MethodKey {
        final String ownerClass;
        final String name;

        MethodKey(String ownerClass, String name) {
            this.ownerClass = ownerClass;
            this.name = name;
        }

        @Override
        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof MethodKey)) {
                return false;
            }
            MethodKey that = (MethodKey) other;
            return Objects.equals(ownerClass, that.ownerClass) && Objects.equals(name, that.name);
        }

        @Override
        public int hashCode() {
            return Objects.hash(ownerClass, name);
        }
    }

    private static final class ProgramModel {
        final LinkedHashMap<String, ClassInfo> classes = new LinkedHashMap<>();
        final List<MethodInfo> methodsInOrder = new ArrayList<>();
        MainClass mainClass;
        String mainClassName;
        String mainArgName;
        final List<VarInfo> mainLocals = new ArrayList<>();

        void clear() {
            classes.clear();
            methodsInOrder.clear();
            mainClass = null;
            mainClassName = null;
            mainArgName = null;
            mainLocals.clear();
        }

        ClassInfo ensureClass(String name) {
            return classes.computeIfAbsent(name, ClassInfo::new);
        }

        MethodInfo resolveDeclaredMethod(String className, String methodName) {
            String current = className;
            while (current != null) {
                ClassInfo info = classes.get(current);
                if (info == null) {
                    return null;
                }
                MethodInfo method = info.methods.get(methodName);
                if (method != null) {
                    return method;
                }
                current = info.parentClass;
            }
            return null;
        }

        LinkedHashSet<MethodKey> possibleDispatchTargets(String staticType, String methodName) {
            LinkedHashSet<MethodKey> result = new LinkedHashSet<>();
            if (staticType == null || "int".equals(staticType) || "boolean".equals(staticType)
                    || "int[]".equals(staticType)) {
                return result;
            }
            for (String className : classes.keySet()) {
                if (isSubtype(className, staticType)) {
                    MethodInfo method = resolveDeclaredMethod(className, methodName);
                    if (method != null) {
                        result.add(method.key);
                    }
                }
            }
            return result;
        }

        LinkedHashSet<MethodKey> findMethodsByName(String methodName) {
            LinkedHashSet<MethodKey> result = new LinkedHashSet<>();
            for (MethodInfo method : methodsInOrder) {
                if (method.name.equals(methodName)) {
                    result.add(method.key);
                }
            }
            return result;
        }

        boolean isSubtype(String className, String parent) {
            String current = className;
            while (current != null) {
                if (current.equals(parent)) {
                    return true;
                }
                ClassInfo info = classes.get(current);
                current = info == null ? null : info.parentClass;
            }
            return false;
        }

        List<FieldInfo> collectFields(String className) {
            List<FieldInfo> lineage = new ArrayList<>();
            String current = className;
            List<ClassInfo> infos = new ArrayList<>();
            while (current != null) {
                ClassInfo info = classes.get(current);
                if (info == null) {
                    break;
                }
                infos.add(info);
                current = info.parentClass;
            }
            for (int i = infos.size() - 1; i >= 0; i--) {
                lineage.addAll(infos.get(i).fieldsInOrder);
            }
            return lineage;
        }

        String resolveFieldOwner(String className, String fieldName) {
            String current = className;
            while (current != null) {
                ClassInfo info = classes.get(current);
                if (info == null) {
                    return null;
                }
                if (info.fields.containsKey(fieldName)) {
                    return current;
                }
                current = info.parentClass;
            }
            return null;
        }
    }

    private static final class ClassInfo {
        final String name;
        String parentClass;
        final LinkedHashMap<String, FieldInfo> fields = new LinkedHashMap<>();
        final List<FieldInfo> fieldsInOrder = new ArrayList<>();
        final LinkedHashMap<String, MethodInfo> methods = new LinkedHashMap<>();
        final List<MethodInfo> methodsInOrder = new ArrayList<>();

        ClassInfo(String name) {
            this.name = name;
        }
    }

    private static final class FieldInfo {
        final String name;
        final String type;

        FieldInfo(String name, String type) {
            this.name = name;
            this.type = type;
        }
    }

    private static final class VarInfo {
        final String name;
        final String type;

        VarInfo(String name, String type) {
            this.name = name;
            this.type = type;
        }
    }

    private static final class MethodInfo {
        final MethodKey key;
        final String ownerClass;
        final String name;
        final String returnType;
        final MethodDeclaration node;
        final List<ParamInfo> params = new ArrayList<>();
        final List<VarInfo> localsInOrder = new ArrayList<>();

        MethodInfo(String ownerClass, String name, String returnType, MethodDeclaration node) {
            this.ownerClass = ownerClass;
            this.name = name;
            this.returnType = returnType;
            this.node = node;
            this.key = new MethodKey(ownerClass, name);
        }
    }

    private static final class ParamInfo {
        final String type;
        final String name;

        ParamInfo(String type, String name) {
            this.type = type;
            this.name = name;
        }
    }

    private static final class AbsValue {
        enum Kind {
            UNDEF,
            NAC,
            CONST_INT,
            CONST_BOOL,
            ARRAY
        }

        final Kind kind;
        final Integer intValue;
        final Boolean boolValue;
        final Integer arrayLength;

        private AbsValue(Kind kind, Integer intValue, Boolean boolValue, Integer arrayLength) {
            this.kind = kind;
            this.intValue = intValue;
            this.boolValue = boolValue;
            this.arrayLength = arrayLength;
        }

        static AbsValue undef() {
            return new AbsValue(Kind.UNDEF, null, null, null);
        }

        static AbsValue nac() {
            return new AbsValue(Kind.NAC, null, null, null);
        }

        static AbsValue constInt(int value) {
            return new AbsValue(Kind.CONST_INT, value, null, null);
        }

        static AbsValue constBool(boolean value) {
            return new AbsValue(Kind.CONST_BOOL, null, value, null);
        }

        static AbsValue array(Integer length) {
            return new AbsValue(Kind.ARRAY, null, null, length);
        }

        static AbsValue meet(AbsValue left, AbsValue right) {
            if (left == null || left.kind == Kind.UNDEF) {
                return right == null ? undef() : right;
            }
            if (right == null || right.kind == Kind.UNDEF) {
                return left;
            }
            if (left.kind == Kind.NAC || right.kind == Kind.NAC) {
                return nac();
            }
            if (left.kind != right.kind) {
                return nac();
            }
            if (left.kind == Kind.CONST_INT) {
                return Objects.equals(left.intValue, right.intValue) ? left : nac();
            }
            if (left.kind == Kind.CONST_BOOL) {
                return Objects.equals(left.boolValue, right.boolValue) ? left : nac();
            }
            if (left.kind == Kind.ARRAY) {
                return Objects.equals(left.arrayLength, right.arrayLength) ? left : nac();
            }
            return nac();
        }

        String renderLiteral() {
            if (kind == Kind.CONST_INT) {
                return Integer.toString(intValue);
            }
            if (kind == Kind.CONST_BOOL) {
                return Boolean.toString(boolValue);
            }
            return null;
        }

        @Override
        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof AbsValue)) {
                return false;
            }
            AbsValue that = (AbsValue) other;
            return kind == that.kind
                    && Objects.equals(intValue, that.intValue)
                    && Objects.equals(boolValue, that.boolValue)
                    && Objects.equals(arrayLength, that.arrayLength);
        }

        @Override
        public int hashCode() {
            return Objects.hash(kind, intValue, boolValue, arrayLength);
        }
    }

    private static final class Tarjan {
        private final Map<MethodKey, ReachabilityInfo> graph;
        private final Map<MethodKey, Integer> index = new HashMap<>();
        private final Map<MethodKey, Integer> lowlink = new HashMap<>();
        private final ArrayDeque<MethodKey> stack = new ArrayDeque<>();
        private final Set<MethodKey> onStack = new HashSet<>();
        private int nextIndex = 0;

        Tarjan(Map<MethodKey, ReachabilityInfo> graph) {
            this.graph = graph;
        }

        Set<MethodKey> computeRecursiveMethods() {
            Set<MethodKey> recursive = new HashSet<>();
            for (MethodKey node : graph.keySet()) {
                if (!index.containsKey(node)) {
                    strongConnect(node, recursive);
                }
            }
            return recursive;
        }

        private void strongConnect(MethodKey node, Set<MethodKey> recursive) {
            index.put(node, nextIndex);
            lowlink.put(node, nextIndex);
            nextIndex++;
            stack.push(node);
            onStack.add(node);

            for (MethodKey next : graph.get(node).callees) {
                if (!graph.containsKey(next)) {
                    continue;
                }
                if (!index.containsKey(next)) {
                    strongConnect(next, recursive);
                    lowlink.put(node, Math.min(lowlink.get(node), lowlink.get(next)));
                } else if (onStack.contains(next)) {
                    lowlink.put(node, Math.min(lowlink.get(node), index.get(next)));
                }
            }

            if (Objects.equals(lowlink.get(node), index.get(node))) {
                List<MethodKey> component = new ArrayList<>();
                MethodKey member;
                do {
                    member = stack.pop();
                    onStack.remove(member);
                    component.add(member);
                } while (!member.equals(node));

                if (component.size() > 1) {
                    recursive.addAll(component);
                    return;
                }
                MethodKey only = component.get(0);
                if (graph.get(only).callees.contains(only)) {
                    recursive.add(only);
                }
            }
        }
    }

    private final class ModelCollector extends GJDepthFirst<Void, String[]> {
        @Override
        public Void visit(Goal n, String[] scope) {
            n.f0.accept(this, scope);
            n.f1.accept(this, scope);
            return null;
        }

        @Override
        public Void visit(MainClass n, String[] scope) {
            model.mainClass = n;
            model.mainClassName = n.f1.f0.tokenImage;
            model.mainArgName = n.f11.f0.tokenImage;
            for (Enumeration<Node> e = n.f14.elements(); e.hasMoreElements();) {
                VarDeclaration decl = (VarDeclaration) e.nextElement();
                model.mainLocals.add(new VarInfo(decl.f1.f0.tokenImage, typeToString(decl.f0)));
            }
            return null;
        }

        @Override
        public Void visit(TypeDeclaration n, String[] scope) {
            n.f0.accept(this, scope);
            return null;
        }

        @Override
        public Void visit(ClassDeclaration n, String[] scope) {
            String className = n.f1.f0.tokenImage;
            ClassInfo info = model.ensureClass(className);
            info.parentClass = null;
            String[] classScope = new String[] { className, null };
            n.f3.accept(this, classScope);
            n.f4.accept(this, classScope);
            return null;
        }

        @Override
        public Void visit(ClassExtendsDeclaration n, String[] scope) {
            String className = n.f1.f0.tokenImage;
            ClassInfo info = model.ensureClass(className);
            info.parentClass = n.f3.f0.tokenImage;
            String[] classScope = new String[] { className, null };
            n.f5.accept(this, classScope);
            n.f6.accept(this, classScope);
            return null;
        }

        @Override
        public Void visit(VarDeclaration n, String[] scope) {
            String className = scope[0];
            String methodName = scope[1];
            String type = typeToString(n.f0);
            String name = n.f1.f0.tokenImage;
            ClassInfo info = model.ensureClass(className);
            if (methodName == null) {
                FieldInfo field = new FieldInfo(name, type);
                info.fields.put(name, field);
                info.fieldsInOrder.add(field);
            } else {
                MethodInfo method = info.methods.get(methodName);
                method.localsInOrder.add(new VarInfo(name, type));
            }
            return null;
        }

        @Override
        public Void visit(MethodDeclaration n, String[] scope) {
            String className = scope[0];
            String methodName = n.f2.f0.tokenImage;
            String returnType = typeToString(n.f1);
            ClassInfo info = model.ensureClass(className);
            MethodInfo method = new MethodInfo(className, methodName, returnType, n);
            info.methods.put(methodName, method);
            info.methodsInOrder.add(method);
            model.methodsInOrder.add(method);

            if (n.f4.present()) {
                FormalParameterList params = (FormalParameterList) n.f4.node;
                collectParam(params.f0, method);
                for (Enumeration<Node> e = params.f1.elements(); e.hasMoreElements();) {
                    FormalParameterRest rest = (FormalParameterRest) e.nextElement();
                    collectParam(rest.f1, method);
                }
            }

            String[] methodScope = new String[] { className, methodName };
            n.f7.accept(this, methodScope);
            return null;
        }

        private void collectParam(FormalParameter parameter, MethodInfo method) {
            method.params.add(new ParamInfo(typeToString(parameter.f0), parameter.f1.f0.tokenImage));
        }
    }

    private String typeToString(Type type) {
        Node choice = type.f0.choice;
        if (choice instanceof IntegerType) {
            return "int";
        }
        if (choice instanceof BooleanType) {
            return "boolean";
        }
        if (choice instanceof ArrayType) {
            return "int[]";
        }
        return ((Identifier) choice).f0.tokenImage;
    }
}
