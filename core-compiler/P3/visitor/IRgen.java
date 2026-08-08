package visitor;
import helpers.*;
import java.util.*;
import syntaxtree.*;

public class IRgen extends GJDepthFirst<String, String> {
    String irCode = "";
    String cur_class = null;
    String cur_method = null;
    public Map<String, Table> offsets = null;
    Map<String, String> method_temp_vars = new HashMap<>();
    symbolTable data = new symbolTable();
    Integer method_var_no = 0;
    Integer label_no = 0;

    String lambda = "";
    Integer lambda_no = 0;
    Integer lambda_off = 4;
    String lambda_param = null;
    boolean in_lambda_decl = false;
    Map<String, Integer> lambda_class_fields = new HashMap<>();

    public IRgen(Map<String, Table> o, symbolTable s) {
        offsets = o;
        data = s;
        for(collector key : data.inheritMap.keySet()) {
            // System.out.println("building table for " + key.class_name);
            build_table(key);
        }
        // for(String key : offsets.keySet()) {
        //     System.out.println("vtable for " + key + "...");
        //     offsets.get(key).info();
        //     System.out.println();
        //  }
    }

    Integer get_offset_of_var_in_class(String id) {
        String temp_cls = cur_class;
        if (temp_cls == null) return null;
        while (true) {
            // if offsets doesn't have an entry for this class, we can't look up fields here
            if (offsets.containsKey(temp_cls)) {
                Table t = offsets.get(temp_cls);
                if (t.field_offset.containsKey(temp_cls + "_" + id)) {
                    return t.field_offset.get(temp_cls + "_" + id);
                }
            }

            // move to superclass if any
            collector clsObj = data.get_class(temp_cls);
            if (clsObj == null) return null;
            if (!data.inheritMap.containsKey(clsObj)) return null;
            temp_cls = data.inheritMap.get(clsObj).class_name;
        }
    }

    public void build_table(collector key) {
        if(offsets.containsKey(key.class_name)) return;
        collector ext_cls = data.inheritMap.get(key);
        if(offsets.containsKey(ext_cls.class_name)) {
            Table new_table = new Table(offsets.get(ext_cls.class_name));
            for(String x : key.methods.keySet()) {
                if(ext_cls.methods.containsKey(x)) {
                    Integer offset_of_overrided_method = offsets.get(ext_cls.class_name).vtable.get(x).second;
                    pair<String, Integer> vtable_entry = new pair<>(key.class_name + "_" + x,offset_of_overrided_method);
                    new_table.vtable.put(x, vtable_entry);
                    // new_table.method_offset += 4;
                } else {
                    pair<String, Integer> vtable_entry = new pair<>(key.class_name + "_" + x, new_table.method_offset);
                    new_table.vtable.put(x, vtable_entry);
                    new_table.method_offset += 4;
                }
            }
            for(String x : key.fields.keySet()) {
                new_table.field_offset.put(key.class_name + "_" + x, new_table.cur_off);
                new_table.cur_off += 4;
            }
            offsets.put(key.class_name, new_table);
        } else {
            build_table(ext_cls);
            build_table(key);
        }
    }

    public String new_label() {
        return "L" + label_no++;
    }

    public String get_new_temp() {
        return "TEMP " + method_var_no++;
    }
    
    /**
        * f0 -> ( ImportFunction() )?
        * f1 -> MainClass()
        * f2 -> ( TypeDeclaration() )*
        * f3 -> <EOF>
        */
    public String visit(Goal n, String argu) {
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        return irCode + lambda;
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
        method_var_no = 2;
        String stmt = n.f14.accept(this, argu);
        String temp = "MAIN\n" + stmt + "END\n";
        irCode += temp;
        return null;
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
        cur_class = n.f1.f0.toString();
        n.f4.accept(this, argu);
        cur_class = null;
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
        cur_class = n.f1.f0.toString();
        // for(int i = 0; i < n.f6.size(); ++i) {
        //     MethodDeclaration m = (MethodDeclaration) n.f6.elementAt(i);
        //     String fun_name = m.f2.f0.toString();
        //     // System.out.println(fun_name);
        //     String fun_po = offsets.get(cur_class).vtable.get(fun_name).first;
        //     if(fun_po.equals(cur_class + "_" + fun_name)) continue;
        //     m.accept(this, argu);
        // }
        n.f6.accept(this, argu);
        cur_class = null;
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
        n.f1.accept(this, argu);
        cur_method = n.f2.f0.toString();
        method_var_no = 0;
        method_temp_vars.put("this", get_new_temp());
        n.f4.accept(this, argu);
        irCode += "\n" + cur_class + "_" + cur_method + " [ " + method_var_no + " ]\n";
        irCode += "BEGIN\n";
        n.f7.accept(this, argu);
        for(int i = 0; i < n.f8.size(); i++) {
            irCode += n.f8.elementAt(i).accept(this, argu);
        }
        irCode += "\nRETURN ";
        String return_expr  = n.f10.accept(this, argu);
        irCode += return_expr;
        irCode += "\nEND\n";
        method_temp_vars.clear(); 
        return _ret;
    }

