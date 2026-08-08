package inliner;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import syntaxtree.AllocationExpression;
import syntaxtree.AndExpression;
import syntaxtree.ArrayAllocationExpression;
import syntaxtree.ArrayAssignmentStatement;
import syntaxtree.ArrayLength;
import syntaxtree.ArrayLookup;
import syntaxtree.Block;
import syntaxtree.ClassDeclaration;
import syntaxtree.ClassExtendsDeclaration;
import syntaxtree.CompareExpression;
import syntaxtree.ConstOrId;
import syntaxtree.DotExpression;
import syntaxtree.Expression;
import syntaxtree.FalseLiteral;
import syntaxtree.FieldAssignmentStatement;
import syntaxtree.ForStatement;
import syntaxtree.Goal;
import syntaxtree.Identifier;
import syntaxtree.IfStatement;
import syntaxtree.IntegerLiteral;
import syntaxtree.IntegerLiteralWithNegSign;
import syntaxtree.IntegerLiteralWithPosSign;
import syntaxtree.MainClass;
import syntaxtree.MessageSend;
import syntaxtree.MessageSendStatement;
import syntaxtree.MethodDeclaration;
import syntaxtree.MinusExpression;
import syntaxtree.Node;
import syntaxtree.NotExpression;
import syntaxtree.PlainIntegerLiteral;
import syntaxtree.PlusExpression;
import syntaxtree.PrimaryExpression;
import syntaxtree.PrintStatement;
import syntaxtree.RetMessageSendStmt;
import syntaxtree.RhsExpression;
import syntaxtree.Statement;
import syntaxtree.ThisExpression;
import syntaxtree.TimesExpression;
import syntaxtree.TrueLiteral;
import syntaxtree.TypeDeclaration;
import syntaxtree.VarDeclaration;
import syntaxtree.VoidMessageSendStmt;
import syntaxtree.WhileStatement;
import visitor.DepthFirstVisitor;
import visitor.GJDepthFirst;
import visitor.Visitor;

public final class InlinePrinter extends DepthFirstVisitor implements Visitor {
    private static final String INDENT = "    ";

    private final ProgramModel model;
    private final PointsToAnalysis.AnalysisResult analysis;
    private final StringBuilder out = new StringBuilder();
    private int indent;
    private StringBuilder activeBuilder;
    private int activeLocalIndent;
    private RenderContext activeContext;
    private String rendered;
    private ValueSet value;
    private MessageSend message;
    private Identifier identifier;
    private boolean flag;
    private boolean blockQuery;
    private boolean valueQuery;

    private InlinePrinter(ProgramModel model, PointsToAnalysis.AnalysisResult analysis) {
        this.model = model;
        this.analysis = analysis;
    }

    public static String print(
        Goal goal,
        ProgramModel model,
        PointsToAnalysis.AnalysisResult analysis
    ) {
        InlinePrinter printer = new InlinePrinter(model, analysis);
        goal.accept(printer);
        return printer.out.toString();
    }

    @Override
    public void visit(Goal goal) {
        goal.f0.accept(this);
        for (Node node : goal.f1.nodes) {
            out.append('\n');
            node.accept(this);
        }
    }

    @Override
    public void visit(MainClass mainClass) {
        line("class " + InlinerUtil.id(mainClass.f1) + " {");
        indent++;

        MethodFrame frame = new MethodFrame(model.mainMethod);
        frame.use(InlinerUtil.id(mainClass.f11));
        RenderContext context = RenderContext.root(frame, model);
        StringBuilder body = new StringBuilder();
        emitStatementList(body, 0, mainClass.f15, context);

        line("public static void main(String[] " + InlinerUtil.id(mainClass.f11) + ") {");
        indent++;
        emitOriginalDecls(mainClass.f14);
        emitGeneratedDecls(frame);
        appendBody(body);
        indent--;
        line("}");

        indent--;
        line("}");
    }

    @Override
    public void visit(TypeDeclaration declaration) {
        declaration.f0.accept(this);
    }

    @Override
    public void visit(ClassDeclaration declaration) {
        line("class " + InlinerUtil.id(declaration.f1) + " {");
        indent++;
        emitOriginalDecls(declaration.f3);
        if (declaration.f3.present() && declaration.f4.present()) {
            out.append('\n');
        }
        emitMethods(declaration.f4);
        indent--;
        line("}");
    }

