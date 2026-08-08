package visitor;

import java.util.*;

import syntaxtree.*;

public class visitor1 extends GJDepthFirst<String, String> {
	String final_initializations = "";
	Integer tempInteger = 0;
	String TacoCode = "";
	String Body = "";
	String new_temp_declarations = "";
	Vector<String> loop_end_expressions = new Vector<String>();
	String cur_class = null;
	HashMap<String, types.Types> ClassMethod_table;
	HashMap<String, String> VarType_table;

	public visitor1(HashMap<String, types.Types> ClassMethod_table) {
		this.ClassMethod_table = ClassMethod_table;
		this.VarType_table = new HashMap<String, String>();
	// 	ClassMethod_table.forEach((key, value) -> {
	// 		System.out.println("Class: " + key);
	// 		value.types.forEach((method, type) -> {
	// 			System.out.println("  Method: " + method + ", Return Type: " + type);
	// 		});
	// 	});
	}

	String newTemp(String type) {
		String tempName = "temp" + (tempInteger++);
		new_temp_declarations += type + " " + tempName + ";\n";
		return tempName;
	}

	/**
	 * f0 -> MainClass()
	 * f1 -> ( TypeDeclaration() )*
	 * f2 -> <EOF>
	 */
	public String visit(Goal n, String argu) {
		String _ret = null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		System.out.println(TacoCode);
		return _ret;
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
		String _ret = null;
		TacoCode += "class " + n.f1.f0.tokenImage + " {\n";
		TacoCode += "public static void main(String[] args) {\n";
		n.f14.accept(this, argu);
		TacoCode += new_temp_declarations;
		new_temp_declarations = "";
		TacoCode += Body;
		TacoCode += "}\n}\n";
		Body = "";
		// System.out.println(TacoCode);
		return _ret;
	}

	/**
	 * f0 -> ClassDeclaration()
	 * | ClassExtendsDeclaration()
	 */
	public String visit(TypeDeclaration n, String argu) {
		String _ret = null;
		n.f0.accept(this, argu);
		return _ret;
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
		cur_class = n.f1.f0.tokenImage;
		TacoCode += "class " + n.f1.f0.tokenImage + " {\n";
		n.f3.accept(this, argu);
		n.f4.accept(this, argu);
		TacoCode += "}\n";
		cur_class = null;
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
		cur_class = n.f1.f0.tokenImage;
		TacoCode += "class " + n.f1.f0.tokenImage + " extends " + n.f3.f0.tokenImage + " {\n";
		n.f5.accept(this, argu);
		n.f6.accept(this, argu);
		TacoCode += "}\n";
		cur_class = null;
		return _ret;
	}

