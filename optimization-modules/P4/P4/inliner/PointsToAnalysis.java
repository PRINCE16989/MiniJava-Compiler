package inliner;

import java.util.ArrayList;
import java.util.Collections;
import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import syntaxtree.AllocationExpression;
import syntaxtree.ArrayAllocationExpression;
import syntaxtree.ArrayAssignmentStatement;
import syntaxtree.AssignmentStatement;
import syntaxtree.Block;
import syntaxtree.ConstOrId;
import syntaxtree.DotExpression;
import syntaxtree.Expression;
import syntaxtree.FieldAssignmentStatement;
import syntaxtree.ForStatement;
import syntaxtree.Identifier;
import syntaxtree.IfStatement;
import syntaxtree.MessageSend;
import syntaxtree.MessageSendStatement;
import syntaxtree.NotExpression;
import syntaxtree.PrimaryExpression;
import syntaxtree.PrintStatement;
import syntaxtree.RetMessageSendStmt;
import syntaxtree.RhsExpression;
import syntaxtree.ThisExpression;
import syntaxtree.VoidMessageSendStmt;
import syntaxtree.WhileStatement;
import visitor.GJDepthFirst;
import visitor.GJVoidDepthFirst;

public final class PointsToAnalysis extends GJVoidDepthFirst<PointsToAnalysis.FlowContext> {
    private final ProgramModel model;
    private final AnalysisResult result;
    private final ValueVisitor valueVisitor = new ValueVisitor();
    private final StaticPrimaryVisitor staticPrimaryVisitor = new StaticPrimaryVisitor();
    private final ReturnVariableVisitor returnVariableVisitor = new ReturnVariableVisitor();
    private final Map<String, MethodSummary> summaries = new LinkedHashMap<String, MethodSummary>();
    private final Set<String> activeContexts = new LinkedHashSet<String>();
    private final Set<ProgramModel.MethodInfo> methodsWithContext =
        Collections.newSetFromMap(new IdentityHashMap<ProgramModel.MethodInfo, Boolean>());

    private PointsToAnalysis(ProgramModel model) {
        this.model = model;
        this.result = new AnalysisResult(model);
    }

    public static AnalysisResult analyze(ProgramModel model) {
        PointsToAnalysis analysis = new PointsToAnalysis(model);
        if (model.mainMethod != null) {
            analysis.analyzeContext(model.mainMethod, ValueSet.of(model.mainMethod.owner.name),
                Collections.<ValueSet>emptyList(), null);
        }
        for (ProgramModel.MethodInfo method : model.methods()) {
            if (!analysis.methodsWithContext.contains(method)) {
                analysis.analyzeContext(method, analysis.genericThis(method),
                    analysis.genericArgs(method), null);
            }
        }
        analysis.result.finish();
        return analysis.result;
    }

    private MethodSummary analyzeContext(
        ProgramModel.MethodInfo method,
        ValueSet thisValue,
        List<ValueSet> argValues,
        Env heapInput
    ) {
        String key = contextKey(method, thisValue, argValues, heapInput);
        MethodSummary cached = summaries.get(key);
        if (cached != null) {
            return cached;
        }
        if (activeContexts.contains(key)) {
            return MethodSummary.recursiveFallback(possibleForType(method.returnType));
        }

        activeContexts.add(key);
        methodsWithContext.add(method);

        Env env = initialEnv(method, thisValue, argValues, heapInput);
        FlowContext context = new FlowContext(method, env);
        method.statements.accept(this, context);
        Env exit = context.env;
        ValueSet returnValue =
            method.returnValue == null ? ValueSet.EMPTY : valueOfConstOrId(method.returnValue, method, exit);
        MethodSummary summary = new MethodSummary(returnValue, exit);

        summaries.put(key, summary);
        activeContexts.remove(key);
        return summary;
    }

    private Env initialEnv(
        ProgramModel.MethodInfo method,
        ValueSet thisValue,
        List<ValueSet> argValues,
        Env heapInput
    ) {
        Env env = new Env();
        if (heapInput != null) {
            env.mergeFields(heapInput);
        }
        env.put("this", thisValue);
        for (int i = 0; i < method.params.size(); i++) {
            ProgramModel.VarInfo param = method.params.get(i);
            ValueSet value = i < argValues.size() ? argValues.get(i) : possibleForType(param.type);
            env.put(param.name, value);
        }
        for (ProgramModel.VarInfo local : method.locals) {
            env.put(local.name, ValueSet.EMPTY);
        }
        return env;
    }