    @Override
    public void visit(ClassExtendsDeclaration declaration) {
        line("class " + InlinerUtil.id(declaration.f1) + " extends " + InlinerUtil.id(declaration.f3) + " {");
        indent++;
        emitOriginalDecls(declaration.f5);
        if (declaration.f5.present() && declaration.f6.present()) {
            out.append('\n');
        }
        emitMethods(declaration.f6);
        indent--;
        line("}");
    }

    private void emitMethods(syntaxtree.NodeListOptional methods) {
        for (int i = 0; i < methods.size(); i++) {
            if (i > 0) {
                out.append('\n');
            }
            methods.elementAt(i).accept(this);
        }
    }

    @Override
    public void visit(MethodDeclaration declaration) {
        ProgramModel.MethodInfo method = model.methodFor(declaration);
        if (method == null) {
            throw new IllegalStateException("Missing method info for " + InlinerUtil.id(declaration.f2));
        }
        MethodFrame frame = new MethodFrame(method);
        RenderContext context = RenderContext.root(frame, model);
        StringBuilder body = new StringBuilder();
        emitStatementList(body, 0, declaration.f8, context);

        line("public " + InlinerUtil.type(declaration.f1) + " " + InlinerUtil.id(declaration.f2)
            + "(" + renderFormalParams(declaration.f4) + ") {");
        indent++;
        emitOriginalDecls(declaration.f7);
        emitGeneratedDecls(frame);
        appendBody(body);
        line("return " + renderConstOrId(declaration.f10, context) + ";");
        indent--;
        line("}");
    }

    private void emitOriginalDecls(syntaxtree.NodeListOptional declarations) {
        for (Node node : declarations.nodes) {
            VarDeclaration declaration = (VarDeclaration) node;
            line(InlinerUtil.type(declaration.f0) + " " + InlinerUtil.id(declaration.f1) + ";");
        }
    }

    private void emitGeneratedDecls(MethodFrame frame) {
        for (ProgramModel.VarInfo declaration : frame.generatedDecls) {
            line(declaration.type + " " + declaration.name + ";");
        }
    }

    private void emitStatementList(
        StringBuilder builder,
        int localIndent,
        syntaxtree.NodeListOptional statements,
        RenderContext context
    ) {
        for (Node node : statements.nodes) {
            emitStatement(builder, localIndent, node, context);
        }
    }

    private void emitStatement(
        StringBuilder builder,
        int localIndent,
        Node statement,
        RenderContext context
    ) {
        StringBuilder previousBuilder = activeBuilder;
        int previousIndent = activeLocalIndent;
        RenderContext previousContext = activeContext;
        activeBuilder = builder;
        activeLocalIndent = localIndent;
        activeContext = context;
        statement.accept(this);
        activeBuilder = previousBuilder;
        activeLocalIndent = previousIndent;
        activeContext = previousContext;
    }

    @Override
    public void visit(Statement statement) {
        statement.f0.accept(this);
    }

    @Override
    public void visit(Block block) {
        if (blockQuery) {
            flag = true;
            return;
        }
        emit(activeBuilder, activeLocalIndent, "{");
        emitStatementList(activeBuilder, activeLocalIndent + 1, block.f1, activeContext);
        emit(activeBuilder, activeLocalIndent, "}");
    }

    @Override
    public void visit(syntaxtree.AssignmentStatement assign) {
        if (blockQuery) {
            return;
        }
        String lhs = mapId(assign.f0, activeContext);
        emit(activeBuilder, activeLocalIndent, lhs + " = " + renderRhs(assign.f2, activeContext) + ";");
        activeContext.values.put(lhs, valueOfRhs(assign.f2, activeContext));
    }

    @Override
    public void visit(ArrayAssignmentStatement assign) {
        if (blockQuery) {
            return;
        }
        emit(activeBuilder, activeLocalIndent, renderIdentifierAtom(assign.f0, activeContext) + "["
            + renderConstOrIdAtom(assign.f2, activeContext) + "] = "
            + renderConstOrId(assign.f5, activeContext) + ";");
    }

    @Override
    public void visit(FieldAssignmentStatement assign) {
        if (blockQuery) {
            return;
        }
        emit(activeBuilder, activeLocalIndent, renderIdentifierAtom(assign.f0, activeContext) + "."
            + InlinerUtil.id(assign.f2) + " = " + renderConstOrId(assign.f4, activeContext) + ";");
    }

