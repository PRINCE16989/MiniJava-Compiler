package visitor;

import java.util.Vector;
import helpers.*;
import syntaxtree.*;

public class typeChecker extends GJDepthFirst<String, String> {
    public typeChecker(symbolTable data) {
        this.data = data;
    }

    symbolTable data;
    String cur_class = "";
    String cur_method = "";

    Boolean Compatible_types(String s1, String s2) {
        if(s1.equals(s2)) return true;
        if(s1.equals("int") || s1.equals("boolean") || s1.equals("int[]") || s1.startsWith("Function<")) return false;
        if(s2.equals("int") || s2.equals("boolean") || s2.equals("int[]") || s2.startsWith("Function<")) return false;          
        collector class1 = data.get_class(s1);
        collector class2 = data.get_class(s2);
        while(class2 != null) {
            if(data.inheritMap.containsKey(class2)) {
                if(data.inheritMap.get(class2) == class1) 
                    return true;
            }
            class2 = data.inheritMap.get(class2);
        }
        return false;
    }
    
    public void print_status() {
        if(cur_class != "") System.out.println("Currently in class : " + cur_class);
        if(cur_method != "") System.out.println("Currently in method : " + cur_method);
        System.out.println();
        System.out.println("Current classes...");
        System.out.println();

        // System.out.println("fields in cur_method : ");
        // for(String key : method_fields.keySet()) {
        //     System.out.println(key + " : " + method_fields.get(key));
        // }
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
    public String visit(MainClass n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        cur_class = n.f1.accept(this, "return");
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        n.f8.accept(this, argu);
        n.f9.accept(this, argu);
        n.f10.accept(this, argu);
        n.f11.accept(this, "return");
        n.f12.accept(this, argu);
        n.f13.accept(this, argu);
        n.f14.accept(this, argu);
        n.f15.accept(this, argu);
        n.f16.accept(this, argu);
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
    public String visit(ClassDeclaration n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, "return");
        cur_class = n.f1.f0.toString();
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        cur_class = "";
        return _ret;
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
    public String visit(ClassExtendsDeclaration n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, "return");
        cur_class = n.f1.f0.toString();
        n.f2.accept(this, argu);
        n.f3.accept(this, "defined_class");
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        cur_class = "";
        return _ret;
    }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
    public String visit(VarDeclaration n, String argu) {
        String _ret=null;
        n.f0.accept(this, "defined_type");
        n.f1.accept(this, "return");
        n.f2.accept(this, argu);
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
        String _ret=null;
        n.f0.accept(this, argu);
        String expected_return_type = n.f1.accept(this, "defined_type");
        n.f2.accept(this, "return");
        cur_method = n.f2.f0.toString();
        data.valid_method(cur_method, cur_class);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        n.f7.accept(this, argu);
        n.f8.accept(this, argu);
        n.f9.accept(this, argu);
        String return_type = "";
        if(expected_return_type.startsWith("Function<")){
            return_type = n.f10.accept(this, expected_return_type);
        } else return_type = n.f10.accept(this, "generic");
        n.f11.accept(this, argu);
        n.f12.accept(this, argu);
        if(!Compatible_types(expected_return_type, return_type)) 
            throw new TE("return type mismatch in " + cur_method + " of class : " + cur_class);
        cur_method = "";
        return _ret;
    }

    /**
    * f0 -> Type()
    * f1 -> Identifier()
    */
    public String visit(FormalParameter n, String argu) {
        String _ret=null;
        n.f0.accept(this, "defined_type");
        n.f1.accept(this, "return");
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
    public String visit(Type n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> "int"
    * f1 -> "["
    * f2 -> "]"
    */
    public String visit(ArrayType n, String argu) {
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        return "int[]";
    }

    /**
    * f0 -> "boolean"
    */
    public String visit(BooleanType n, String argu) {
        n.f0.accept(this, argu);
        return "boolean";
    }

    /**
    * f0 -> "int"
    */
    public String visit(IntegerType n, String argu) {
        n.f0.accept(this, argu);
        return "int";
    }
    
    /**
    * f0 -> "Function"
    * f1 -> "<"
    * f2 -> Identifier()
    * f3 -> ","
    * f4 -> Identifier()
    * f5 -> ">"
    */
    public String visit(LambdaType n, String argu) {
        if(!data.imported_lambda) {
            throw new TE("Type error ; lambda not imported");
        }
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        String arg_type = n.f2.accept(this, "defined_type");
        n.f3.accept(this, argu);
        String ret_type = n.f4.accept(this, "defined_type");
        n.f5.accept(this, argu);
        return ("Function<" + arg_type + "," + ret_type + ">");
    }

    /**
    * f0 -> Identifier()
    * f1 -> "="
    * f2 -> Expression()
    * f3 -> ";"
    */
    public String visit(AssignmentStatement n, String argu) {
        String _ret=null;
        String type = n.f0.accept(this, "generic");
        n.f1.accept(this, argu);
        n.f2.accept(this, type);
        String return_type;
        if(type.startsWith("Function<")) {
            return_type = n.f2.accept(this, type);
        } else {
            return_type = n.f2.accept(this, "generic");
        }
        if(!Compatible_types(type, return_type))
            throw new TE("Type error : Assignment of incompatible types. Variable " + n.f0.f0.toString() + " of type " + type + " assigned expression of type " + return_type);
        return _ret;
    }

    /**
    * f0 -> Identifier()
    * f1 -> "["
    * f2 -> Expression()
    * f3 -> "]"
    * f4 -> "="
    * f5 -> Expression()
    * f6 -> ";"
    */
    public String visit(ArrayAssignmentStatement n, String argu) {
        String _ret=null;
        String type = n.f0.accept(this, "generic");
        if(!type.equals("int[]")) 
            throw new TE("Type error : Array assignment to non array variable " + n.f0.f0.toString() + " of type " + type);
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, "int");
        n.f6.accept(this, argu);
        return _ret;
    }

    /**
    * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
    public String visit(IfthenStatement n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, "boolean");
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return _ret;
    }

    /**
    * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    * f5 -> "else"
    * f6 -> Statement()
    */
    public String visit(IfthenElseStatement n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, "boolean");
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        n.f5.accept(this, argu);
        n.f6.accept(this, argu);
        return _ret;
    }

    /**
    * f0 -> "while"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
    public String visit(WhileStatement n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, "boolean");
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return _ret;
   }

    /**
    * f0 -> "System.out.println"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> ";"
    */
    public String visit(PrintStatement n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return _ret;
    }

    /**
    * f0 -> OrExpression()
    *       | AndExpression()
    *       | CompareExpression()
    *       | neqExpression()
    *       | AddExpression()
    *       | MinusExpression()
    *       | TimesExpression()
    *       | DivExpression()
    *       | ArrayLookup()
    *       | ArrayLength()
    *       | MessageSend()
    *       | LambdaExpression()
    *       | PrimaryExpression()
    */
    public String visit(Expression n, String argu) {
        String type = n.f0.accept(this, argu);
        if(!argu.equals("generic") && !Compatible_types(argu, type)) 
            throw new TE("Type error : Expression expected " + argu + " found " + type); 
        return type;
    }

    /**
    * f0 -> "("
    * f1 -> Identifier()
    * f2 -> ")"
    * f3 -> "->"
    * f4 -> Expression()
    */
    public String visit(LambdaExpression n, String argu) {
        if(!argu.startsWith("Function<")) 
            throw new TE("Type error : Lambda expression requires function type. Found " + argu);
        n.f0.accept(this, argu);
        String param = n.f1.accept(this, "return");
        String expected_type = argu.substring(9, argu.indexOf(','));
        String expected_return_type = argu.substring(argu.indexOf(',') + 1, argu.length() - 1);
        data.add_field(cur_method, cur_class, param, expected_type);
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        String return_type = n.f4.accept(this, "generic");
        if(!Compatible_types(expected_return_type, return_type)) 
            throw new TE("Lambda return type mismatch expected " + expected_return_type + " found " + return_type);
        data.remove_field(cur_method, cur_class, param);
        return argu;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "&&"
    * f2 -> PrimaryExpression()
    */
    public String visit(AndExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("boolean")) 
            throw new TE("Type error : && operator returns boolean expected :" + argu);
        n.f0.accept(this, "boolean");
        n.f1.accept(this, argu);
        n.f2.accept(this, "boolean");
        return "boolean";
    }

     /**
    * f0 -> PrimaryExpression()
    * f1 -> "||"
    * f2 -> PrimaryExpression()
    */
    public String visit(OrExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("boolean")) 
            throw new TE("Type error : || operator returns boolean expected : " + argu);
        n.f0.accept(this, "boolean");
        n.f1.accept(this, argu);
        n.f2.accept(this, "boolean");
        return "boolean";
    }

