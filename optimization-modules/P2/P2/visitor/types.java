package visitor;

import java.util.HashMap;
import syntaxtree.*;

public class types extends GJDepthFirst<String, String> {
    HashMap<String, Types> ClassMethod_table;
    String cur_class = null;

    public class Types {
        HashMap<String, String> types;

        Types() {
            types = new HashMap<String, String>();
        }

        public void add_type(String var_name, String var_type) {
            types.put(var_name, var_type);
        }

        public String get_type(String var_name) {
            return types.get(var_name);
        }
    }

    public types(HashMap<String, Types> ClassMethod_table) {
        this.ClassMethod_table = ClassMethod_table;
    }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "{"
     * f3 -> ( SimpleVarDeclaration() )*
     * f4 -> ( MethodDeclaration() )*
     * f5 -> "}"
     */
    public String visit(ClassDeclaration n, String argu) {
        String _ret = null;
        String className = n.f1.f0.tokenImage;
        cur_class = className;
        ClassMethod_table.put(className, new Types());
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return _ret;
    }

    /**
     * f0 -> Type()
     * f1 -> Identifier()
     * f2 -> ";"
     */
    public String visit(SimpleVarDeclaration n, String argu) {
        String _ret = null;
        String varType = n.f0.accept(this, argu);
        String varName = n.f1.f0.tokenImage;
        ClassMethod_table.get(cur_class).add_type(varName, varType);
        return _ret;
    }

    /**
     * f0 -> "class"
     * f1 -> Identifier()
     * f2 -> "extends"
     * f3 -> Identifier()
     * f4 -> "{"
     * f5 -> ( SimpleVarDeclaration() )*
     * f6 -> ( MethodDeclaration() )*
     * f7 -> "}"
     */
    public String visit(ClassExtendsDeclaration n, String argu) {
        String _ret = null;
        String className = n.f1.f0.tokenImage;
        String parentClassName = n.f3.f0.tokenImage;
        Types parentTypes = ClassMethod_table.get(parentClassName);
        ClassMethod_table.put(className, parentTypes);
        cur_class = className;
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        return _ret;
    }

    /**
     * f0 -> "public"
     * f1 -> Type()
     * f2 -> Identifier()
     * f3 -> "("
     * f4 -> ( FormalParameterList() )?
     * f5 -> ")"
     * f6 -> "{"
     * f7 -> ( VarDeclaration() )*
     * f8 -> ( Statement() )*
     * f9 -> "return"
     * f10 -> Expression()
     * f11 -> ";"
     * f12 -> "}"
     */
    public String visit(MethodDeclaration n, String argu) {
        String _ret = null;
        String returnType = n.f1.accept(this, argu);
        String methodName = n.f2.f0.tokenImage;
        ClassMethod_table.get(cur_class).add_type(methodName, returnType);
        return _ret;
    }

    /**
     * f0 -> ArrayType()
     * | BooleanType()
     * | IntegerType()
     * | Identifier()
     */
    public String visit(Type n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
     * f0 -> "int"
     * f1 -> "["
     * f2 -> "]"
     */
    public String visit(ArrayType n, String argu) {
        return "int[]";
    }

    /**
     * f0 -> "boolean"
     */
    public String visit(BooleanType n, String argu) {
        return "boolean";
    }

    /**
     * f0 -> "int"
     */
    public String visit(IntegerType n, String argu) {
        return "int";
    }

    /**
     * f0 -> <IDENTIFIER>
     */
    public String visit(Identifier n, String argu) {
        return n.f0.tokenImage;
    }
}