    private MethodSummary analyzeCall(
        MessageSend message,
        ProgramModel.MethodInfo caller,
        Env env,
        ResolveResult resolved
    ) {
        ValueSet resultValue = ValueSet.EMPTY;
        Env exitEnv = env.copy();
        if (resolved.targets.isEmpty()) {
            return new MethodSummary(resultValue, exitEnv);
        }

        List<ValueSet> args = argValues(message, caller, env);
        for (ProgramModel.MethodInfo target : resolved.targets) {
            ValueSet targetThis = receiverTypesForTarget(message, caller, env, target);
            MethodSummary summary = analyzeContext(target, targetThis, args, env);
            resultValue = resultValue.join(summary.returnValue);
            exitEnv.mergeFields(summary.exitEnv);
        }
        return new MethodSummary(resultValue, exitEnv);
    }

    private void recordInlineDecision(
        MessageSendStatement statement,
        ResolveResult resolved,
        ProgramModel.MethodInfo caller
    ) {
        if (!statement.f0.present()) {
            return;
        }
        SiteInfo site = result.site(statement);
        site.caller = caller;
        if (resolved.unknown || resolved.targets.isEmpty()) {
            site.unknown = true;
            return;
        }
        site.targets.addAll(resolved.targets);
    }

    private ResolveResult resolveTargets(MessageSend message, ProgramModel.MethodInfo method, Env env) {
        ValueSet receiver = valueOfPrimary(message.f0, method, env);
        if (receiver.isUnknown()) {
            return ResolveResult.unknown();
        }
        if (receiver.isEmpty()) {
            receiver = staticTypesOfPrimary(message.f0, method);
        }
        if (receiver.isUnknown() || receiver.isEmpty()) {
            return ResolveResult.unknown();
        }

        ResolveResult result = new ResolveResult();
        String methodName = InlinerUtil.id(message.f2);
        for (String className : receiver.types) {
            ProgramModel.MethodInfo target = model.resolveMethod(className, methodName);
            if (target == null) {
                result.unknown = true;
            } else {
                result.targets.add(target);
            }
        }
        return result;
    }

    private ValueSet receiverTypesForTarget(
        MessageSend message,
        ProgramModel.MethodInfo caller,
        Env env,
        ProgramModel.MethodInfo target
    ) {
        ValueSet receiver = valueOfPrimary(message.f0, caller, env);
        if (receiver.isUnknown()) {
            return genericThis(target);
        }
        if (receiver.isEmpty()) {
            receiver = staticTypesOfPrimary(message.f0, caller);
        }
        LinkedHashSet<String> matching = new LinkedHashSet<String>();
        String methodName = InlinerUtil.id(message.f2);
        for (String className : receiver.types) {
            if (model.resolveMethod(className, methodName) == target) {
                matching.add(className);
            }
        }
        if (matching.isEmpty()) {
            return genericThis(target);
        }
        return ValueSet.ofAll(matching);
    }

    private List<ValueSet> argValues(MessageSend message, ProgramModel.MethodInfo method, Env env) {
        List<ValueSet> values = new ArrayList<ValueSet>();
        for (ConstOrId arg : InlinerUtil.args(message.f4)) {
            values.add(valueOfConstOrId(arg, method, env));
        }
        return values;
    }

    private ValueSet valueOfRhs(RhsExpression rhs, ProgramModel.MethodInfo method, Env env) {
        return emptyIfNull(rhs.accept(valueVisitor, new EvalContext(method, env)));
    }

    private ValueSet valueOfExpression(Expression expression, ProgramModel.MethodInfo method, Env env) {
        return emptyIfNull(expression.accept(valueVisitor, new EvalContext(method, env)));
    }

    private ValueSet valueOfPrimary(PrimaryExpression primary, ProgramModel.MethodInfo method, Env env) {
        return emptyIfNull(primary.accept(valueVisitor, new EvalContext(method, env)));
    }