    /**
        * f0 -> Type()
        * f1 -> Identifier()
        */
    public String visit(FormalParameter n, String argu) {
        String _ret=null;
        method_temp_vars.put(n.f1.f0.toString(), get_new_temp());
        return _ret;
    }

    public String visit(Statement n, String argu) {
        String cmd = n.f0.accept(this, argu);
        return cmd;
    }

    /**
    * f0 -> "{"
    * f1 -> ( Statement() )*
    * f2 -> "}"
    */
    public String visit(Block n, String argu) {
        String cmd = "";
        for(int i = 0; i < n.f1.size(); ++i) {
            cmd += n.f1.elementAt(i).accept(this, argu);
            cmd += "\n";
        }
        return cmd;
    }
    /**
        * f0 -> Identifier()
        * f1 -> "="
        * f2 -> Expression()
        * f3 -> ";"
        */
    public String visit(AssignmentStatement n, String argu) {
        String id = n.f0.f0.toString();
        String type = data.get_type(id, cur_method, cur_class);
        String expr;
        if(type.startsWith("function_")) {
            in_lambda_decl = true;
            lambda_off = 4;
            lambda_param = null;
            lambda_class_fields.clear();
            expr = n.f2.accept(this, argu);
            in_lambda_decl = false;
        }
        else expr = n.f2.accept(this, argu);
        String cmd = "";
        if(method_temp_vars.containsKey(id)) {
            cmd += "\nMOVE " + method_temp_vars.get(id) + " " + expr + "\n"; 
        } else if (get_offset_of_var_in_class(id) != null){
            cmd += "\nHSTORE TEMP 0 " + get_offset_of_var_in_class(id) + " " + expr + "\n";
        } else {
            System.out.println(id + " is not in class or method map");
            String new_id = get_new_temp();
            method_temp_vars.put(id, new_id);
            cmd += "\nMOVE " + new_id + " " + expr + "\n";
        }
        return cmd;
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
        String offset_var = n.f0.accept(this, argu);
        String offset = n.f2.accept(this, argu);
        String to_store = n.f5.accept(this, argu);
        String cmd = "";
        cmd += "\nHSTORE PLUS " + offset_var + " TIMES 4 " + offset + " 4 " + to_store + "\n"; 
        return cmd;
    }

