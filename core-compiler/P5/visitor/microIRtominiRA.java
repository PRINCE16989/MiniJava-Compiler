package visitor;
import helpers.*;
import syntaxtree.*;
import java.util.*;
public class microIRtominiRA extends GJDepthFirst<String, String> {
    Map<String, proc> procs = new HashMap<>();
    proc current_proc;
    Integer Instruction_no = 0;
    public String RACode = "";
    Boolean used_v0 = false;

    public microIRtominiRA(Map<String, proc> procs) {
        this.procs = procs;
    }

    String get_v() {
        if(used_v0) return "v1";
        used_v0 = true;
        return "v0";
    }

    /**
    * f0 -> "MAIN"
    * f1 -> StmtList()
    * f2 -> "END"
    * f3 -> ( Procedure() )*
    * f4 -> <EOF>
    */
    public String visit(Goal n, String argu) {
        String _ret = null;
        current_proc = procs.get("MAIN");
        RACode += "MAIN [0][" + current_proc.next_spill_index + "][" + current_proc.max_args + "]\n";
        n.f1.accept(this, argu);
        RACode += "END\n";
        if(current_proc.spilled_index.isEmpty()) RACode += "// NOTSPILLED\n\n";
        else RACode += "// SPILLED\n\n";
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        System.out.println(RACode);
        return _ret;
    }

    /**
    * f0 -> ( ( Label() )? Stmt() )*
    */
    public String visit(StmtList n, String argu) {
        String _ret = null;
        n.f0.accept(this, "label");
        return _ret;
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
        String proc_name = n.f0.f0.toString();
        current_proc = procs.get(proc_name);
        RACode += proc_name + " [" + n.f2.f0.toString() + "][" + current_proc.next_spill_index + "][" + current_proc.max_args + "]\n";
        int spill_index;
        if(current_proc.arguments > 4) spill_index = current_proc.arguments - 4;
        else spill_index = 0;
        for(int i = 10; i < 18; ++i) {
            RACode += "ASTORE SPILLEDARG " + (spill_index++) + " " + current_proc.temp_to_reg.get(i) + "\n"; 
        }
        for(int i = 0; i < Math.min(4, current_proc.arguments); ++i) {
            String temp = current_proc.get_temp(i, Instruction_no);
            if(temp == null) continue;

            if(temp.startsWith("SPILLEDARG")) {
                RACode += "ASTORE " + temp + " a" + i + "\n"; 
            } else RACode += "MOVE " + temp + " a" + i + "\n";
        }
        for(int i = 4; i < current_proc.arguments; ++i) {
            String temp = current_proc.get_temp(i, Instruction_no);
            String v = get_v();
            RACode += "ALOAD " + v + " SPILLEDARG " + (i-4) + "\n";
            if(temp.startsWith("SPILLEDARG")) {
                RACode += "ASTORE " + temp + " " + v + "\n";
            } else RACode += "MOVE " + temp + " " + v + "\n";
            
            used_v0 = false;
        }
        n.f4.accept(this, argu);
        for(int i = 17; i >= 10; --i) {
            RACode += "ALOAD " + current_proc.temp_to_reg.get(i) + " SPILLEDARG " + (--spill_index) + "\n";
        }
        RACode += "END\n";
        if(current_proc.spilled_index.isEmpty()) RACode += "// NOTSPILLED\n\n";
        else RACode += "// SPILLED\n\n";
        return _ret;
    }
    
    /**
    * f0 -> "BEGIN"
    * f1 -> StmtList()
    * f2 -> "RETURN"
    * f3 -> SimpleExp()
    * f4 -> "END"
    */
    public String visit(StmtExp n, String argu) {
        String _ret=null;
        n.f1.accept(this, argu);
        String exp_code = n.f3.accept(this, argu);
        RACode += "MOVE v0 " + exp_code + "\n";
        used_v0 = false;
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
        String x = n.f0.accept(this, null);
        RACode += x;
        Instruction_no++;
        return null;
    }

    /**
    * f0 -> "NOOP"
    */
    public String visit(NoOpStmt n, String argu) {
        return "NOOP\n";
    }

    /**
    * f0 -> "ERROR"
    */
    public String visit(ErrorStmt n, String argu) {
        return "ERROR\n";
    }

    /**
    * f0 -> "CJUMP"
    * f1 -> Temp()
    * f2 -> Label()
    */
    public String visit(CJumpStmt n, String argu) {
        String _ret = "", code = "";
        String temp = n.f1.accept(this, argu);
        
        _ret += code + "CJUMP " + temp + " " + n.f2.f0.toString() + "\n";
        used_v0 = false;
        return _ret;
    }

    /**
    * f0 -> "JUMP"
    * f1 -> Label()
    */
    public String visit(JumpStmt n, String argu) {
        String _ret = "";
        _ret += "JUMP " + n.f1.f0.toString() + "\n";
        return _ret;
    }

    /**
    * f0 -> "HSTORE"
    * f1 -> Temp()
    * f2 -> IntegerLiteral()
    * f3 -> Temp()
    */
    public String visit(HStoreStmt n, String argu) {
        String _ret = "";
        String temp1 = n.f1.accept(this, argu);
        String temp2 = n.f3.accept(this, argu);
        _ret += "HSTORE " + temp1 + " " + n.f2.f0.toString() + " " + temp2 + "\n";
        used_v0 = false;
        return _ret;
    }
    