     /**
    * f0 -> PrimaryExpression()
    * f1 -> "<="
    * f2 -> PrimaryExpression()
    */
    public String visit(CompareExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("boolean")) {
            throw new TE("Type error : <= operator returns boolean expected :" + argu);
        }
        n.f0.accept(this, "int");
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        return "boolean";
    }

     /**
    * f0 -> PrimaryExpression()
    * f1 -> "!="
    * f2 -> PrimaryExpression()
    */
    public String visit(neqExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("boolean")) 
            throw new TE("Type error : != operator returns boolean expected :" + argu);
        String type1  = n.f0.accept(this, "generic");
        n.f1.accept(this, argu);
        String type2 = n.f2.accept(this, "generic");
        if(!Compatible_types(type1, type2) && !Compatible_types(type2, type1))
            throw new TE("Type error : != operator requires both operands to be of same or compatible types. Found " + type1 + " and " + type2);
        return "boolean";
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
    public String visit(AddExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int")) 
            throw new TE("Type error : + operator returns int expected :" + argu);
        n.f0.accept(this, "int");
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        return "int";
    }    

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
    public String visit(MinusExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int")) 
            throw new TE("Type error : - operator returns int expected :" + argu);
        n.f0.accept(this, "int");
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        return "int";
    }    
    
    /**
    * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
    public String visit(TimesExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int")) 
            throw new TE("Type error : * operator returns int expected :" + argu);
        n.f0.accept(this, "int");
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        return"int";
    }    
    
    /**
    * f0 -> PrimaryExpression()
    * f1 -> "/"
    * f2 -> PrimaryExpression()
    */
    public String visit(DivExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int")) 
            throw new TE("Type error : / operator returns int expected :" + argu);
        n.f0.accept(this, "int");
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        return "int";
    }   

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "["
    * f2 -> PrimaryExpression()
    * f3 -> "]"
    */
    public String visit(ArrayLookup n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int")) 
            throw new TE("Type error : Array lookup returns int expected :" + argu);
        n.f0.accept(this, "int[]");
        n.f1.accept(this, argu);
        n.f2.accept(this, "int");
        n.f3.accept(this, argu);
        return "int";
    }
     
    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> "length"
    */
    public String visit(ArrayLength n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int")) 
            throw new TE("Type error : Array length returns int expected :" + argu);
        n.f0.accept(this, "int[]");
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        return "int";
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( ExpressionList() )?
    * f5 -> ")"
    */
    public String visit(MessageSend n, String argu) {
        String class_type = n.f0.accept(this, "generic");
        n.f1.accept(this, argu);
        if(class_type.equals("int[]")) throw new SNF("Type error : Arrays do not have methods");
        String fun_name = n.f2.accept(this, "return");
        n.f3.accept(this, argu);

        Vector<String> param_types = new Vector<>();
        String ret_type = null;
        
        if(class_type.startsWith("Function<")){
            if(fun_name ==null || !fun_name.equals("apply")) 
                throw new TE("Type error : Function type only has apply method");
            
            String arg_type = class_type.substring(9, class_type.indexOf(','));
            ret_type = class_type.substring(class_type.indexOf(',') + 1, class_type.length() - 1);
            
            param_types.add(arg_type);
        } else {
            // collector class_collector = data.get_class(class_type);
            // collector.Method method = class_collector.get_method(fun_name);
            collector.Method method = data.get_method(fun_name, class_type);
            param_types = method.param_list;
            ret_type = method.return_type;
        }

        int expected_params = param_types.size();
        int param_index = 0;

        if(n.f4.present()) {
            ExpressionList expList = (ExpressionList) n.f4.node;
            if(expected_params != expList.f1.size() + 1)
                throw new TE("Method " + fun_name + " in class " + class_type + " expects " + expected_params + " parameters. Found " + expList.f1.size());
            
            String cur_param = param_types.get(param_index++);
            
            String return_type;
            if(cur_param.startsWith("Function<")) {
                return_type = expList.f0.accept(this, cur_param);
            } else {
                return_type = expList.f0.accept(this, "generic");
            }
            if(!Compatible_types(cur_param, return_type))
                throw new TE("Type error : Method " + fun_name + " in class " + class_type + " expects parameter of type " + cur_param + ". Found " + return_type);
            
            for (int i = 0; i < expList.f1.size(); i++) {
                ExpressionRest expRest = (ExpressionRest) expList.f1.elementAt(i);
                cur_param = param_types.get(param_index++);
                if(cur_param.startsWith("Function<")) {
                    return_type = expRest.f1.accept(this, cur_param);
                } else {
                    return_type = expRest.f1.accept(this, "generic");
                }
                if(!Compatible_types(cur_param, return_type))
                    throw new TE("Type error : Method " + fun_name + " in class " + class_type + " expects parameter of type " + cur_param + ". Found " + return_type);
            }
        }
        // n.f4.accept(this, argu);
        if(!argu.equals("generic") && !argu.equals(ret_type)) 
            throw new TE("Return type mismatch in method " + cur_method + " in class " + cur_class + ". Expected " + argu + " found " + ret_type);
        n.f5.accept(this, argu);
        return ret_type;
    }

    /**
    * f0 -> IntegerLiteral()
    *       | TrueLiteral()
    *       | FalseLiteral()
    *       | Identifier()
    *       | ThisExpression()
    *       | ArrayAllocationExpression()
    *       | AllocationExpression()
    *       | NotExpression()
    *       | BracketExpression()
    */
    public String visit(PrimaryExpression n, String argu) {
        String ret = n.f0.accept(this, argu);
        if(!argu.equals("generic") && !argu.equals(ret))
            throw new TE("pe expected type is " + argu + " found " + ret);
        return ret; 
    }

    /**
    * f0 -> <INTEGER_LITERAL>
    */
    public String visit(IntegerLiteral n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int")) 
            throw new TE("Type error : Integer literal requires int type given " + argu);
        n.f0.accept(this, argu);
        return "int";
    }

    /**
    * f0 -> "true"
    */
    public String visit(TrueLiteral n, String argu) {
        if(!argu.equals("generic") && !argu.equals("boolean")) 
            throw new TE("Type error : true literal requires boolean type");
        n.f0.accept(this, argu);
        return "boolean";
    }

    /**
    * f0 -> "false"
    */
    public String visit(FalseLiteral n, String argu) {
        if(!argu.equals("generic") && !argu.equals("boolean")) 
            throw new TE("Type error : false literal requires boolean type");
        n.f0.accept(this, argu);
        return "boolean";
    }

    /**
    * f0 -> <IDENTIFIER>
    */
    public String visit(Identifier n, String argu) {
        n.f0.accept(this, argu);
        String type = null;
        if(argu.equals("return")) return n.f0.toString();
        if(argu.equals("generic")) {
            type = data.get_type(n.f0.toString(), cur_method, cur_class);
            if(type == null) 
                throw new TE("Type error : Undefined variable " + n.f0.toString());
            return type;
        }
        else if(argu.equals("defined_class")) 
            return data.get_class_type(n.f0.toString());
        else if(argu.equals("defined_type")) {
            String var = n.f0.toString();
            if(var.equals("int") || var.equals("boolean") || var.startsWith("Function<") || var.equals("int[]")) 
                return var;
            if(var.equals("Integer")) return "int";
            if(var.equals("Boolean")) return "boolean";
            type = data.get_class_type(var);
            if(type == null) 
                throw new TE("Type error : Undefined type " + var);
            return type;
        }
        else {
            type = data.get_type(n.f0.toString(), cur_method, cur_class);
            if(!argu.equals(type)) 
                throw new TE("Identifier expected of type " + argu + " given " + type);
            return type;
        }
    }

    /**
    * f0 -> "this"
    */
    public String visit(ThisExpression n, String argu) {
        n.f0.accept(this, argu);
        if(!argu.equals("generic") && !argu.equals(cur_class))
            throw new TE("Type error : this requires " + cur_class + " type");
        return cur_class;
    }

    /**
    * f0 -> "new"
    * f1 -> "int"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
    public String visit(ArrayAllocationExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("int[]")) 
            throw new TE("Type error : new int[] requires int[] type");
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        n.f3.accept(this, "int");
        n.f4.accept(this, argu);
        return "int[]";
    }

    /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
    public String visit(AllocationExpression n, String argu) {
        n.f0.accept(this, argu);
        String type = n.f1.accept(this, "defined_class");
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        if(!argu.equals("generic") && !argu.equals(type)) 
            throw new TE("Type error : new " + type + " requires " + argu + " type");
        return type;
    }
    /**
    * f0 -> "!"
    * f1 -> Expression()
    */
    public String visit(NotExpression n, String argu) {
        if(!argu.equals("generic") && !argu.equals("boolean")) 
            throw new TE("Type error : ! operator requires boolean type");
        n.f0.accept(this, argu);
        n.f1.accept(this, "boolean");
        return ("boolean");
    }

    /**
    * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
    public String visit(BracketExpression n, String argu) {
        n.f0.accept(this, argu);
        String ret = n.f1.accept(this, argu);
        if(!argu.equals("generic") && !argu.equals(ret)) 
            throw new TE("Type error : Bracket expression expected " + argu + " found " + ret);
        return ret;
    }
}