    /**
    * f0 -> IfthenElseStatement()
    *       | IfthenStatement()
    */
    public String visit(IfStatement n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
    public String visit(IfthenStatement n, String argu) {
        String b_true = new_label();
        String b_false = new_label();
        String cmd = "";
        cmd += n.f2.accept(this, b_true + "," + b_false);
        cmd += b_true + "\t" + n.f4.accept(this, argu) + "\n";
        cmd += b_false + "\tNOOP\n";
        return cmd;
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
        String b_true = new_label();
        String b_false = new_label();
        String s_end = new_label();
        String expr = n.f2.accept(this, b_true + "," + b_false);
        String s1 = n.f4.accept(this, argu);
        String s2 = n.f6.accept(this, argu);
        String cmd = "";
        cmd += expr + " \n" + b_true + " " + s1 + " JUMP " + s_end + "\n" + b_false + " " + s2 + "\n" + s_end + " NOOP\n";
        return cmd;
    }
    
    /**
    * f0 -> "while"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    */
    public String visit(WhileStatement n, String argu) {
        String begin = new_label();
        String b_true = new_label();
        String b_false = new_label();
        String expr = n.f2.accept(this, b_true + "," + b_false);
        String s = n.f4.accept(this, argu);
        String cmd = "";
        cmd += begin + "\t" + expr + "\n" + b_true + "\t" + s + "\nJUMP " + begin + "\n" + b_false + "\tNOOP\n";
        return cmd;
    }
    /**
    * f0 -> "System.out.println"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> ";"
    */
    public String visit(PrintStatement n, String argu) {
        String expr = n.f2.accept(this, argu);
        String cmd = "\nPRINT " + expr + "\n";
        return cmd;
    }

    public String visit(Expression n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> "("
    * f1 -> Identifier()
    * f2 -> ")"
    * f3 -> "->"
    * f4 -> Expression()
    */
    public String visit(LambdaExpression n, String argu) {
        // String arg_type = argu.substring(9, argu.indexOf(','));
        // String ret_type = argu.substring(argu.indexOf(',') + 1, argu.length() - 1);   
        lambda_param = n.f1.f0.toString();
        String body = n.f4.accept(this, null);
        lambda += "\nlambda_func" + lambda_no + " [2]\n";
        lambda += "BEGIN \nRETURN " + body + "\nEND\n";
        lambda_no++;

        String vtable = get_new_temp();
        String field_table = get_new_temp();
        String class_body = "";
        class_body += "BEGIN\n";
        class_body += "MOVE " + vtable + " HALLOCATE 4" + "\n";
        class_body += "MOVE " + field_table + " HALLOCATE " + (4*lambda_class_fields.size()+4) + "\n";
        class_body += "HSTORE " + vtable + " 0 " + "lambda_func" + (lambda_no-1) + "\n"; 
        for(String field : lambda_class_fields.keySet()) {
            String y = null;
            if(method_temp_vars.containsKey(field)) {
                y = method_temp_vars.get(field);
            } else if (get_offset_of_var_in_class(field) != null) {
                Integer off = get_offset_of_var_in_class(field);
                String cmd = "";
                String new_temp = get_new_temp();
                cmd += "BEGIN\n";
                cmd += "HLOAD " + new_temp + " TEMP 0 " + off + "\n"; 
                cmd += "RETURN " + new_temp + "\n";
                cmd += "END\n";
                y = cmd;
            } else {
                String new_id = get_new_temp();
                method_temp_vars.put(n.f0.toString(), new_id);
                y = new_id;
            }
            class_body += "HSTORE PLUS " + field_table + " " + lambda_class_fields.get(field) + " 0 " + y + "\n";
        }
        class_body += " HSTORE " + field_table + " 0 " + vtable + "\n";
        class_body += "RETURN " + field_table + "\n";
        class_body += "END\n";
        return class_body;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "&&"
    * f2 -> PrimaryExpression()
    */
    public String visit(AndExpression n, String argu) {
        if(argu == null || argu.isEmpty()) {
            String pr1 = n.f0.accept(this, argu);
            String pr2 = n.f2.accept(this, argu);
            String result_temp = get_new_temp();
            String label_false = new_label();
            String label_end = new_label();
            
            String cmd = "BEGIN\n";
            cmd += "CJUMP " + pr1 + " " + label_false + "\n";  // If pr1 is false, jump to false
            cmd += "MOVE " + result_temp + " " + pr2 + "\n";   // Otherwise, result = pr2
            cmd += "JUMP " + label_end + "\n";
            cmd += label_false + " MOVE " + result_temp + " 0\n";  // Set result to false (0)
            cmd += label_end + " NOOP\nRETURN " + result_temp + "\n";
            cmd += "END";
            
            return cmd;
        } else {
            String b_true = argu.split(",")[0];
            String b_false = argu.split(",")[1];
            String b1_true = new_label();
            String pr1 = n.f0.accept(this, b1_true + "," + b_false);
            String pr2 = n.f2.accept(this, b_true + "," + b_false);

            String cmd = "";
            cmd += pr1 + " " + b1_true + " " + pr2 + "\n";
            return cmd;
        }
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "||"
    * f2 -> PrimaryExpression()
    */
    public String visit(OrExpression n, String argu) {
        if(argu == null || argu.isEmpty()) {
            String pr1 = n.f0.accept(this, argu);
            String pr2 = n.f2.accept(this, argu);
            String result_temp = get_new_temp();
            String label_true = new_label();
            String label_end = new_label();
            
            String cmd = "BEGIN\n";
            cmd += "CJUMP " + pr1 + " " + label_true + "\n";  // If pr1 is true, jump to true
            cmd += "MOVE " + result_temp + " " + pr2 + "\n";   // Otherwise, result = pr2
            cmd += "JUMP " + label_end + "\n";
            cmd += label_true + " MOVE " + result_temp + " 1\n";  // Set result to true (1)
            cmd += label_end + " NOOP\nRETURN " + result_temp + "\n";
            cmd += "END";
            
            return cmd;
        } else {
            String b_true = argu.split(",")[0];
            String b_false = argu.split(",")[1];
            String b1_false = new_label();
            String pr1 = n.f0.accept(this, b_true + "," + b1_false);
            String pr2 = n.f2.accept(this, b_true + "," + b_false);

            String cmd = "";
            cmd += pr1 + " " + b1_false + " " + pr2 + "\n";
            return cmd;
        }
    }
    /**
    * f0 -> PrimaryExpression()
    * f1 -> "<="
    * f2 -> PrimaryExpression()
    */
    public String visit(CompareExpression n, String argu) {
        if(argu == null || argu.isEmpty()) {
            String pr1 = n.f0.accept(this, argu);
            String pr2 = n.f2.accept(this, argu);
            String cmd = "LE " + pr1 + " " + pr2;
            return cmd;
        } else {
            String b_true = argu.split(",")[0];
            String b_false = argu.split(",")[1];
            String pr1 = n.f0.accept(this, null);
            String pr2 = n.f2.accept(this, null);
            String cmd = "CJUMP LE " + pr1 + " " + pr2 + " " + b_false + "\n";
            cmd += "CJUMP MINUS 1 LE " + pr1 + " " + pr2 + " " + b_true + "\n";
            return cmd;
        }
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "!="
    * f2 -> PrimaryExpression()
    */
    public String visit(neqExpression n, String argu) {
        if(argu == null || argu.isEmpty()) {
            String pr1 = n.f0.accept(this, argu);
            String pr2 = n.f2.accept(this, argu);
            String cmd = "NE " + pr1 + " " + pr2;
            return cmd;
        } else {
            String b_true = argu.split(",")[0];
            String b_false = argu.split(",")[1];
            String pr1 = n.f0.accept(this, null);
            String pr2 = n.f2.accept(this, null);
            String cmd = "CJUMP NE " + pr1 + " " + pr2 + " " + b_false + "\n";
            cmd += "CJUMP MINUS 1 NE " + pr1 + " " + pr2 + " " + b_true + "\n";
            return cmd;
        }
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "+"
    * f2 -> PrimaryExpression()
    */
    public String visit(AddExpression n, String argu) {
        String pr1 = n.f0.accept(this, argu);
        String pr2 = n.f2.accept(this, argu);
        String cmd  = "PLUS " + pr1 + " " + pr2;
        return cmd;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "-"
    * f2 -> PrimaryExpression()
    */
    public String visit(MinusExpression n, String argu) {
        String pr1 = n.f0.accept(this, argu);
        String pr2 = n.f2.accept(this, argu);
        String cmd  = "MINUS " + pr1 + " " + pr2;
        return cmd;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "*"
    * f2 -> PrimaryExpression()
    */
    public String visit(TimesExpression n, String argu) {
        String pr1 = n.f0.accept(this, argu);
        String pr2 = n.f2.accept(this, argu);
        String cmd  = "TIMES " + pr1 + " " + pr2;
        return cmd;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "/"
    * f2 -> PrimaryExpression()
    */
    public String visit(DivExpression n, String argu) {
        String pr1 = n.f0.accept(this, argu);
        String pr2 = n.f2.accept(this, argu);
        String cmd  = "DIV " + pr1 + " " + pr2;
        return cmd;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "["
    * f2 -> PrimaryExpression()
    * f3 -> "]"
    */
    public String visit(ArrayLookup n, String argu) {
        String pr1 = n.f0.accept(this, argu);
        String offset = n.f2.accept(this, argu);
        String cmd = "";
        String new_id = get_new_temp();
        String new_id2 = get_new_temp();
        cmd += "BEGIN\n";
        cmd += "MOVE " + new_id + " PLUS " + pr1 + " TIMES 4 " + offset + "\n" ;
        cmd += "HLOAD " + new_id2 + " " + new_id + " 4\n";
        cmd += "RETURN " + new_id2 + "\n";
        cmd += "END\n"; 
        return cmd;
    }

    /**
    * f0 -> PrimaryExpression()
    * f1 -> "."
    * f2 -> "length"
    */
    public String visit(ArrayLength n, String argu) {
        String var_id = n.f0.accept(this, argu);
        String result = get_new_temp();
        String cmd = "";
        cmd += "BEGIN\n";
        cmd += "HLOAD " + result + " " + var_id + " 0\n";
        cmd += "RETURN " + result + "\n";
        cmd += "END";
        return cmd;
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
        String cmd = "";
        cmd += "CALL BEGIN\n";
        String cls = get_new_temp();
    
        String primaryExpr = n.f0.accept(this, null);
        String primaryType = getPrimaryExpressionType(n.f0);
        String fun = n.f2.f0.toString();
        Integer func_off;
        if(primaryType.startsWith("function_")) 
            func_off = 0;
        else func_off = offsets.get(primaryType).vtable.get(fun).second;
        cmd += "MOVE " + cls + " " + primaryExpr + "\n";

        // System.out.println("calling " + fun + " in " + primaryType);
        String vtable = get_new_temp();
        String func_p = get_new_temp();
        cmd += "HLOAD " + vtable + " " + cls + " 0\n";
        cmd += "HLOAD " + func_p + " " + vtable + " " + func_off + "\n";
        cmd += "RETURN " + func_p + "\n";
        // cmd += "RETURN " + offsets.get(primaryType).vtable.get(fun).first+ "\n";
        cmd += "END ";
        String args = "";
        if(n.f4.present()) {
            ExpressionList expList = (ExpressionList) n.f4.node;
            args += expList.f0.accept(this, null) + " ";

            for(int i = 0; i < expList.f1.size(); ++i) {
                ExpressionRest expRest = (ExpressionRest) expList.f1.elementAt(i);
                args += expRest.f1.accept(this,null) + " ";
            }
        }
        cmd += "( " + cls + " " + args + ")";
        if(argu == null || argu == "") return cmd;
        else {
            return "CJUMP " + cmd + " " + argu.split(",")[1] + "\nCJUMP MINUS 1 " + cmd + " " + argu.split(",")[0] + "\n";
        }
    }
    
    private String getPrimaryExpressionType(PrimaryExpression primaryExpr) {
        if (primaryExpr.f0.choice instanceof ThisExpression) {
            return cur_class;
        }
        
        if (primaryExpr.f0.choice instanceof Identifier) {
            Identifier id = (Identifier) primaryExpr.f0.choice;
            return data.get_type(id.f0.toString(), cur_method, cur_class);
        }
        
        if (primaryExpr.f0.choice instanceof AllocationExpression) {
            AllocationExpression allocExpr = (AllocationExpression) primaryExpr.f0.choice;
            return allocExpr.f1.f0.toString();
        }
        
        if (primaryExpr.f0.choice instanceof BracketExpression) {
            BracketExpression bracketExpr = (BracketExpression) primaryExpr.f0.choice;
            return getExpressionType(bracketExpr.f1);
        }

        return null;
    }
    
    private String getExpressionType(Expression expr) {
        if (expr.f0.choice instanceof PrimaryExpression) {
            return getPrimaryExpressionType((PrimaryExpression) expr.f0.choice);
        }
        
        if (expr.f0.choice instanceof MessageSend) {
            MessageSend msg = (MessageSend) expr.f0.choice;
            String cls = getPrimaryExpressionType(msg.f0);
            String fun = msg.f2.f0.toString();
            return data.get_method(fun, cls).return_type;
        }
        
        if (expr.f0.choice instanceof AllocationExpression) {
            AllocationExpression allocExpr = (AllocationExpression) expr.f0.choice;
            return allocExpr.f1.f0.toString();
        }
        
        return null;
    }
    
    public String visit(PrimaryExpression n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> <INTEGER_LITERAL>
    */
    public String visit(IntegerLiteral n, String argu) {
        return n.f0.toString();
    }

    /**
    * f0 -> "true"
    */
    public String visit(TrueLiteral n, String argu) {
        if(argu == null || argu.isEmpty()) return "1"; 
        else {
            return "JUMP " + argu.split(",")[0] + "\n";
        }
    }

      /**
    * f0 -> "false"
    */
    public String visit(FalseLiteral n, String argu) {
        if(argu == null || argu.isEmpty()) return "0"; 
        else {
            return "JUMP " + argu.split(",")[1] + "\n";
        }
    }

    /**
    * f0 -> <IDENTIFIER>
    */
    public String visit(Identifier n, String argu) {  
        String id = n.f0.toString();
        String y = null;
        if(in_lambda_decl && lambda_param != null) {
            if(id.equals(lambda_param)) return "TEMP 1";
            if(!lambda_class_fields.containsKey(id)) {
                lambda_class_fields.put(id, lambda_off);
                lambda_off += 4;
            }
            String cmd = "";
            String new_temp = get_new_temp();
            cmd += "BEGIN\n";
            cmd += "HLOAD " + new_temp + " TEMP 0 " + lambda_class_fields.get(id) + "\n"; 
            cmd += "RETURN " + new_temp + "\n";
            cmd += "END\n";  
            return cmd;
        }
        if(method_temp_vars.containsKey(id)) {
            y = method_temp_vars.get(id);
        } else if (get_offset_of_var_in_class(id) != null) {
            Integer off = get_offset_of_var_in_class(id);
            String cmd = "";
            String new_temp = get_new_temp();
            cmd += "BEGIN\n";
            cmd += "HLOAD " + new_temp + " TEMP 0 " + off + "\n"; 
            cmd += "RETURN " + new_temp + "\n";
            cmd += "END\n";
            y = cmd;
        }
        else {
            String new_id = get_new_temp();
            method_temp_vars.put(n.f0.toString(), new_id);
            y = new_id;
        }
        if(argu == null || argu.isEmpty()) return y;
        else {
            return "CJUMP " + y + " " + argu.split(",")[1] + "\nCJUMP MINUS 1 " + y + " " + argu.split(",")[0] + "\n";
        }
    }

    /**
    * f0 -> "this"
    */
    public String visit(ThisExpression n, String argu) {
        return "TEMP 0";
    }

    /**
    * f0 -> "new"
    * f1 -> "int"
    * f2 -> "["
    * f3 -> Expression()
    * f4 -> "]"
    */
    public String visit(ArrayAllocationExpression n, String argu) {
        String expr = n.f3.accept(this, argu);
        String begin = new_label();
        String end = new_label();
        String arr = get_new_temp();
        String temp = get_new_temp();
        String cmd = "BEGIN\n";
        cmd += "MOVE " + arr + " HALLOCATE  TIMES  PLUS " + expr + " 1  4\n"; 
        cmd += "MOVE " + temp + " 4\n"; 
        cmd += begin + " CJUMP  LE " + temp + " MINUS  TIMES  PLUS " + expr + " 1  4  1 " + end + "\n";
        cmd += "HSTORE  PLUS " + arr + " " + temp + " 0  0\n"; 
        cmd += "MOVE " + temp + " PLUS " + temp + " 4\n"; 
        cmd += "JUMP " + begin + "\n"; 
        cmd += end + " HSTORE " + arr + " 0 " + expr + "\n"; 
        cmd += "RETURN " + arr + "\n";
        cmd += "END\n";
        return cmd;
    }

    /**
    * f0 -> "new"
    * f1 -> Identifier()
    * f2 -> "("
    * f3 -> ")"
    */
    public String visit(AllocationExpression n, String argu) {
        String id = n.f1.f0.toString();
        String vtable = get_new_temp();
        String field_table = get_new_temp();
        Table cur_table = offsets.get(id);
        String cmd = "";
        cmd += "BEGIN\n";
        cmd += "MOVE " + vtable + " HALLOCATE " +  cur_table.method_offset + "\n";
        cmd += "MOVE " + field_table + " HALLOCATE " + cur_table.cur_off + "\n";
        for(String key : cur_table.vtable.keySet()) {
            cmd += "HSTORE " + vtable + " " + cur_table.vtable.get(key).second + " " + cur_table.vtable.get(key).first + "\n"; 
        }
        String temp = get_new_temp();
        cmd += "MOVE " + temp + " 4\n"; 
        String begin = new_label();
        String end = new_label();
        cmd += begin;
        cmd += "\tCJUMP LE " + temp + " " + (cur_table.cur_off-1) + " " + end + "\n";
        cmd += "HSTORE PLUS " + field_table + " " + temp + " 0 0\n";
        cmd += "MOVE " + temp + " PLUS " + temp + " 4\n";
        cmd += "JUMP " + begin + "\n";
        cmd += end + " HSTORE " + field_table + " 0 " + vtable + "\n";
        cmd += "RETURN " + field_table + "\n";
        cmd += "END\n";
        return cmd;
    }

    /**
    * f0 -> "!"
    * f1 -> Expression()
    */
    public String visit(NotExpression n, String argu) {
        if(argu == null || argu.isEmpty()) {
            return n.f1.accept(this, argu);
        } else {
            String b_true = argu.split(",")[0];
            String b_false = argu.split(",")[1];
            return n.f1.accept(this, b_false + "," + b_true);
        }
    }

    /**
    * f0 -> "("
    * f1 -> Expression()
    * f2 -> ")"
    */
    public String visit(BracketExpression n, String argu) {
        return n.f1.accept(this, argu);
    }

}