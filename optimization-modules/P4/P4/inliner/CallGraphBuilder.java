package inliner;

import java.util.Collections;
import java.util.IdentityHashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.Set;
import syntaxtree.AllocationExpression;
import syntaxtree.Identifier;
import syntaxtree.MessageSend;
import syntaxtree.MessageSendStatement;
import syntaxtree.MethodDeclaration;
import syntaxtree.Node;
import syntaxtree.PrimaryExpression;
import syntaxtree.RetMessageSendStmt;
import syntaxtree.ThisExpression;
import syntaxtree.VoidMessageSendStmt;
import visitor.GJDepthFirst;
import visitor.GJVoidDepthFirst;

public final class CallGraphBuilder extends GJVoidDepthFirst<ProgramModel.MethodInfo> {
    private final ProgramModel model;
    private final MessageSendVisitor messageSendVisitor = new MessageSendVisitor();
    private final Map<ProgramModel.MethodInfo, LinkedHashSet<ProgramModel.MethodInfo>> graph =
        new IdentityHashMap<ProgramModel.MethodInfo, LinkedHashSet<ProgramModel.MethodInfo>>();

    private CallGraphBuilder(ProgramModel model) {
        this.model = model;
    }

    public static void markRecursiveMethods(syntaxtree.Goal goal, ProgramModel model) {
        CallGraphBuilder builder = new CallGraphBuilder(model);
        goal.accept(builder, null);
        builder.markRecursiveMethods();
    }

    @Override
    public void visit(syntaxtree.MainClass n, ProgramModel.MethodInfo ignored) {
        n.f15.accept(this, model.mainMethod);
    }

    @Override
    public void visit(MethodDeclaration n, ProgramModel.MethodInfo ignored) {
        ProgramModel.MethodInfo method = model.methodFor(n);
        if (method != null) {
            n.f8.accept(this, method);
        }
    }

    @Override
    public void visit(MessageSendStatement n, ProgramModel.MethodInfo caller) {
        if (caller == null) {
            return;
        }
        MessageSend message = n.f1.accept(messageSendVisitor, null);
        addEdges(caller, staticTargets(message, caller));
    }

    private void addEdges(
        ProgramModel.MethodInfo caller,
        LinkedHashSet<ProgramModel.MethodInfo> targets
    ) {
        if (targets.isEmpty()) {
            return;
        }
        LinkedHashSet<ProgramModel.MethodInfo> edges = graph.get(caller);
        if (edges == null) {
            edges = new LinkedHashSet<ProgramModel.MethodInfo>();
            graph.put(caller, edges);
        }
        edges.addAll(targets);
    }

    private LinkedHashSet<ProgramModel.MethodInfo> staticTargets(
        MessageSend message,
        ProgramModel.MethodInfo caller
    ) {
        LinkedHashSet<ProgramModel.MethodInfo> targets = new LinkedHashSet<ProgramModel.MethodInfo>();
        String methodName = InlinerUtil.id(message.f2);
        ValueSet receiverTypes = staticReceiverTypes(message.f0, caller);
        if (receiverTypes.isUnknown() || receiverTypes.isEmpty()) {
            addAllMethodsNamed(targets, methodName);
            return targets;
        }
        for (String className : receiverTypes.types) {
            ProgramModel.MethodInfo target = model.resolveMethod(className, methodName);
            if (target != null) {
                targets.add(target);
            } else {
                addAllMethodsNamed(targets, methodName);
            }
        }
        return targets;
    }

    private ValueSet staticReceiverTypes(PrimaryExpression receiver, ProgramModel.MethodInfo caller) {
        Node choice = receiver.f0.choice;
        if (choice instanceof Identifier) {
            String type = model.lookupVariableType(caller, InlinerUtil.id((Identifier) choice));
            return possibleForType(type);
        }
        if (choice instanceof ThisExpression) {
            if (caller == null || caller.owner == null) {
                return ValueSet.UNKNOWN;
            }
            if (caller.isMain) {
                return ValueSet.of(caller.owner.name);
            }
            return ValueSet.ofAll(model.receiverClassesForMethod(caller));
        }
        if (choice instanceof AllocationExpression) {
            return ValueSet.of(InlinerUtil.id(((AllocationExpression) choice).f1));
        }
        return ValueSet.UNKNOWN;
    }

    private ValueSet possibleForType(String type) {
        if (type == null || !model.isClassType(type)) {
            return ValueSet.UNKNOWN;
        }
        return ValueSet.ofAll(model.subclassesInclusive(type));
    }

    private void addAllMethodsNamed(
        LinkedHashSet<ProgramModel.MethodInfo> targets,
        String methodName
    ) {
        for (ProgramModel.MethodInfo method : model.methods()) {
            if (method.name.equals(methodName)) {
                targets.add(method);
            }
        }
    }

    private void markRecursiveMethods() {
        LinkedHashSet<ProgramModel.MethodInfo> allMethods = new LinkedHashSet<ProgramModel.MethodInfo>();
        allMethods.addAll(model.methods());
        if (model.mainMethod != null) {
            allMethods.add(model.mainMethod);
        }
        for (ProgramModel.MethodInfo method : allMethods) {
            LinkedHashSet<ProgramModel.MethodInfo> edges = graph.get(method);
            if (edges == null) {
                continue;
            }
            for (ProgramModel.MethodInfo next : edges) {
                if (next == method || reaches(next, method,
                    Collections.newSetFromMap(new IdentityHashMap<ProgramModel.MethodInfo, Boolean>()))) {
                    model.recursiveMethods.add(method);
                    break;
                }
            }
        }
    }

    private boolean reaches(
        ProgramModel.MethodInfo current,
        ProgramModel.MethodInfo target,
        Set<ProgramModel.MethodInfo> seen
    ) {
        if (current == target) {
            return true;
        }
        if (!seen.add(current)) {
            return false;
        }
        LinkedHashSet<ProgramModel.MethodInfo> edges = graph.get(current);
        if (edges == null) {
            return false;
        }
        for (ProgramModel.MethodInfo next : edges) {
            if (reaches(next, target, seen)) {
                return true;
            }
        }
        return false;
    }

    private static final class MessageSendVisitor extends GJDepthFirst<MessageSend, Void> {
        @Override
        public MessageSend visit(VoidMessageSendStmt n, Void unused) {
            return n.f0;
        }

        @Override
        public MessageSend visit(RetMessageSendStmt n, Void unused) {
            return n.f2;
        }
    }
}