	/**
	 * f0 -> SimpleVarDeclaration()
	 * | FinalVarDeclaration()
	 */
	public String visit(VarDeclaration n, String argu) {
		String _ret = null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 * f2 -> ";"
	 */
	public String visit(SimpleVarDeclaration n, String argu) {
		String _ret = null;
		TacoCode += n.f0.accept(this, argu) + " " + n.f1.f0.tokenImage + ";\n";
		VarType_table.put(n.f1.f0.tokenImage, n.f0.accept(this, argu));
		return _ret;
	}

	/**
	 * f0 -> "final"
	 * f1 -> Type()
	 * f2 -> Identifier()
	 * f3 -> "="
	 * f4 -> Expression()
	 * f5 -> ";"
	 */
	public String visit(FinalVarDeclaration n, String argu) {
		String _ret = null;
		TacoCode += n.f1.accept(this, argu) + " " + n.f2.f0.tokenImage + ";\n";
		VarType_table.put(n.f2.f0.tokenImage, n.f1.accept(this, argu));
		final_initializations += n.f2.f0.tokenImage + " = " + n.f4.accept(this, argu) + ";\n";
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
		final_initializations = "";
		new_temp_declarations = "";
		Body = "";
		TacoCode += "public " + n.f1.accept(this, argu) + " " + n.f2.f0.tokenImage + "(";
		VarType_table.clear();
		n.f4.accept(this, argu);
		TacoCode += ") {\n";
		n.f7.accept(this, argu);
		Body += final_initializations;
		n.f8.accept(this, argu);
		String ret_val = n.f10.accept(this, argu);
		TacoCode += new_temp_declarations;
		TacoCode += Body;
		TacoCode += "return " + ret_val + ";\n";
		TacoCode += "}\n";
		return _ret;
	}

	/**
	 * f0 -> FormalParameter()
	 * f1 -> ( FormalParameterRest() )*
	 */
	public String visit(FormalParameterList n, String argu) {
		String _ret = null;
		n.f0.accept(this, argu);
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Type()
	 * f1 -> Identifier()
	 */
	public String visit(FormalParameter n, String argu) {
		String _ret = null;
		String type = n.f0.accept(this, argu);
		TacoCode += type + " " + n.f1.f0.tokenImage;
		VarType_table.put(n.f1.f0.tokenImage, type);
		return _ret;
	}

	/**
	 * f0 -> ","
	 * f1 -> FormalParameter()
	 */
	public String visit(FormalParameterRest n, String argu) {
		String _ret = null;
		TacoCode += ", ";
		n.f1.accept(this, argu);
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
	 * f0 -> Block()
	 * | AssignmentStatement()
	 * | ArrayAssignmentStatement()
	 * | FieldAssignmentStatement()
	 * | IfStatement()
	 * | WhileStatement()
	 * | ForStatement()
	 * | PrintStatement()
	 */
	public String visit(Statement n, String argu) {
		String _ret = null;
		n.f0.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> "{"
	 * f1 -> ( Statement() )*
	 * f2 -> "}"
	 */
	public String visit(Block n, String argu) {
		String _ret = null;
		n.f1.accept(this, argu);
		return _ret;
	}

	/**
	 * f0 -> Identifier()
	 * f1 -> "="
	 * f2 -> Expression()
	 * f3 -> ";"
	 */
	public String visit(AssignmentStatement n, String argu) {
		String _ret = null;
		String oper = n.f2.accept(this, argu);
		Body += n.f0.f0.tokenImage + " = " + oper + ";\n";
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
		String _ret = null;
		String expr1 = n.f2.accept(this, argu);
		String expr2 = n.f5.accept(this, argu);
		Body += n.f0.f0.tokenImage + "[" + expr1 + "] = " + expr2 + ";\n";
		return _ret;
	}

	/**
	 * f0 -> Expression()
	 * f1 -> "."
	 * f2 -> Identifier()
	 * f3 -> "="
	 * f4 -> Expression()
	 * f5 -> ";"
	 */
	public String visit(FieldAssignmentStatement n, String argu) {
		String _ret = null;
		String expr1 = n.f0.accept(this, argu);
		String expr2 = n.f4.accept(this, argu);
		Body += expr1 + "." + n.f2.f0.tokenImage + " = " + expr2 + ";\n";
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
	public String visit(IfStatement n, String argu) {
		String _ret = null;
		String predicate = n.f2.accept(this, argu);
		Body += "if (" + predicate + ") {\n";
		n.f4.accept(this, argu);
		Body += "}\n";
		Body += "else {\n";
		n.f6.accept(this, argu);
		Body += "}\n";
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
		loop_end_expressions.add("");
		String _ret = null;
		String expr = n.f2.accept(this, "raw");
		Body += "while (" + expr + ") {\n";
		n.f4.accept(this, argu);
		Body += loop_end_expressions.lastElement();
		loop_end_expressions.removeLast();
		Body += "}\n";
		return _ret;
	}

	/**
	 * f0 -> "for"
	 * f1 -> "("
	 * f2 -> Identifier()
	 * f3 -> "="
	 * f4 -> Expression()
	 * f5 -> ";"
	 * f6 -> Expression()
	 * f7 -> ";"
	 * f8 -> Identifier()
	 * f9 -> "="
	 * f10 -> Expression()
	 * f11 -> ")"
	 * f12 -> Statement()
	 */
	public String visit(ForStatement n, String argu) {
		loop_end_expressions.add("");
		String _ret = null;
		String expr1 = n.f4.accept(this, null);
		// String expr2 = n.f6.accept(this, "raw");
		// Body += "for (" + n.f2.f0.tokenImage + " = " + expr1 + "; "
		// 		+ n.f6.accept(this, "raw") + "; "
		// 		+ n.f8.f0.tokenImage + " = " + n.f10.accept(this, "raw") + ") {\n";
		// n.f12.accept(this, argu);
		// Body += loop_end_expressions;
		// loop_end_expressions = "";
		// Body += "}\n";
		Body += n.f2.f0.tokenImage + " = " + expr1 + ";\n";
		String expr2 = n.f6.accept(this, "raw");
		Body += "while (" + expr2 + ") {\n";
		n.f12.accept(this, argu);
		String expr3 = n.f10.accept(this, null);
		Body += n.f8.f0.tokenImage + " = " + expr3 + ";\n";
		Body += loop_end_expressions.lastElement();
		loop_end_expressions.removeLast();
		Body += "}\n";
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
		String _ret = null;
		String oper = n.f2.accept(this, argu);
		Body += "System.out.println(" + oper + ");\n";
		return _ret;
	}

	/**
	 * f0 -> AndExpression()
	 * | CompareExpression()
	 * | PlusExpression()
	 * | MinusExpression()
	 * | TimesExpression()
	 * | ArrayLookup()
	 * | ArrayLength()
	 * | MessageSend()
	 * | PrimaryExpression()
	 */
	public String visit(Expression n, String argu) {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "&"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(AndExpression n, String argu) {
		String _ret = newTemp("boolean");
		String oper1 = n.f0.accept(this, argu);
		String oper2 = n.f2.accept(this, argu);
		String expr =  "if (" + oper1 + ") { " + _ret + " = " + oper2 + "; }\n else { " + _ret + " = false; }\n";
		Body += expr;
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + expr);
		}
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "|"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(ORExpression n, String argu) {
		String _ret = newTemp("boolean");
		String oper1 = n.f0.accept(this, argu);
		String oper2 = n.f2.accept(this, argu);
		String expr = "if (" + oper1 + ") { " + _ret + " = true; }\n else { " + _ret + " = " + oper2 + "; }\n";
		Body += expr;
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + expr);
		}
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "<"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(CompareExpression n, String argu) {
		String _ret = newTemp("boolean");
		String oper1 = n.f0.accept(this, argu);
		String oper2 = n.f2.accept(this, argu);
		Body += _ret + " = " + oper1 + " < " + oper2 + ";\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + oper1 + " < " + oper2 + ";\n");
		}
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "+"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(PlusExpression n, String argu) {
		String _ret = newTemp("int");
		String oper1 = n.f0.accept(this, argu);
		String oper2 = n.f2.accept(this, argu);
		Body += _ret + " = " + oper1 + " + " + oper2 + ";\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + oper1 + " + " + oper2 + ";\n");
		}
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "-"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(MinusExpression n, String argu) {
		String _ret = newTemp("int");
		String oper1 = n.f0.accept(this, argu);
		String oper2 = n.f2.accept(this, argu);
		Body += _ret + " = " + oper1 + " - " + oper2 + ";\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + oper1 + " - " + oper2 + ";\n");
		}
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "*"
	 * f2 -> PrimaryExpression()
	 */
	public String visit(TimesExpression n, String argu) {
		String _ret = newTemp("int");
		String oper1 = n.f0.accept(this, argu);
		String oper2 = n.f2.accept(this, argu);
		Body += _ret + " = " + oper1 + " * " + oper2 + ";\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + oper1 + " * " + oper2 + ";\n");
		}
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "["
	 * f2 -> PrimaryExpression()
	 * f3 -> "]"
	 */
	public String visit(ArrayLookup n, String argu) {
		String _ret = newTemp("int");
		String array = n.f0.accept(this, argu);
		String index = n.f2.accept(this, argu);
		Body += _ret + " = " + array + "[" + index + "];\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + array + "[" + index + "];\n");
		}
		return _ret;
	}

	/**
	 * f0 -> PrimaryExpression()
	 * f1 -> "."
	 * f2 -> "length"
	 */
	public String visit(ArrayLength n, String argu) {
		String _ret = newTemp("int");
		String array = n.f0.accept(this, argu);
		Body += _ret + " = " + array + ".length;\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + array + ".length;\n");
		}

		return _ret;
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
		String obj = n.f0.accept(this, argu);
		String obj_type = n.f0.accept(this, "type");
		String method = n.f2.f0.tokenImage;
		// System.out.println("Visiting MessageSend: obj = " + obj + ", object type = " + obj_type + ", method = " + method);
		String ret_type = ClassMethod_table.get(obj_type).get_type(method); 
		String _ret = newTemp(ret_type);
		if(argu != null && argu.equals("type")) {
			return ret_type;
		}

		String args = "";
		if (n.f4.present()) {
			args = n.f4.accept(this, argu);
		}
		Body += _ret + " = " + obj + "." + method + "(" + args + ");\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + obj + "." + method + "(" + args + ");\n");
		}
		return _ret;
	}

	/**
	 * f0 -> Expression()
	 * f1 -> ( ExpressionRest() )*
	 */
	public String visit(ExpressionList n, String argu) {
		String _ret = "";
		_ret = n.f0.accept(this, argu);
		for(Node node : n.f1.nodes) {
			_ret += ", " + node.accept(this, argu);
		}
		return _ret;
	}

	/**
	 * f0 -> ","
	 * f1 -> Expression()
	 */
	public String visit(ExpressionRest n, String argu) {
		return n.f1.accept(this, argu);
	}

	/**
	 * f0 -> IntegerLiteral()
	 * | TrueLiteral()
	 * | FalseLiteral()
	 * | Identifier()
	 * | ThisExpression()
	 * | ArrayAllocationExpression()
	 * | AllocationExpression()
	 * | NotExpression()
	 * | BracketExpression()
	 */
	public String visit(PrimaryExpression n, String argu) {
		return n.f0.accept(this, argu);
	}

	/**
	 * f0 -> <INTEGER_LITERAL>
	 */
	public String visit(IntegerLiteral n, String argu) {
		String _ret = newTemp("int");
		Body += _ret + " = " + n.f0.tokenImage + ";\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = " + n.f0.tokenImage + ";\n");
		}
		return _ret;
	}

	/**
	 * f0 -> "true"
	 */
	public String visit(TrueLiteral n, String argu) {
		String _ret = newTemp("boolean");
		Body += _ret + " = true;\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = true;\n");
		}
		return _ret;
	}

	/**
	 * f0 -> "false"
	 */
	public String visit(FalseLiteral n, String argu) {
		String _ret = newTemp("boolean");
		Body += _ret + " = false;\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = false;\n");
		}
		return _ret;
	}

	/**
	 * f0 -> <IDENTIFIER>
	 */
	public String visit(Identifier n, String argu) {
		if(argu == null || argu != null && argu.equals("raw")) {
			return n.f0.tokenImage;
		}
		else if(argu.equals("type")) {
			String ret = VarType_table.get(n.f0.tokenImage);
			if(ret == null || ret.equals("void")) ret = ClassMethod_table.get(cur_class).get_type(n.f0.tokenImage);
			assert(ret != null) : "Identifier " + n.f0.tokenImage + " not found in variable type table or class method table";
			return ret;
		} 
		assert(false) : "Invalid argument passed to Identifier node";
		return n.f0.tokenImage;
	}

	/**
	 * f0 -> "this"
	 */
	public String visit(ThisExpression n, String argu) {
		if(argu == null || argu != null && argu.equals("raw")) {
			return "this";
		} else if(argu.equals("type")) {
			return cur_class;
		}
		assert(false) : "Invalid argument passed to ThisExpression node";
		return "this";
	}

	/**
	 * f0 -> "new"
	 * f1 -> Identifier()
	 * f2 -> "("
	 * f3 -> ")"
	 */
	public String visit(AllocationExpression n, String argu) {
		String className = n.f1.f0.tokenImage;
		if(argu != null && argu.equals("type")) {
			return className;
		}
		String _ret = newTemp(className);
		Body += _ret + " = new " + className + "();\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = new " + className + "();\n");
		}
		return _ret;
	}

	/**
	 * f0 -> "new"
	 * f1 -> "int"
	 * f2 -> "["
	 * f3 -> Expression()
	 * f4 -> "]"
	 */
	public String visit(ArrayAllocationExpression n, String argu) {
		String _ret = newTemp("int[]");
		String size = n.f3.accept(this, argu);
		Body += _ret + " = new int[" + size + "];\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = new int[" + size + "];\n");
		}
		return _ret;
	}

	/**
	 * f0 -> "!"
	 * f1 -> ( MessageSend() | PrimaryExpression() )
	 */
	public String visit(NotExpression n, String argu) {
		String _ret = newTemp("boolean");
		String operand = n.f1.accept(this, argu);
		Body += _ret + " = !" + operand + ";\n";
		if(argu != null && argu.equals("raw")) {
			String curr = loop_end_expressions.getLast();
			loop_end_expressions.set(loop_end_expressions.size() - 1, curr + _ret + " = !" + operand + ";\n");
		}
		return _ret;
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