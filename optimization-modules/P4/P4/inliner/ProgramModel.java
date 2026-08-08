package inliner;

import java.util.ArrayList;
import java.util.Collection;
import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import syntaxtree.ConstOrId;
import syntaxtree.MainClass;
import syntaxtree.MethodDeclaration;
import syntaxtree.Node;
import syntaxtree.NodeListOptional;

public final class ProgramModel {
    public final Map<String, ClassInfo> classes = new LinkedHashMap<String, ClassInfo>();
    public final Set<MethodInfo> recursiveMethods =
        java.util.Collections.newSetFromMap(new IdentityHashMap<MethodInfo, Boolean>());
    public MainClass mainClassNode;
    public MethodInfo mainMethod;

    private final IdentityHashMap<MethodDeclaration, MethodInfo> methodsByNode =
        new IdentityHashMap<MethodDeclaration, MethodInfo>();

    public ClassInfo ensureClass(String name) {
        ClassInfo info = classes.get(name);
        if (info == null) {
            info = new ClassInfo(name);
            classes.put(name, info);
        }
        return info;
    }

    public void registerMethod(MethodInfo method) {
        if (method.node != null) {
            methodsByNode.put(method.node, method);
        }
    }

    public MethodInfo methodFor(MethodDeclaration node) {
        return methodsByNode.get(node);
    }

    public boolean isClassType(String typeName) {
        return classes.containsKey(typeName);
    }

    public Collection<MethodInfo> methods() {
        List<MethodInfo> result = new ArrayList<MethodInfo>();
        for (ClassInfo classInfo : classes.values()) {
            result.addAll(classInfo.methods.values());
        }
        return result;
    }

    public MethodInfo resolveMethod(String className, String methodName) {
        ClassInfo current = classes.get(className);
        while (current != null) {
            MethodInfo method = current.methods.get(methodName);
            if (method != null) {
                return method;
            }
            current = current.parentName == null ? null : classes.get(current.parentName);
        }
        return null;
    }

    public VarInfo resolveField(String className, String fieldName) {
        ClassInfo current = classes.get(className);
        while (current != null) {
            VarInfo field = current.fields.get(fieldName);
            if (field != null) {
                return field;
            }
            current = current.parentName == null ? null : classes.get(current.parentName);
        }
        return null;
    }

    public String lookupVariableType(MethodInfo method, String variableName) {
        if (method == null) {
            return null;
        }
        VarInfo local = method.localsByName.get(variableName);
        if (local != null) {
            return local.type;
        }
        VarInfo param = method.paramsByName.get(variableName);
        if (param != null) {
            return param.type;
        }
        if (method.owner != null) {
            VarInfo field = resolveField(method.owner.name, variableName);
            if (field != null) {
                return field.type;
            }
        }
        return null;
    }

    public LinkedHashSet<String> subclassesInclusive(String className) {
        LinkedHashSet<String> result = new LinkedHashSet<String>();
        for (String candidate : classes.keySet()) {
            if (isSubclassOrSame(candidate, className)) {
                result.add(candidate);
            }
        }
        if (result.isEmpty() && classes.containsKey(className)) {
            result.add(className);
        }
        return result;
    }

    public LinkedHashSet<String> receiverClassesForMethod(MethodInfo method) {
        LinkedHashSet<String> result = new LinkedHashSet<String>();
        if (method == null || method.owner == null || method.isMain) {
            return result;
        }
        for (String className : classes.keySet()) {
            if (resolveMethod(className, method.name) == method) {
                result.add(className);
            }
        }
        if (result.isEmpty()) {
            result.add(method.owner.name);
        }
        return result;
    }

    public boolean isSubclassOrSame(String candidate, String base) {
        ClassInfo current = classes.get(candidate);
        while (current != null) {
            if (current.name.equals(base)) {
                return true;
            }
            current = current.parentName == null ? null : classes.get(current.parentName);
        }
        return false;
    }

    public static final class ClassInfo {
        public final String name;
        public String parentName;
        public Node node;
        public final Map<String, VarInfo> fields = new LinkedHashMap<String, VarInfo>();
        public final Map<String, MethodInfo> methods = new LinkedHashMap<String, MethodInfo>();

        private ClassInfo(String name) {
            this.name = name;
        }
    }

    public static final class MethodInfo {
        public final ClassInfo owner;
        public final String name;
        public final String returnType;
        public final MethodDeclaration node;
        public final NodeListOptional localDecls;
        public final NodeListOptional statements;
        public final ConstOrId returnValue;
        public final boolean isMain;
        public final List<VarInfo> params = new ArrayList<VarInfo>();
        public final List<VarInfo> locals = new ArrayList<VarInfo>();
        public final Map<String, VarInfo> paramsByName = new LinkedHashMap<String, VarInfo>();
        public final Map<String, VarInfo> localsByName = new LinkedHashMap<String, VarInfo>();

        public MethodInfo(ClassInfo owner, String name, String returnType, MethodDeclaration node) {
            this.owner = owner;
            this.name = name;
            this.returnType = returnType;
            this.node = node;
            this.localDecls = node.f7;
            this.statements = node.f8;
            this.returnValue = node.f10;
            this.isMain = false;
        }

        public MethodInfo(ClassInfo owner, MainClass mainClass) {
            this.owner = owner;
            this.name = "main";
            this.returnType = "void";
            this.node = null;
            this.localDecls = mainClass.f14;
            this.statements = mainClass.f15;
            this.returnValue = null;
            this.isMain = true;
        }

        public String qualifiedName() {
            return owner.name + "." + name;
        }

        public void addParam(VarInfo var) {
            params.add(var);
            paramsByName.put(var.name, var);
        }

        public void addLocal(VarInfo var) {
            locals.add(var);
            localsByName.put(var.name, var);
        }
    }

    public static final class VarInfo {
        public final String type;
        public final String name;

        public VarInfo(String type, String name) {
            this.type = type;
            this.name = name;
        }
    }
}