    @Override
    public void visit(IfStatement statement) {
        if (blockQuery) {
            return;
        }
        String condition = renderIdentifierAtom(statement.f2, activeContext);
        emit(activeBuilder, activeLocalIndent, "if (" + condition + ")");
        RenderContext thenContext = activeContext.copy();
        emitControlledStatement(activeBuilder, activeLocalIndent, statement.f4, thenContext);
        emit(activeBuilder, activeLocalIndent, "else");
        RenderContext elseContext = activeContext.copy();
        emitControlledStatement(activeBuilder, activeLocalIndent, statement.f6, elseContext);
        activeContext.mergeValues(thenContext, elseContext);
    }

    @Override
    public void visit(WhileStatement loop) {
        if (blockQuery) {
            return;
        }
        String condition = renderIdentifierAtom(loop.f2, activeContext);
        emit(activeBuilder, activeLocalIndent, "while (" + condition + ")");
        RenderContext inputContext = activeContext.copy();
        RenderContext bodyContext = activeContext.copy();
        emitControlledStatement(activeBuilder, activeLocalIndent, loop.f4, bodyContext);
        activeContext.mergeValues(inputContext, bodyContext);
    }

    @Override
    public void visit(ForStatement statement) {
        if (blockQuery) {
            return;
        }
        String header = "for (" + mapId(statement.f2, activeContext) + " = "
            + renderExpression(statement.f4, activeContext) + "; "
            + renderExpression(statement.f6, activeContext) + "; "
            + mapId(statement.f8, activeContext) + " = " + renderExpression(statement.f10, activeContext) + ")";
        emit(activeBuilder, activeLocalIndent, header);
        RenderContext inputContext = activeContext.copy();
        RenderContext bodyContext = activeContext.copy();
        emitControlledStatement(activeBuilder, activeLocalIndent, statement.f12, bodyContext);
        bodyContext.values.put(mapId(statement.f8, bodyContext), valueOfExpression(statement.f10, bodyContext));
        activeContext.mergeValues(inputContext, bodyContext);
    }

    @Override
    public void visit(PrintStatement print) {
        if (blockQuery) {
            return;
        }
        emit(activeBuilder, activeLocalIndent,
            "System.out.println(" + renderConstOrIdAtom(print.f2, activeContext) + ");");
    }

    private void emitControlledStatement(
        StringBuilder builder,
        int localIndent,
        Statement statement,
        RenderContext context
    ) {
        if (isBlock(statement)) {
            emitStatement(builder, localIndent, statement, context);
            return;
        }
        emit(builder, localIndent, "{");
        emitStatement(builder, localIndent + 1, statement, context);
        emit(builder, localIndent, "}");
    }

    @Override
    public void visit(MessageSendStatement statement) {
        if (blockQuery) {
            return;
        }
        ProgramModel.MethodInfo target = resolveInlineTarget(statement, activeContext);
        if (target == null || activeContext.inlineStack.contains(target)) {
            emit(activeBuilder, activeLocalIndent, renderMessageSendStatement(statement, activeContext));
            Identifier returnVariable = returnVariable(statement);
            if (returnVariable != null) {
                activeContext.values.put(mapId(returnVariable, activeContext), analysis.returnValue(statement));
            }
            return;
        }
        emitInline(activeBuilder, activeLocalIndent, statement, target, activeContext);
    }

    private void emitInline(
        StringBuilder builder,
        int localIndent,
        MessageSendStatement statement,
        ProgramModel.MethodInfo target,
        RenderContext parent
    ) {
        MessageSend message = messageOf(statement);
        String receiverText = renderPrimary(message.f0, parent);
        ValueSet receiverValue = valueOfPrimary(message.f0, parent);
        String receiverType = staticTypeOfReceiver(message.f0, parent);
        if (receiverType == null || !model.isClassType(receiverType)) {
            receiverType = target.owner.name;
        }
        String receiverTemp = parent.frame.fresh("this");
        parent.frame.generatedDecls.add(new ProgramModel.VarInfo(receiverType, receiverTemp));
        emit(builder, localIndent, receiverTemp + " = " + receiverText + ";");

        RenderContext child = parent.child(receiverTemp, receiverValue, target);
        List<ConstOrId> args = InlinerUtil.args(message.f4);
        for (int i = 0; i < target.params.size() && i < args.size(); i++) {
            ProgramModel.VarInfo param = target.params.get(i);
            String fresh = parent.frame.fresh(param.name);
            child.renames.put(param.name, fresh);
            parent.frame.generatedDecls.add(new ProgramModel.VarInfo(param.type, fresh));
            ValueSet argValue = valueOfConstOrId(args.get(i), parent);
            emit(builder, localIndent, fresh + " = " + renderConstOrId(args.get(i), parent) + ";");
            child.values.put(fresh, argValue);
        }
        for (ProgramModel.VarInfo local : target.locals) {
            String fresh = parent.frame.fresh(local.name);
            child.renames.put(local.name, fresh);
            parent.frame.generatedDecls.add(new ProgramModel.VarInfo(local.type, fresh));
        }

        parent.inlineStack.push(target);
        emitStatementList(builder, localIndent, target.statements, child);
        parent.inlineStack.pop();

        Identifier returnVariable = returnVariable(statement);
        if (returnVariable != null && target.returnValue != null) {
            String lhs = mapId(returnVariable, parent);
            ValueSet returnValue = valueOfConstOrId(target.returnValue, child);
            emit(builder, localIndent, lhs + " = " + renderConstOrId(target.returnValue, child) + ";");
            parent.values.put(lhs, returnValue);
        }
    }

