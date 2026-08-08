package inliner;

import java.util.ArrayList;
import java.util.List;
import syntaxtree.ArgList;
import syntaxtree.ArgRest;
import syntaxtree.ArrayType;
import syntaxtree.BooleanType;
import syntaxtree.ConstOrId;
import syntaxtree.FormalParameter;
import syntaxtree.FormalParameterList;
import syntaxtree.FormalParameterRest;
import syntaxtree.Identifier;
import syntaxtree.IntegerType;
import syntaxtree.Node;
import syntaxtree.NodeChoice;
import syntaxtree.NodeOptional;
import syntaxtree.Type;

public final class InlinerUtil {
    private InlinerUtil() {
    }

    public static String id(Identifier id) {
        return id.f0.tokenImage;
    }

    public static String type(Type type) {
        Node choice = type.f0.choice;
        if (choice instanceof ArrayType) {
            return "int[]";
        }
        if (choice instanceof BooleanType) {
            return "boolean";
        }
        if (choice instanceof IntegerType) {
            return "int";
        }
        if (choice instanceof Identifier) {
            return id((Identifier) choice);
        }
        return choice.toString();
    }

    public static ProgramModel.VarInfo varInfo(Type type, Identifier name) {
        return new ProgramModel.VarInfo(type(type), id(name));
    }

    public static List<ProgramModel.VarInfo> formalParams(NodeOptional optional) {
        List<ProgramModel.VarInfo> params = new ArrayList<ProgramModel.VarInfo>();
        if (!optional.present()) {
            return params;
        }
        FormalParameterList list = (FormalParameterList) optional.node;
        addParam(params, list.f0);
        for (Node node : list.f1.nodes) {
            addParam(params, ((FormalParameterRest) node).f1);
        }
        return params;
    }

    private static void addParam(List<ProgramModel.VarInfo> params, FormalParameter param) {
        params.add(varInfo(param.f0, param.f1));
    }

    public static List<ConstOrId> args(NodeOptional optional) {
        List<ConstOrId> args = new ArrayList<ConstOrId>();
        if (!optional.present()) {
            return args;
        }
        ArgList list = (ArgList) optional.node;
        args.add(list.f0);
        for (Node node : list.f1.nodes) {
            args.add(((ArgRest) node).f1);
        }
        return args;
    }

    public static Node choice(NodeChoice choice) {
        return choice.choice;
    }
}
