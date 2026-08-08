package visitor;
import syntaxtree.*;
import java.util.*;

public class miniTomacro extends GJDepthFirst<String, String> {
    
    String microCode = "";
    Integer var_no = 1;
    String get_new_temp() {
        return "TEMP " + (var_no++);
    }

    public miniTomacro(Integer maxTemp) {
        var_no = maxTemp + 1;
    }

    /**
    * f0 -> "MAIN"
    * f1 -> StmtList()
    * f2 -> "END"
    * f3 -> ( Procedure() )*
    * f4 -> <EOF>
    */
    public String visit(Goal n, String argu) {
        microCode += "MAIN\n";
        n.f1.accept(this, null);
        microCode += "END\n";
        // if(n.f3.present()) {
        //     for(int i = 0; i < n.f3.size(); ++i) {
        //         Procedure p = (Procedure) n.f3.elementAt(i);
        //         p.accept(this, null);
        //     }
        // }
        n.f3.accept(this, null);
        return microCode;
    }

    /**
    * f0 -> ( ( Label() )? Stmt() )*
    */
    public String visit(StmtList n, String argu) {
        n.f0.accept(this, "label");
        return null;
    }
    
    /**
    * f0 -> Label()
    * f1 -> "["
    * f2 -> IntegerLiteral()
    * f3 -> "]"
    * f4 -> StmtExp()
    */
    public String visit(Procedure n, String argu) {
        String _ret=null;
        String label = n.f0.accept(this, argu);
        microCode += label + " [ ";
        microCode += n.f2.accept(this, argu);
        microCode += " ]\nBEGIN\n";
        String ret = n.f4.accept(this, argu);
        microCode += "\nRETURN " + ret + "\nEND\n";
        return _ret;
    }

    /**
    * f0 -> NoOpStmt()
    *       | ErrorStmt()
    *       | CJumpStmt()
    *       | JumpStmt()
    *       | HStoreStmt()
    *       | HLoadStmt()
    *       | MoveStmt()
    *       | PrintStmt()
    */
    public String visit(Stmt n, String argu) {
        String _ret=null;
        n.f0.accept(this, null);
        return _ret;
    }


    /**
    * f0 -> "NOOP"
    */
    public String visit(NoOpStmt n, String argu) {
        String _ret=null;
        microCode += " NOOP\n";
        return _ret;
    }

    /**
    * f0 -> "ERROR"
    */
    public String visit(ErrorStmt n, String argu) {
        String _ret=null;
        microCode += " ERROR\n";
        return _ret;
    }

    /**
    * f0 -> "CJUMP"
    * f1 -> Exp()
    * f2 -> Label()
    */
    public String visit(CJumpStmt n, String argu) {
        String _ret=null;
        String exp = n.f1.accept(this, argu);
        microCode += "CJUMP " + exp + " " + n.f2.accept(this, argu) + "\n";
        return _ret;
    }

    /**
    * f0 -> "JUMP"
    * f1 -> Label()
    */
    public String visit(JumpStmt n, String argu) {
        String _ret=null;
        microCode += "JUMP " + n.f1.accept(this, argu) + "\n";
        return _ret;
    }

    /**
    * f0 -> "HSTORE"
    * f1 -> Exp()
    * f2 -> IntegerLiteral()
    * f3 -> Exp()
    */
    public String visit(HStoreStmt n, String argu) {
        String _ret=null;
        String exp1 = n.f1.accept(this, argu);
        String exp2 = n.f3.accept(this, argu);
        String temp = get_new_temp();
        microCode += "MOVE " + temp + " " + exp2 + "\n";
        microCode += "HSTORE " + exp1 + " " + n.f2.accept(this, argu) + " " + temp + "\n";
        return _ret;
    }

    /**
    * f0 -> "HLOAD"
    * f1 -> Temp()
    * f2 -> Exp()
    * f3 -> IntegerLiteral()
    */
    public String visit(HLoadStmt n, String argu) {
        String _ret=null;
        String exp = n.f2.accept(this, argu);
        microCode += "HLOAD " + n.f1.accept(this, argu) + " " + exp + " " + n.f3.accept(this, argu) + "\n";
        return _ret;
    }