    private String renderMessageSendStatement(MessageSendStatement statement, RenderContext context) {
        return renderNode(statement.f1, context);
    }

    private String renderMessageSend(MessageSend message, RenderContext context) {
        return renderPrimaryAtom(message.f0, context) + "." + InlinerUtil.id(message.f2)
            + "(" + renderArgs(message.f4, context) + ")";
    }

    private ProgramModel.MethodInfo resolveInlineTarget(
        MessageSendStatement statement,
        RenderContext context
    ) {
        if (!statement.f0.present()) {
            return null;
        }
        ProgramModel.MethodInfo target = analysis.inlineTarget(statement);
        if (target == null && !analysis.contextSensitiveCandidate(statement)) {
            return null;
        }

        MessageSend message = messageOf(statement);
        ValueSet receiver = valueOfPrimary(message.f0, context);
        if (receiver.isUnknown()) {
            if (target != null && safeInlineReceiver(message.f0, context, target)) {
                return target;
            }
            return null;
        }
        if (receiver.isEmpty()) {
            if (target != null && safeInlineReceiver(message.f0, context, target)) {
                return target;
            }
            return null;
        }

        LinkedHashSet<ProgramModel.MethodInfo> targets = new LinkedHashSet<ProgramModel.MethodInfo>();
        String methodName = InlinerUtil.id(message.f2);
        for (String className : receiver.types) {
            ProgramModel.MethodInfo resolved = model.resolveMethod(className, methodName);
            if (resolved == null) {
                return null;
            }
            targets.add(resolved);
        }
        if (targets.size() != 1) {
            return null;
        }
        ProgramModel.MethodInfo resolvedTarget = targets.iterator().next();
        if (model.recursiveMethods.contains(resolvedTarget)) {
            return null;
        }
        return safeInlineReceiver(message.f0, context, resolvedTarget) ? resolvedTarget : null;
    }

    private String renderArgs(syntaxtree.NodeOptional args, RenderContext context) {
        List<String> rendered = new ArrayList<String>();
        for (ConstOrId arg : InlinerUtil.args(args)) {
            rendered.add(renderConstOrIdAtom(arg, context));
        }
        return join(rendered, ", ");
    }

    private String renderRhs(RhsExpression rhs, RenderContext context) {
        return renderNode(rhs, context);
    }

    private ValueSet valueOfRhs(RhsExpression rhs, RenderContext context) {
        return valueOfNode(rhs, context);
    }

    private String renderExpression(Expression expression, RenderContext context) {
        return renderNode(expression, context);
    }

    private ValueSet valueOfExpression(Expression expression, RenderContext context) {
        return valueOfNode(expression, context);
    }

    private String renderPrimary(PrimaryExpression primary, RenderContext context) {
        return renderNode(primary, context);
    }

    private ValueSet valueOfPrimary(PrimaryExpression primary, RenderContext context) {
        return valueOfNode(primary, context);
    }

    private String renderConstOrId(ConstOrId value, RenderContext context) {
        return renderNode(value, context);
    }

    private ValueSet valueOfConstOrId(ConstOrId value, RenderContext context) {
        return valueOfNode(value, context);
    }