    private ValueSet staticTypesOfPrimary(PrimaryExpression primary, ProgramModel.MethodInfo method) {
        return emptyIfNull(primary.accept(staticPrimaryVisitor, method));
    }

    private ValueSet valueOfConstOrId(ConstOrId value, ProgramModel.MethodInfo method, Env env) {
        return emptyIfNull(value.accept(valueVisitor, new EvalContext(method, env)));
    }

    private ValueSet valueOfIdentifier(String name, ProgramModel.MethodInfo method, Env env) {
        ValueSet known = env.get(name);
        if (known != null) {
            return known;
        }
        return possibleForType(model.lookupVariableType(method, name));
    }

    private ValueSet valueOfDotExpression(DotExpression expression, ProgramModel.MethodInfo method, Env env) {
        ValueSet receiver = valueOfIdentifier(InlinerUtil.id(expression.f0), method, env);
        if (receiver.isUnknown()) {
            return ValueSet.UNKNOWN;
        }
        if (receiver.isEmpty()) {
            receiver = possibleForType(model.lookupVariableType(method, InlinerUtil.id(expression.f0)));
        }

        ValueSet value = ValueSet.EMPTY;
        for (String className : receiver.types) {
            ValueSet fieldValue = env.getField(className, InlinerUtil.id(expression.f2));
            if (fieldValue != null) {
                value = value.join(fieldValue);
            }
        }
        if (!value.isEmpty()) {
            return value;
        }
        if (value.isUnknown()) {
            return ValueSet.UNKNOWN;
        }

        String ownerType = model.lookupVariableType(method, InlinerUtil.id(expression.f0));
        if (!model.isClassType(ownerType)) {
            return ValueSet.EMPTY;
        }
        ProgramModel.VarInfo field = model.resolveField(ownerType, InlinerUtil.id(expression.f2));
        return field == null ? ValueSet.EMPTY : possibleForType(field.type);
    }

    private ValueSet possibleForType(String type) {
        if (type == null || !model.isClassType(type)) {
            return ValueSet.EMPTY;
        }
        return ValueSet.ofAll(model.subclassesInclusive(type));
    }

    private ValueSet genericThis(ProgramModel.MethodInfo method) {
        if (method == null || method.owner == null) {
            return ValueSet.EMPTY;
        }
        if (method.isMain) {
            return ValueSet.of(method.owner.name);
        }
        return ValueSet.ofAll(model.receiverClassesForMethod(method));
    }

    private List<ValueSet> genericArgs(ProgramModel.MethodInfo method) {
        List<ValueSet> args = new ArrayList<ValueSet>();
        for (ProgramModel.VarInfo param : method.params) {
            args.add(possibleForType(param.type));
        }
        return args;
    }

    private MessageSend messageOf(MessageSendStatement statement) {
        return statement.f1.accept(MessageSendVisitor.INSTANCE, null);
    }

    private Identifier returnVariable(MessageSendStatement statement) {
        return statement.f1.accept(returnVariableVisitor, null);
    }

    private static ValueSet emptyIfNull(ValueSet value) {
        return value == null ? ValueSet.EMPTY : value;
    }

    private static String contextKey(
        ProgramModel.MethodInfo method,
        ValueSet thisValue,
        List<ValueSet> argValues,
        Env heapInput
    ) {
        StringBuilder key = new StringBuilder(method.qualifiedName());
        key.append("#this=").append(thisValue.key());
        for (int i = 0; i < argValues.size(); i++) {
            key.append("#arg").append(i).append('=').append(argValues.get(i).key());
        }
        if (heapInput != null) {
            key.append("#heap=").append(heapInput.fieldsKey());
        }
        return key.toString();
    }

    @Override
    public void visit(Block n, FlowContext context) {
        n.f1.accept(this, context);
    }

    @Override
    public void visit(AssignmentStatement n, FlowContext context) {
        context.env.put(InlinerUtil.id(n.f0), valueOfRhs(n.f2, context.method, context.env));
    }

    @Override
    public void visit(ArrayAssignmentStatement n, FlowContext context) {
        // Arrays are never dispatch receivers in this grammar subset.
    }

