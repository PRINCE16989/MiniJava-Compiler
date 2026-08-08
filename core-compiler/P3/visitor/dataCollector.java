package visitor;
import java.util.*;
import helpers.*;
import syntaxtree.*;

public class dataCollector extends GJNoArguDepthFirst<String> {
    public symbolTable data = new symbolTable();
    public Map<String, Table> table = new HashMap<>();
    String cur_class = "";
    String cur_method = "";


    /**
    * f0 -> "import"
    * f1 -> "java.util.function.Function"
    * f2 -> ";"
    */
    public String visit(ImportFunction n) {
        data.imported_lambda = true;
        // data.add_class("function_int_int");
        // data.get_class("fucniton_int_int").add_method("apply");

        // data.add_class("function_int_boolean");
        // data.get_class("fucniton_int_boolean").add_method("apply");

        // data.add_class("function_boolean_int");
        // data.get_class("fucniton_boolean_int").add_method("apply");

        // data.add_class("function_boolean_boolean");
        // data.get_class("fucniton_boolean_boolean").add_method("apply");
        return null;
    }
    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> "public"
    * f4 -> "static"
    * f5 -> "void"
    * f6 -> "main"
    * f7 -> "("
    * f8 -> "String"
    * f9 -> "["
    * f10 -> "]"
    * f11 -> Identifier()
    * f12 -> ")"
    * f13 -> "{"
    * f14 -> PrintStatement()
    * f15 -> "}"
    * f16 -> "}"
    */
    public String visit(MainClass n) {
        String _ret=null;
        n.f0.accept(this);
        cur_class = n.f1.accept(this);
        data.add_class(cur_class);
        cur_class = "";
        return _ret;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "{"
    * f3 -> ( VarDeclaration() )*
    * f4 -> ( MethodDeclaration() )*
    * f5 -> "}"
    */
    public String visit(ClassDeclaration n) {
        String class_name = n.f1.f0.toString();
        data.add_class(class_name);
        table.put(class_name, new Table());
        cur_class = class_name;
        n.f3.accept(this);
        n.f4.accept(this);
        cur_class = "";
        return null;
    }

    /**
    * f0 -> "class"
    * f1 -> Identifier()
    * f2 -> "extends"
    * f3 -> Identifier()
    * f4 -> "{"
    * f5 -> ( VarDeclaration() )*
    * f6 -> ( MethodDeclaration() )*
    * f7 -> "}"
    */
    public String visit(ClassExtendsDeclaration n) {
        String class_name = n.f1.f0.toString();
        data.add_class(class_name);
        cur_class = class_name;
        String extends_class = n.f3.f0.toString();
        data.add_inheritence(cur_class, extends_class);
        n.f5.accept(this);
        n.f6.accept(this);
        cur_class = "";
        return null;
   }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
    public String visit(VarDeclaration n) {
        String type = n.f0.accept(this);
        String var = n.f1.f0.toString();
        data.add_field(cur_method, cur_class, var, type);
        if(cur_method == null || cur_method.isEmpty()) {
            if(!data.inheritMap.containsKey(data.classes.get(cur_class))) {
                Table cur_table = table.get(cur_class);
                cur_table.field_offset.put(cur_class + "_" + var, cur_table.cur_off);
                cur_table.cur_off += 4;
            }
        }
        return null;
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
    @Override
    public String visit(MethodDeclaration n) {
        String _ret=null;
        n.f0.accept(this);
        String expected_return_type = n.f1.accept(this);
        n.f2.accept(this);
        String method_name = n.f2.f0.toString();
        data.add_method(method_name, cur_class);
        cur_method = method_name;
        if(!data.inheritMap.containsKey(data.classes.get(cur_class))) {
            Table cur_table = table.get(cur_class);
            pair<String, Integer> vtable_entry = new pair<>(cur_class + "_" + cur_method,cur_table.method_offset);
            cur_table.vtable.put(cur_method, vtable_entry);
            cur_table.method_offset += 4;
        }
        collector.Method currMethod = data.get_class(cur_class).get_method(cur_method);
        currMethod.return_type = expected_return_type;

        n.f4.accept(this);
        n.f7.accept(this);
        cur_method = "";
        return _ret;
    }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    */
    @Override
    public String visit(FormalParameter n) {
        String _ret=null;
        String type = n.f0.accept(this);
        String id = n.f1.accept(this);
        if(cur_method == null) 
            throw new Error("Parameter outside method");
        collector current_class = data.get_class(cur_class);
        current_class.get_method(cur_method).params.put(id, type);
        current_class.get_method(cur_method).param_list.add(type);
        return _ret;
    }
    
    /**
    * f0 -> ArrayType()
    *       | BooleanType()
    *       | IntegerType()
    *       | Identifier()
    *       | LambdaType()
    */
    @Override
    public String visit(Type n) {
        return n.f0.accept(this);
    }

    /**
    * f0 -> "Function"
    * f1 -> "<"
    * f2 -> Identifier()
    * f3 -> ","
    * f4 -> Identifier()
    * f5 -> ">"
    */
    @Override
    public String visit(LambdaType n) {
        if(!data.imported_lambda) {
            throw new Error("Type error ; lambda not imported");
        }
        n.f0.accept(this);
        n.f1.accept(this);
        String arg_type = n.f2.accept(this);
        if(arg_type.equals("Integer")) arg_type = "int";
        if(arg_type.equals("Boolean")) arg_type = "boolean";
        n.f3.accept(this);
        String ret_type = n.f4.accept(this);
        if(ret_type.equals("Integer")) ret_type = "int";
        if(ret_type.equals("Boolean")) ret_type = "boolean";
        n.f5.accept(this);
        return ("function_" + arg_type + "_" + ret_type);
    }
}