    private String renderConstOrIdAtom(ConstOrId value, RenderContext context) {
        String text = renderConstOrId(value, context);
        if (needsMaterializedAtom(text)) {
            String temp = context.frame.fresh("atom");
            context.frame.generatedDecls.add(new ProgramModel.VarInfo(typeOfConstOrId(value, context), temp));
            emit(activeBuilder, activeLocalIndent, temp + " = " + text + ";");
            context.values.put(temp, valueOfConstOrId(value, context));
            return temp;
        }
        return text;
    }

    private String renderIdentifierAtom(Identifier id, RenderContext context) {
        String text = mapId(id, context);
        if (needsMaterializedAtom(text)) {
            String temp = context.frame.fresh("atom");
            context.frame.generatedDecls.add(new ProgramModel.VarInfo(typeOfIdentifier(id, context), temp));
            emit(activeBuilder, activeLocalIndent, temp + " = " + text + ";");
            context.values.put(temp, valueOfIdentifier(id, context));
            return temp;
        }
        return text;
    }

    private String renderPrimaryAtom(PrimaryExpression primary, RenderContext context) {
        String text = renderPrimary(primary, context);
        if (needsMaterializedAtom(text)) {
            String type = staticTypeOfReceiver(primary, context);
            if (type == null || !model.isClassType(type)) {
                return text;
            }
            String temp = context.frame.fresh("recv");
            context.frame.generatedDecls.add(new ProgramModel.VarInfo(type, temp));
            emit(activeBuilder, activeLocalIndent, temp + " = " + text + ";");
            context.values.put(temp, valueOfPrimary(primary, context));
            return temp;
        }
        return text;
    }

    private boolean needsMaterializedAtom(String text) {
        return !valueQuery && activeBuilder != null && text != null && text.indexOf('.') >= 0;
    }

    private String typeOfConstOrId(ConstOrId value, RenderContext context) {
        Node choice = value.f0.choice;
        if (choice instanceof Identifier) {
            return typeOfIdentifier((Identifier) choice, context);
        }
        if (choice instanceof TrueLiteral || choice instanceof FalseLiteral) {
            return "boolean";
        }
        return "int";
    }

    private String typeOfIdentifier(Identifier id, RenderContext context) {
        String type = model.lookupVariableType(context.sourceMethod, InlinerUtil.id(id));
        return type == null ? "int" : type;
    }

    private ValueSet valueOfIdentifier(Identifier id, RenderContext context) {
        String name = mapId(id, context);
        ValueSet known = context.values.get(name);
        if (known != null) {
            return known;
        }
        return possibleForVariable(context.sourceMethod, InlinerUtil.id(id));
    }

    @Override
    public void visit(RhsExpression rhs) {
        rhs.f0.accept(this);
    }