    @Override
    public void visit(FieldAssignmentStatement n, FlowContext context) {
        ValueSet receiver = valueOfIdentifier(InlinerUtil.id(n.f0), context.method, context.env);
        if (receiver.isEmpty()) {
            receiver = possibleForType(model.lookupVariableType(context.method, InlinerUtil.id(n.f0)));
        }
        ValueSet value = valueOfConstOrId(n.f4, context.method, context.env);
        for (String className : receiver.types) {
            context.env.putField(className, InlinerUtil.id(n.f2), value);
        }
    }

    @Override
    public void visit(IfStatement n, FlowContext context) {
        FlowContext thenContext = context.withEnv(context.env.copy());
        n.f4.accept(this, thenContext);
        FlowContext elseContext = context.withEnv(context.env.copy());
        n.f6.accept(this, elseContext);
        context.env = thenContext.env.join(elseContext.env);
    }

    @Override
    public void visit(WhileStatement n, FlowContext context) {
        Env input = context.env.copy();
        Env current = input.copy();
        for (int i = 0; i < 32; i++) {
            FlowContext bodyContext = context.withEnv(current.copy());
            n.f4.accept(this, bodyContext);
            Env next = input.join(bodyContext.env);
            if (next.equals(current)) {
                context.env = next;
                return;
            }
            current = next;
        }
        context.env = current;
    }

    @Override
    public void visit(ForStatement n, FlowContext context) {
        Env afterInit = context.env.copy();
        afterInit.put(InlinerUtil.id(n.f2), valueOfExpression(n.f4, context.method, context.env));
        Env current = afterInit.copy();
        for (int i = 0; i < 32; i++) {
            FlowContext bodyContext = context.withEnv(current.copy());
            n.f12.accept(this, bodyContext);
            bodyContext.env.put(InlinerUtil.id(n.f8), valueOfExpression(n.f10, context.method, bodyContext.env));
            Env next = afterInit.join(bodyContext.env);
            if (next.equals(current)) {
                context.env = next;
                return;
            }
            current = next;
        }
        context.env = current;
    }

    @Override
    public void visit(PrintStatement n, FlowContext context) {
        // Printing does not change pointer facts.
    }

    @Override
    public void visit(MessageSendStatement n, FlowContext context) {
        MessageSend message = messageOf(n);
        ResolveResult resolved = resolveTargets(message, context.method, context.env);
        recordInlineDecision(n, resolved, context.method);
        MethodSummary summary = analyzeCall(message, context.method, context.env, resolved);
        result.recordReturnValue(n, summary.returnValue);
        context.env.mergeFields(summary.exitEnv);
        Identifier returnVariable = returnVariable(n);
        if (returnVariable != null) {
            context.env.put(InlinerUtil.id(returnVariable), summary.returnValue);
        }
    }

    public static final class AnalysisResult {
        private final ProgramModel model;
        private final IdentityHashMap<MessageSendStatement, SiteInfo> sites =
            new IdentityHashMap<MessageSendStatement, SiteInfo>();
        private final IdentityHashMap<MessageSendStatement, ProgramModel.MethodInfo> inlineTargets =
            new IdentityHashMap<MessageSendStatement, ProgramModel.MethodInfo>();
        private final IdentityHashMap<MessageSendStatement, ValueSet> returnValues =
            new IdentityHashMap<MessageSendStatement, ValueSet>();

        private AnalysisResult(ProgramModel model) {
            this.model = model;
        }

        private SiteInfo site(MessageSendStatement statement) {
            SiteInfo site = sites.get(statement);
            if (site == null) {
                site = new SiteInfo();
                sites.put(statement, site);
            }
            return site;
        }

        private void recordReturnValue(MessageSendStatement statement, ValueSet value) {
            ValueSet current = returnValues.get(statement);
            returnValues.put(statement, current == null ? value : current.join(value));
        }