    /**
    * f0 -> "HLOAD"
    * f1 -> Temp()
    * f2 -> Temp()
    * f3 -> IntegerLiteral()
    */
    public String visit(HLoadStmt n, String argu) {
        String _ret = "";
        String temp2 = n.f2.accept(this, argu);
        String temp1 = current_proc.get_temp(Integer.parseInt(n.f1.f1.f0.toString()), Instruction_no);
        if(temp1 == null) return "";
        String v = get_v();
        _ret += "HLOAD " + v + " " + temp2 + " " + n.f3.f0.toString() + "\n";
        if(temp1.startsWith("SPILLEDARG")) {
            _ret += "ASTORE " + temp1 + " " + v + "\n";
        } else {
            _ret += "MOVE " + temp1 + " " + v + "\n";
        } 
        used_v0 = false;
        return _ret;
    }

    /**
    * f0 -> "MOVE"
    * f1 -> Temp()
    * f2 -> Exp()
    */
    public String visit(MoveStmt n, String argu) {
        String _ret = "";
        String exp_code = n.f2.accept(this, argu);
        String temp = current_proc.get_temp(Integer.parseInt(n.f1.f1.f0.toString()), Instruction_no);
        if(temp == null) return _ret;
        RACode += "MOVE v0 " + exp_code + "\n";
        if(temp.startsWith("SPILLEDARG")) {
            _ret += "ASTORE " + temp + " v0" + "\n";
        } else {
            _ret += "MOVE " + temp + " v0" + "\n";
        }
        used_v0 = false;
        return _ret;
    }

    /**
    * f0 -> "PRINT"
    * f1 -> SimpleExp()
    */
    public String visit(PrintStmt n, String argu) {
        String _ret = "";
        String exp_code = n.f1.accept(this, argu);
        _ret += "PRINT " + exp_code + "\n";
        used_v0 = false;
        return _ret;
    }

    /**
    * f0 -> Call()
    *       | HAllocate()
    *       | BinOp()
    *       | SimpleExp()
    */
    public String visit(Exp n, String argu) {
        // String v = get_v();
        // RACode += "MOVE " + v + " " + n.f0.accept(this, argu) + "\n";
        // return v;
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> "CALL"
    * f1 -> SimpleExp()
    * f2 -> "("
    * f3 -> ( Temp() )*
    * f4 -> ")"
    */
    public String visit(Call n, String argu) {
        String _ret = "";
        Integer offset;
        if(current_proc.name.equals("MAIN")) offset = 0;
        else offset = ((current_proc.arguments - 4 <= 0) ? 0 : (current_proc.arguments - 4)) + 8;
        
        String label = n.f1.accept(this, argu);
        
        for(int i = 0; i <= 9; ++i) {
            _ret += "ASTORE SPILLEDARG " + offset++ + " " + current_proc.temp_to_reg.get(i) + " \n";
        }

        for(int i = 0; i < n.f3.size(); ++i) {
            String code = n.f3.elementAt(i).accept(this, argu);
            if(i < 4) {
                _ret += "MOVE a" + i + " " + code + "\n";
                continue;
            }
            _ret += "PASSARG  " + (i-3) + " " + code + "\n";
        }
        _ret += "CALL " + label + "\n";

        for(int i = 9; i >= 0; --i) {
            _ret += "ALOAD " + current_proc.temp_to_reg.get(i) + " SPILLEDARG " + --offset + " \n";
        }
        RACode += _ret;
        // RACode += "CALL " + n.f1.accept(this, argu) + "\n";
        return "v0";
    }

    /**
    * f0 -> "HALLOCATE"
    * f1 -> SimpleExp()
    */
    public String visit(HAllocate n, String argu) {
        String _ret = "";
        String exp_code = n.f1.accept(this, argu);
        if(exp_code.startsWith("s") || exp_code.startsWith("t")) {
            RACode += "MOVE v0 PLUS " + exp_code + " 4\n";
            exp_code = "v0";
        }
        _ret += "HALLOCATE " + exp_code + "\n";
        used_v0 = false;
        return _ret;
    }

    /**
    * f0 -> Operator()
    * f1 -> Temp()
    * f2 -> SimpleExp()
    */
    public String visit(BinOp n, String argu) {
        String _ret = "";
        String op = n.f0.accept(this, argu);
        String temp = n.f1.accept(this, argu);
        String exp_code = n.f2.accept(this, argu);
        _ret += op + " " + temp + " " + exp_code + "\n";
        used_v0 = false;
        return _ret;
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
    * f0 -> Temp()
    *       | IntegerLiteral()
    *       | Label()
    */
    public String visit(SimpleExp n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> "TEMP"
    * f1 -> IntegerLiteral()
    */
    public String visit(Temp n, String argu) {
        String temp = current_proc.get_temp(Integer.parseInt(n.f1.f0.toString()), Instruction_no);
        if(temp.startsWith("SPILLEDARG")) {
            String v = get_v();
            RACode += "ALOAD " + v + " " + temp + "\n";
            temp = v;
        }
        return temp;
    }

    /**
    * f0 -> <INTEGER_LITERAL>
    */
    public String visit(IntegerLiteral n, String argu) {
        return n.f0.toString();
    }

    /**
    * f0 -> <IDENTIFIER>
    */
    public String visit(Label n, String argu) {
        if(argu == null) return n.f0.toString();
        if(argu.equals("label")) RACode += n.f0.toString() + " ";
        return n.f0.toString();
    }
    
}