    @Override
    public void visit(DotExpression dot) {
        rendered = mapId(dot.f0, activeContext) + "." + InlinerUtil.id(dot.f2);
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(Expression expression) {
        expression.f0.accept(this);
    }

    @Override
    public void visit(AndExpression expression) {
        rendered = renderConstOrIdAtom(expression.f0, activeContext) + " & "
            + renderConstOrIdAtom(expression.f2, activeContext);
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(CompareExpression expression) {
        rendered = renderConstOrIdAtom(expression.f0, activeContext) + " < "
            + renderConstOrIdAtom(expression.f2, activeContext);
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(PlusExpression expression) {
        rendered = renderConstOrIdAtom(expression.f0, activeContext) + " + "
            + renderConstOrIdAtom(expression.f2, activeContext);
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(MinusExpression expression) {
        rendered = renderConstOrIdAtom(expression.f0, activeContext) + " - "
            + renderConstOrIdAtom(expression.f2, activeContext);
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(TimesExpression expression) {
        rendered = renderConstOrIdAtom(expression.f0, activeContext) + " * "
            + renderConstOrIdAtom(expression.f2, activeContext);
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(ArrayLookup expression) {
        rendered = renderIdentifierAtom(expression.f0, activeContext) + "["
            + renderConstOrIdAtom(expression.f2, activeContext) + "]";
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(ArrayLength expression) {
        rendered = renderIdentifierAtom(expression.f0, activeContext) + ".length";
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(PrimaryExpression primary) {
        primary.f0.accept(this);
    }

    @Override
    public void visit(IntegerLiteral literal) {
        literal.f0.accept(this);
    }

    @Override
    public void visit(PlainIntegerLiteral literal) {
        rendered = literal.f0.tokenImage;
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(IntegerLiteralWithPosSign literal) {
        rendered = "+" + literal.f1.tokenImage;
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(IntegerLiteralWithNegSign literal) {
        rendered = "-" + literal.f1.tokenImage;
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(ConstOrId constOrId) {
        constOrId.f0.accept(this);
    }

    @Override
    public void visit(TrueLiteral literal) {
        rendered = "true";
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(FalseLiteral literal) {
        rendered = "false";
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(Identifier id) {
        rendered = activeContext == null ? InlinerUtil.id(id) : mapId(id, activeContext);
        value = activeContext == null ? ValueSet.EMPTY : valueOfIdentifier(id, activeContext);
        identifier = id;
        flag = true;
    }

    @Override
    public void visit(ThisExpression thisExpression) {
        rendered = activeContext.thisExpr;
        ValueSet thisValue = activeContext.values.get("this");
        value = thisValue == null ? possibleReceivers(activeContext.frame.method) : thisValue;
    }

    @Override
    public void visit(ArrayAllocationExpression expression) {
        rendered = "new int[" + renderConstOrIdAtom(expression.f3, activeContext) + "]";
        value = ValueSet.EMPTY;
    }

    @Override
    public void visit(AllocationExpression expression) {
        rendered = "new " + InlinerUtil.id(expression.f1) + "()";
        value = ValueSet.of(InlinerUtil.id(expression.f1));
    }

    @Override
    public void visit(NotExpression expression) {
        rendered = "!" + renderIdentifierAtom(expression.f1, activeContext);
        value = ValueSet.EMPTY;
    }

    private String renderNode(Node node, RenderContext context) {
        RenderContext previousContext = activeContext;
        String previousRendered = rendered;
        ValueSet previousValue = value;
        MessageSend previousMessage = message;
        Identifier previousIdentifier = identifier;
        boolean previousFlag = flag;
        boolean previousValueQuery = valueQuery;
        activeContext = context;
        rendered = "";
        value = ValueSet.EMPTY;
        message = null;
        identifier = null;
        flag = false;
        valueQuery = false;
        node.accept(this);
        String result = rendered;
        activeContext = previousContext;
        rendered = previousRendered;
        value = previousValue;
        message = previousMessage;
        identifier = previousIdentifier;
        flag = previousFlag;
        valueQuery = previousValueQuery;
        return result;
    }

    private ValueSet valueOfNode(Node node, RenderContext context) {
        RenderContext previousContext = activeContext;
        String previousRendered = rendered;
        ValueSet previousValue = value;
        MessageSend previousMessage = message;
        Identifier previousIdentifier = identifier;
        boolean previousFlag = flag;
        boolean previousValueQuery = valueQuery;
        activeContext = context;
        rendered = "";
        value = ValueSet.EMPTY;
        message = null;
        identifier = null;
        flag = false;
        valueQuery = true;
        node.accept(this);
        ValueSet result = value;
        activeContext = previousContext;
        rendered = previousRendered;
        value = previousValue;
        message = previousMessage;
        identifier = previousIdentifier;
        flag = previousFlag;
        valueQuery = previousValueQuery;
        return result == null ? ValueSet.EMPTY : result;
    }

    private boolean boolFrom(Node node) {
        RenderContext previousContext = activeContext;
        String previousRendered = rendered;
        ValueSet previousValue = value;
        MessageSend previousMessage = message;
        Identifier previousIdentifier = identifier;
        boolean previousFlag = flag;
        activeContext = null;
        rendered = "";
        value = ValueSet.EMPTY;
        message = null;
        identifier = null;
        flag = false;
        node.accept(this);
        boolean result = flag;
        activeContext = previousContext;
        rendered = previousRendered;
        value = previousValue;
        message = previousMessage;
        identifier = previousIdentifier;
        flag = previousFlag;
        return result;
    }

    private boolean isBlock(Node node) {
        boolean previousBlockQuery = blockQuery;
        boolean previousFlag = flag;
        blockQuery = true;
        flag = false;
        node.accept(this);
        boolean result = flag;
        blockQuery = previousBlockQuery;
        flag = previousFlag;
        return result;
    }

    private String renderFormalParams(syntaxtree.NodeOptional params) {
        List<String> rendered = new ArrayList<String>();
        for (ProgramModel.VarInfo param : InlinerUtil.formalParams(params)) {
            rendered.add(param.type + " " + param.name);
        }
        return join(rendered, ", ");
    }

    @Override
    public void visit(VoidMessageSendStmt statement) {
        message = statement.f0;
        rendered = renderMessageSend(statement.f0, activeContext) + ";";
    }

    @Override
    public void visit(RetMessageSendStmt statement) {
        message = statement.f2;
        identifier = statement.f0;
        rendered = mapId(statement.f0, activeContext) + " = "
            + renderMessageSend(statement.f2, activeContext) + ";";
    }

    private MessageSend messageOf(MessageSendStatement statement) {
        statement.f1.accept(this);
        return message;
    }

    private Identifier returnVariable(MessageSendStatement statement) {
        MessageSend previousMessage = message;
        Identifier previousIdentifier = identifier;
        String previousRendered = rendered;
        message = null;
        identifier = null;
        rendered = "";
        statement.f1.accept(this);
        Identifier result = identifier;
        message = previousMessage;
        identifier = previousIdentifier;
        rendered = previousRendered;
        return result;
    }

    private ValueSet possibleForVariable(ProgramModel.MethodInfo method, String variableName) {
        String type = model.lookupVariableType(method, variableName);
        if (type == null || !model.isClassType(type)) {
            return ValueSet.EMPTY;
        }
        return ValueSet.ofAll(model.subclassesInclusive(type));
    }

    private ValueSet possibleReceivers(ProgramModel.MethodInfo method) {
        if (method == null || method.owner == null) {
            return ValueSet.EMPTY;
        }
        if (method.isMain) {
            return ValueSet.of(method.owner.name);
        }
        return ValueSet.ofAll(model.receiverClassesForMethod(method));
    }

    private String mapId(Identifier id, RenderContext context) {
        String name = InlinerUtil.id(id);
        String mapped = context.renames.get(name);
        if (mapped != null) {
            return mapped;
        }
        if (isFieldReference(context, name)) {
            return "this".equals(context.thisExpr) ? name : context.thisExpr + "." + name;
        }
        return name;
    }

    private boolean isFieldReference(RenderContext context, String name) {
        ProgramModel.MethodInfo method = context.sourceMethod;
        if (method == null || method.owner == null) {
            return false;
        }
        if (method.localsByName.containsKey(name) || method.paramsByName.containsKey(name)) {
            return false;
        }
        return model.resolveField(method.owner.name, name) != null;
    }

    private boolean safeInlineReceiver(
        PrimaryExpression receiver,
        RenderContext context,
        ProgramModel.MethodInfo target
    ) {
        if (model.recursiveMethods.contains(target)) {
            return false;
        }
        if (!methodNeedsReceiverType(target)) {
            return true;
        }
        String receiverType = staticTypeOfReceiver(receiver, context);
        return receiverType != null && model.isSubclassOrSame(receiverType, target.owner.name);
    }

    private boolean methodNeedsReceiverType(ProgramModel.MethodInfo method) {
        if (method == null || method.statements == null) {
            return false;
        }
        ReceiverUseVisitor visitor = new ReceiverUseVisitor(method);
        method.statements.accept(visitor, null);
        if (method.returnValue != null) {
            method.returnValue.accept(visitor, null);
        }
        return visitor.needsReceiver;
    }

    private String staticTypeOfReceiver(PrimaryExpression receiver, RenderContext context) {
        Node choice = receiver.f0.choice;
        if (choice instanceof Identifier) {
            return model.lookupVariableType(context.sourceMethod, InlinerUtil.id((Identifier) choice));
        }
        if (choice instanceof ThisExpression) {
            ProgramModel.MethodInfo method = context.sourceMethod;
            return method == null || method.owner == null ? null : method.owner.name;
        }
        if (choice instanceof AllocationExpression) {
            return InlinerUtil.id(((AllocationExpression) choice).f1);
        }
        return null;
    }

    private void appendBody(StringBuilder body) {
        String[] lines = body.toString().split("\n", -1);
        for (String bodyLine : lines) {
            if (bodyLine.length() == 0) {
                continue;
            }
            for (int i = 0; i < indent; i++) {
                out.append(INDENT);
            }
            out.append(bodyLine).append('\n');
        }
    }

    private void emit(StringBuilder builder, int localIndent, String text) {
        for (int i = 0; i < localIndent; i++) {
            builder.append(INDENT);
        }
        builder.append(text).append('\n');
    }

    private void line(String text) {
        for (int i = 0; i < indent; i++) {
            out.append(INDENT);
        }
        out.append(text).append('\n');
    }

    private static String join(List<String> parts, String separator) {
        StringBuilder builder = new StringBuilder();
        for (int i = 0; i < parts.size(); i++) {
            if (i > 0) {
                builder.append(separator);
            }
            builder.append(parts.get(i));
        }
        return builder.toString();
    }

    private final class MethodFrame {
        final ProgramModel.MethodInfo method;
        final List<ProgramModel.VarInfo> generatedDecls = new ArrayList<ProgramModel.VarInfo>();
        final Set<String> usedNames = new LinkedHashSet<String>();
        int freshCounter;

        MethodFrame(ProgramModel.MethodInfo method) {
            this.method = method;
            if (method != null) {
                for (ProgramModel.VarInfo param : method.params) {
                    use(param.name);
                }
                for (ProgramModel.VarInfo local : method.locals) {
                    use(local.name);
                }
                if (method.owner != null) {
                    for (ProgramModel.VarInfo field : method.owner.fields.values()) {
                        use(field.name);
                    }
                }
            }
        }

        void use(String name) {
            usedNames.add(name);
        }

        String fresh(String base) {
            String cleaned = base == null || base.length() == 0 ? "tmp" : base;
            String candidate;
            do {
                candidate = cleaned + "_TEMP" + freshCounter;
                freshCounter++;
            } while (usedNames.contains(candidate));
            usedNames.add(candidate);
            return candidate;
        }
    }

    private static final class ReceiverUseVisitor extends GJDepthFirst<Void, Void> {
        private final ProgramModel.MethodInfo method;
        boolean needsReceiver;

        ReceiverUseVisitor(ProgramModel.MethodInfo method) {
            this.method = method;
        }

        @Override
        public Void visit(ThisExpression expression, Void unused) {
            needsReceiver = true;
            return null;
        }

        @Override
        public Void visit(DotExpression dot, Void unused) {
            needsReceiver = true;
            return null;
        }

        @Override
        public Void visit(FieldAssignmentStatement assignment, Void unused) {
            needsReceiver = true;
            return null;
        }

        @Override
        public Void visit(Identifier id, Void unused) {
            String name = InlinerUtil.id(id);
            if (!method.localsByName.containsKey(name)
                && !method.paramsByName.containsKey(name)
                && method.owner != null
                && method.owner.fields.containsKey(name)) {
                needsReceiver = true;
            }
            return null;
        }
    }

    private static final class RenderContext {
        final MethodFrame frame;
        final Map<String, String> renames = new LinkedHashMap<String, String>();
        final Map<String, ValueSet> values = new LinkedHashMap<String, ValueSet>();
        final Deque<ProgramModel.MethodInfo> inlineStack;
        final String thisExpr;
        final ProgramModel.MethodInfo sourceMethod;

        private RenderContext(
            MethodFrame frame,
            Deque<ProgramModel.MethodInfo> inlineStack,
            String thisExpr,
            ValueSet thisValue,
            ProgramModel.MethodInfo sourceMethod
        ) {
            this.frame = frame;
            this.inlineStack = inlineStack;
            this.thisExpr = thisExpr;
            this.sourceMethod = sourceMethod;
            values.put("this", thisValue == null ? ValueSet.EMPTY : thisValue);
        }

        static RenderContext root(MethodFrame frame, ProgramModel model) {
            ValueSet thisValue = ValueSet.EMPTY;
            if (frame.method != null && frame.method.owner != null) {
                if (frame.method.isMain) {
                    thisValue = ValueSet.of(frame.method.owner.name);
                } else {
                    thisValue = ValueSet.ofAll(model.receiverClassesForMethod(frame.method));
                }
            }
            return new RenderContext(frame, new ArrayDeque<ProgramModel.MethodInfo>(), "this",
                thisValue, frame.method);
        }

        RenderContext child(
            String thisExpr,
            ValueSet thisValue,
            ProgramModel.MethodInfo sourceMethod
        ) {
            return new RenderContext(frame, inlineStack, thisExpr, thisValue, sourceMethod);
        }

        RenderContext copy() {
            RenderContext copy = new RenderContext(frame, inlineStack, thisExpr,
                values.get("this"), sourceMethod);
            copy.renames.putAll(renames);
            copy.values.putAll(values);
            return copy;
        }

        void mergeValues(RenderContext left, RenderContext right) {
            values.clear();
            values.putAll(left.values);
            for (Map.Entry<String, ValueSet> entry : right.values.entrySet()) {
                ValueSet current = values.get(entry.getKey());
                values.put(entry.getKey(), current == null ? entry.getValue() : current.join(entry.getValue()));
            }
        }
    }
}