        private void finish() {
            for (Map.Entry<MessageSendStatement, SiteInfo> entry : sites.entrySet()) {
                SiteInfo site = entry.getValue();
                if (site.unknown || site.targets.isEmpty()) {
                    site.status = InlineStatus.UNKNOWN_RECEIVER;
                } else if (site.targets.size() > 1) {
                    site.status = InlineStatus.CONTEXTUAL;
                } else {
                    ProgramModel.MethodInfo target = site.targets.iterator().next();
                    if (model.recursiveMethods.contains(target)) {
                        site.status = InlineStatus.RECURSIVE_TARGET;
                    } else {
                        site.status = InlineStatus.INLINEABLE;
                        inlineTargets.put(entry.getKey(), target);
                    }
                }
            }
        }

        public ProgramModel.MethodInfo inlineTarget(MessageSendStatement statement) {
            return inlineTargets.get(statement);
        }

        public boolean contextSensitiveCandidate(MessageSendStatement statement) {
            SiteInfo site = sites.get(statement);
            return site != null && site.status == InlineStatus.CONTEXTUAL;
        }

        ValueSet returnValue(MessageSendStatement statement) {
            ValueSet value = returnValues.get(statement);
            return value == null ? ValueSet.UNKNOWN : value;
        }
    }

    private static final class SiteInfo {
        ProgramModel.MethodInfo caller;
        boolean unknown;
        InlineStatus status = InlineStatus.UNKNOWN_RECEIVER;
        final LinkedHashSet<ProgramModel.MethodInfo> targets = new LinkedHashSet<ProgramModel.MethodInfo>();
    }

    private enum InlineStatus {
        UNKNOWN_RECEIVER,
        CONTEXTUAL,
        RECURSIVE_TARGET,
        INLINEABLE
    }

    private static final class ResolveResult {
        boolean unknown;
        final LinkedHashSet<ProgramModel.MethodInfo> targets = new LinkedHashSet<ProgramModel.MethodInfo>();

        static ResolveResult unknown() {
            ResolveResult result = new ResolveResult();
            result.unknown = true;
            return result;
        }
    }

    private static final class MethodSummary {
        final ValueSet returnValue;
        final Env exitEnv;

        MethodSummary(ValueSet returnValue, Env exitEnv) {
            this.returnValue = returnValue;
            this.exitEnv = exitEnv;
        }

        static MethodSummary recursiveFallback(ValueSet returnValue) {
            return new MethodSummary(returnValue, new Env());
        }
    }

    private static final class Env {
        private final Map<String, ValueSet> values = new LinkedHashMap<String, ValueSet>();
        private final Map<String, ValueSet> fields = new LinkedHashMap<String, ValueSet>();

        ValueSet get(String name) {
            return values.get(name);
        }

        void put(String name, ValueSet value) {
            values.put(name, value == null ? ValueSet.EMPTY : value);
        }

        ValueSet getField(String className, String fieldName) {
            return fields.get(fieldKey(className, fieldName));
        }

        void putField(String className, String fieldName, ValueSet value) {
            String key = fieldKey(className, fieldName);
            ValueSet current = fields.get(key);
            ValueSet next = value == null ? ValueSet.EMPTY : value;
            fields.put(key, current == null ? next : current.join(next));
        }

        Env copy() {
            Env env = new Env();
            env.values.putAll(values);
            env.fields.putAll(fields);
            return env;
        }

        Env join(Env other) {
            Env joined = copy();
            for (Map.Entry<String, ValueSet> entry : other.values.entrySet()) {
                ValueSet current = joined.values.get(entry.getKey());
                joined.values.put(entry.getKey(), current == null ? entry.getValue() : current.join(entry.getValue()));
            }
            joined.mergeFields(other);
            return joined;
        }

        void mergeFields(Env other) {
            for (Map.Entry<String, ValueSet> entry : other.fields.entrySet()) {
                ValueSet current = fields.get(entry.getKey());
                fields.put(entry.getKey(), current == null ? entry.getValue() : current.join(entry.getValue()));
            }
        }

        String fieldsKey() {
            StringBuilder builder = new StringBuilder();
            for (Map.Entry<String, ValueSet> entry : fields.entrySet()) {
                if (builder.length() > 0) {
                    builder.append(';');
                }
                builder.append(entry.getKey()).append('=').append(entry.getValue().key());
            }
            return builder.toString();
        }

        private static String fieldKey(String className, String fieldName) {
            return className + "." + fieldName;
        }