    /**
    * f0 -> "MOVE"
    * f1 -> Temp()
    * f2 -> Exp()
    */
    public String visit(MoveStmt n, String argu) {
        String _ret=null;
        String exp = n.f2.accept(this, argu);
        microCode += "MOVE " + n.f1.accept(this, argu) + " " + exp + "\n";
        return _ret;
    }

    /**
    * f0 -> "PRINT"
    * f1 -> Exp()
    */
    public String visit(PrintStmt n, String argu) {
        String _ret=null;
        String exp = n.f1.accept(this, argu);
        microCode += "PRINT " + exp + "\n";
        return "PRINT STMT";
    }

    /**
    * f0 -> StmtExp()
    *       | Call()
    *       | HAllocate()
    *       | BinOp()
    *       | Temp()
    *       | IntegerLiteral()
    *       | Label()
    */
    public String visit(Exp n, String argu) {
        return n.f0.accept(this, "exp");
    }

    /**
    * f0 -> "BEGIN"
    * f1 -> StmtList()
    * f2 -> "RETURN"
    * f3 -> Exp()
    * f4 -> "END"
    */
    public String visit(StmtExp n, String argu) {
        n.f1.accept(this, argu);
        String exp = n.f3.accept(this, argu);
        return exp;
    }

    /**
    * f0 -> "CALL"
    * f1 -> Exp()
    * f2 -> "("
    * f3 -> ( Exp() )*
    * f4 -> ")"
    */
    public String visit(Call n, String argu) {
        String exp1 = n.f1.accept(this, argu);
        Vector<String> args = new Vector<>();
        for(int i = 0; i < n.f3.size(); ++i) {
            args.add(n.f3.elementAt(i).accept(this, argu));
        }
        String temp = get_new_temp();
        microCode += "MOVE " + temp + " ";
        microCode += "CALL " + exp1 + " ( ";
        for(String a : args) {
            microCode += a + " ";
        }
        microCode += ")\n";
        return temp;
    }

    /**
    * f0 -> "HALLOCATE"
    * f1 -> Exp()
    */
    public String visit(HAllocate n, String argu) {
        String exp = n.f1.accept(this, argu);
        String temp = get_new_temp();
        microCode += "MOVE " + temp + " HALLOCATE " + exp + "\n";
        return temp;
    }

    /**
    * f0 -> Operator()
    * f1 -> Exp()
    * f2 -> Exp()
    */
    public String visit(BinOp n, String argu) {
        String op = n.f0.accept(this, argu);
        String exp1 = n.f1.accept(this, argu);
        String exp2 = n.f2.accept(this, argu);
        String temp = get_new_temp();
        microCode += "MOVE " + temp + " " + op + " " + exp1 + " " + exp2 + "\n";
        return temp;
    } 
    
    /**
    * f0 -> "LE"
    *       | "NE"
    *       | "PLUS"
    *       | "MINUS"
    *       | "TIMES"
    *       | "DIV"
    */
    public String visit(Operator n, String argu) {
        return n.f0.choice.toString();
    }

    /**
    * f0 -> "TEMP"
    * f1 -> IntegerLiteral()
    */
    public String visit(Temp n, String argu) {
        String temp = "TEMP ";
        temp += n.f1.accept(this, null);
        return temp;
    }

    /**
    * f0 -> <INTEGER_LITERAL>
    */
    public String visit(IntegerLiteral n, String argu) {
        if(argu != null && argu.equals("exp")) {
            String temp = get_new_temp();
            microCode += "MOVE " + temp + " " +  n.f0.toString() + "\n";
            return temp;
        }
        return n.f0.toString();
    }

    /**
    * f0 -> <IDENTIFIER>
    */
    public String visit(Label n, String argu) {
        if(argu != null && argu.equals("label")) microCode += n.f0.toString() + " ";
        return n.f0.toString();
    }
}
