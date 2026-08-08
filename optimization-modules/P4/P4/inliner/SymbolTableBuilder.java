package inliner;

import syntaxtree.ClassDeclaration;
import syntaxtree.ClassExtendsDeclaration;
import syntaxtree.MainClass;
import syntaxtree.MethodDeclaration;
import syntaxtree.Node;
import syntaxtree.VarDeclaration;
import visitor.GJVoidDepthFirst;

public final class SymbolTableBuilder extends GJVoidDepthFirst<ProgramModel> {
    public static ProgramModel build(syntaxtree.Goal goal) {
        ProgramModel model = new ProgramModel();
        goal.accept(new SymbolTableBuilder(), model);
        return model;
    }

    @Override
    public void visit(MainClass n, ProgramModel model) {
        model.mainClassNode = n;
        ProgramModel.ClassInfo classInfo = model.ensureClass(InlinerUtil.id(n.f1));
        classInfo.node = n;

        ProgramModel.MethodInfo main = new ProgramModel.MethodInfo(classInfo, n);
        for (Node node : n.f14.nodes) {
            VarDeclaration decl = (VarDeclaration) node;
            main.addLocal(InlinerUtil.varInfo(decl.f0, decl.f1));
        }
        model.mainMethod = main;
    }

    @Override
    public void visit(ClassDeclaration n, ProgramModel model) {
        ProgramModel.ClassInfo classInfo = model.ensureClass(InlinerUtil.id(n.f1));
        classInfo.parentName = null;
        classInfo.node = n;
        addFields(classInfo, n.f3);
        addMethods(model, classInfo, n.f4);
    }

    @Override
    public void visit(ClassExtendsDeclaration n, ProgramModel model) {
        ProgramModel.ClassInfo classInfo = model.ensureClass(InlinerUtil.id(n.f1));
        classInfo.parentName = InlinerUtil.id(n.f3);
        classInfo.node = n;
        addFields(classInfo, n.f5);
        addMethods(model, classInfo, n.f6);
    }

    private void addFields(ProgramModel.ClassInfo classInfo, syntaxtree.NodeListOptional fields) {
        classInfo.fields.clear();
        for (Node node : fields.nodes) {
            VarDeclaration decl = (VarDeclaration) node;
            ProgramModel.VarInfo var = InlinerUtil.varInfo(decl.f0, decl.f1);
            classInfo.fields.put(var.name, var);
        }
    }

    private void addMethods(
        ProgramModel model,
        ProgramModel.ClassInfo classInfo,
        syntaxtree.NodeListOptional methods
    ) {
        classInfo.methods.clear();
        for (Node node : methods.nodes) {
            MethodDeclaration decl = (MethodDeclaration) node;
            ProgramModel.MethodInfo method = new ProgramModel.MethodInfo(
                classInfo,
                InlinerUtil.id(decl.f2),
                InlinerUtil.type(decl.f1),
                decl);
            for (ProgramModel.VarInfo param : InlinerUtil.formalParams(decl.f4)) {
                method.addParam(param);
            }
            for (Node localNode : decl.f7.nodes) {
                VarDeclaration localDecl = (VarDeclaration) localNode;
                method.addLocal(InlinerUtil.varInfo(localDecl.f0, localDecl.f1));
            }
            classInfo.methods.put(method.name, method);
            model.registerMethod(method);
        }
    }
}