        @Override
        public boolean equals(Object obj) {
            if (obj == null || obj.getClass() != Env.class) {
                return false;
            }
            Env other = (Env) obj;
            return values.equals(other.values) && fields.equals(other.fields);
        }

        @Override
        public int hashCode() {
            return 31 * values.hashCode() + fields.hashCode();
        }
    }

    public static final class FlowContext {
        private final ProgramModel.MethodInfo method;
        private Env env;

        private FlowContext(ProgramModel.MethodInfo method, Env env) {
            this.method = method;
            this.env = env;
        }

        private FlowContext withEnv(Env env) {
            return new FlowContext(method, env);
        }
    }

    private final class ValueVisitor extends GJDepthFirst<ValueSet, EvalContext> {
        @Override
        public ValueSet visit(RhsExpression n, EvalContext context) {
            return emptyIfNull(n.f0.accept(this, context));
        }

        @Override
        public ValueSet visit(Expression n, EvalContext context) {
            return emptyIfNull(n.f0.accept(this, context));
        }

        @Override
        public ValueSet visit(PrimaryExpression n, EvalContext context) {
            return emptyIfNull(n.f0.accept(this, context));
        }

        @Override
        public ValueSet visit(ConstOrId n, EvalContext context) {
            return emptyIfNull(n.f0.accept(this, context));
        }

        @Override
        public ValueSet visit(DotExpression n, EvalContext context) {
            return valueOfDotExpression(n, context.method, context.env);
        }

        @Override
        public ValueSet visit(Identifier n, EvalContext context) {
            return valueOfIdentifier(InlinerUtil.id(n), context.method, context.env);
        }

        @Override
        public ValueSet visit(ThisExpression n, EvalContext context) {
            ValueSet value = context.env.get("this");
            return value == null ? genericThis(context.method) : value;
        }

        @Override
        public ValueSet visit(AllocationExpression n, EvalContext context) {
            return ValueSet.of(InlinerUtil.id(n.f1));
        }

        @Override
        public ValueSet visit(ArrayAllocationExpression n, EvalContext context) {
            return ValueSet.EMPTY;
        }

        @Override
        public ValueSet visit(NotExpression n, EvalContext context) {
            return ValueSet.EMPTY;
        }
    }

    private final class StaticPrimaryVisitor extends GJDepthFirst<ValueSet, ProgramModel.MethodInfo> {
        @Override
        public ValueSet visit(PrimaryExpression n, ProgramModel.MethodInfo method) {
            return emptyIfNull(n.f0.accept(this, method));
        }

        @Override
        public ValueSet visit(Identifier n, ProgramModel.MethodInfo method) {
            return possibleForType(model.lookupVariableType(method, InlinerUtil.id(n)));
        }

        @Override
        public ValueSet visit(ThisExpression n, ProgramModel.MethodInfo method) {
            return genericThis(method);
        }

        @Override
        public ValueSet visit(AllocationExpression n, ProgramModel.MethodInfo method) {
            return ValueSet.of(InlinerUtil.id(n.f1));
        }

        @Override
        public ValueSet visit(ArrayAllocationExpression n, ProgramModel.MethodInfo method) {
            return ValueSet.EMPTY;
        }

        @Override
        public ValueSet visit(NotExpression n, ProgramModel.MethodInfo method) {
            return ValueSet.EMPTY;
        }
    }

    private static final class MessageSendVisitor extends GJDepthFirst<MessageSend, Void> {
        static final MessageSendVisitor INSTANCE = new MessageSendVisitor();

        @Override
        public MessageSend visit(VoidMessageSendStmt n, Void unused) {
            return n.f0;
        }

        @Override
        public MessageSend visit(RetMessageSendStmt n, Void unused) {
            return n.f2;
        }
    }

    private static final class ReturnVariableVisitor extends GJDepthFirst<Identifier, Void> {
        @Override
        public Identifier visit(RetMessageSendStmt n, Void unused) {
            return n.f0;
        }
    }

    private static final class EvalContext {
        final ProgramModel.MethodInfo method;
        final Env env;

        EvalContext(ProgramModel.MethodInfo method, Env env) {
            this.method = method;
            this.env = env;
        }
    }
}
