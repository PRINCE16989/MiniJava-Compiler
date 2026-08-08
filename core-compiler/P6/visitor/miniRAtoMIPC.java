package visitor;
import syntaxtree.*;

public class miniRAtoMIPC extends GJDepthFirst<String, String> {
    Integer stackSpace;
    String MIPCcode = "\t.text\n\t.globl main\n";
    /**
    * f0 -> "MAIN"
    * f1 -> "["
    * f2 -> IntegerLiteral()
    * f3 -> "]"
    * f4 -> "["
    * f5 -> IntegerLiteral()
    * f6 -> "]"
    * f7 -> "["
    * f8 -> IntegerLiteral()
    * f9 -> "]"
    * f10 -> StmtList()
    * f11 -> "END"
    * f12 -> ( SpillInfo() )?
    * f13 -> ( Procedure() )*
    * f14 -> <EOF>
    */
    public String visit(Goal n, String argu) {
        String _ret = "";
        stackSpace = Integer.parseInt(n.f5.f0.toString());
        MIPCcode += "main:\n";
        MIPCcode += "\tmove $fp, $sp\n";
        MIPCcode += "\tsw $ra, -4($fp)\n";
        MIPCcode += "\tsubu $sp, $sp, " + (stackSpace*4 + 4) + "\n";
        n.f10.accept(this, argu);
        MIPCcode += "\taddu $sp, $sp, " + (stackSpace*4 + 4) + "\n";
        MIPCcode += "\tlw $ra, -4($fp)\n";
        MIPCcode += "\tj $ra\n";
        n.f13.accept(this, argu);
        n.f14.accept(this, argu);
        MIPCcode += "\n\t.text\n" + 
                        "\t.globl _halloc\n" + 
                        "_halloc:\n" + 
                        "\tli $v0, 9\n" + 
                        "\tsyscall\n" + 
                        "\tj $ra\n" + 
                        "\n\t.text\n" + 
                        "\t.globl _print\n" + 
                        "_print:\n" + 
                        "\tli $v0, 1\n" + 
                        "\tsyscall\n" + 
                        "\tla $a0, newl\n" + 
                        "\tli $v0, 4\n" + 
                        "\tsyscall\n" + 
                        "\tj $ra\n" + 
                        "\n\t.data\n" + 
                        "\t.align 0\n" + 
                        "newl:\t.asciiz \"\\n\"" +
                        "\n\t.data\n" + 
                        "\t.align 0\n" + 
                        "str_er: .asciiz \"ERROR: abnormal termination\\n\"";
        System.out.println(MIPCcode);
        return _ret;
    }

    /**
    * f0 -> ( ( Label() )? Stmt() )*
    */
    public String visit(StmtList n, String argu) {
        String _ret = "";
        n.f0.accept(this, "label");
        return _ret;
    }

    /**
    * f0 -> Label()
    * f1 -> "["
    * f2 -> IntegerLiteral()
    * f3 -> "]"
    * f4 -> "["
    * f5 -> IntegerLiteral()
    * f6 -> "]"
    * f7 -> "["
    * f8 -> IntegerLiteral()
    * f9 -> "]"
    * f10 -> StmtList()
    * f11 -> "END"
    * f12 -> ( SpillInfo() )?
    */
    public String visit(Procedure n, String argu) {
        String _ret = "";
        String proc_name = n.f0.f0.toString();
        stackSpace = Integer.parseInt(n.f5.f0.toString());
        MIPCcode += "\n\t.text\n";
        MIPCcode += "\t.globl " + proc_name + "\n";
        MIPCcode += proc_name + ":\n";
        MIPCcode += "\tsw $fp -8($sp)\n" + "\tmove $fp, $sp\n";
        MIPCcode += "\tsw $ra, -4($fp)\n";
        MIPCcode += "\tsubu $sp, $sp, " + (stackSpace + 2)*4 + "\n";
        n.f10.accept(this, argu);
        n.f12.accept(this, argu);
        MIPCcode += "\taddu $sp, $sp, " + (stackSpace + 2)*4 + "\n";
        MIPCcode += "\tlw $ra, -4($fp)\n";
        MIPCcode += "\tlw $fp, -8($sp)\n";
        MIPCcode += "\tj $ra\n";
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
    *       | ALoadStmt()
    *       | AStoreStmt()
    *       | PassArgStmt()
    *       | CallStmt()
    */
    public String visit(Stmt n, String argu) {
        return n.f0.accept(this, null);
    }

    /**
    * f0 -> "NOOP"
    */
    public String visit(NoOpStmt n, String argu) {
        MIPCcode += "\tnop\n";
        return "";
    }

    /**
    * f0 -> "ERROR"
    */
    public String visit(ErrorStmt n, String argu) {
        MIPCcode += "\tli $v0, 4\n" + 
                    "\tla $a0, str_er\n" + 
                    "\tsyscall\n" + 
                    "\tli $v0, 10\n" + 
                    "\tsyscall\n";
        return "";
    }

    /**
    * f0 -> "CJUMP"
    * f1 -> Reg()
    * f2 -> Label()
    */
    public String visit(CJumpStmt n, String argu) {
        MIPCcode += "\tbeqz " + n.f1.accept(this, argu) + ", " + n.f2.accept(this, argu) + "\n";
        return "";
    }

    /**
    * f0 -> "JUMP"
    * f1 -> Label()
    */
    public String visit(JumpStmt n, String argu) {
        MIPCcode += "\tj " + n.f1.accept(this, argu) + "\n";
        return "";
    }

    /**
    * f0 -> "HSTORE"
    * f1 -> Reg()
    * f2 -> IntegerLiteral()
    * f3 -> Reg()
    */
    public String visit(HStoreStmt n, String argu) {
        MIPCcode += "\tsw " + n.f3.accept(this, argu) + ", " + n.f2.accept(this, argu) + "(" + n.f1.accept(this, argu) + ")\n";
        return "";
    }

    /**
    * f0 -> "HLOAD"
    * f1 -> Reg()
    * f2 -> Reg()
    * f3 -> IntegerLiteral()
    */
    public String visit(HLoadStmt n, String argu) {
        MIPCcode += "\tlw " + n.f1.accept(this, argu) + ", " + n.f3.accept(this, argu) + "(" + n.f2.accept(this, argu) + ")\n";
        return "";
    }

    /**
    * f0 -> "MOVE"
    * f1 -> Reg()
    * f2 -> Exp()
    */
    public String visit(MoveStmt n, String argu) {
        String reg = n.f1.accept(this, argu);
        n.f2.accept(this, "move," + reg);
        return "";
    }

    /**
    * f0 -> "PRINT"
    * f1 -> SimpleExp()
    */
    public String visit(PrintStmt n, String argu) {
        String expr = n.f1.accept(this, argu);
        try {
            Integer val = Integer.parseInt(expr);
            MIPCcode += "\tli $a0, " + val + "\n";
        } catch (NumberFormatException e) {
            MIPCcode += "\tmove $a0, " + expr + "\n";
        }
        MIPCcode += "\tjal _print\n";
        return "";
    }

    /**
    * f0 -> "ALOAD"
    * f1 -> Reg()
    * f2 -> SpilledArg()
    */
    public String visit(ALoadStmt n, String argu) {
        Integer offset = Integer.parseInt(n.f2.f1.f0.toString()) + 3;
        MIPCcode += "\tlw " + n.f1.accept(this, argu) + ", -" + offset*4 + "($fp)\n";
        return "";
    }

    /**
    * f0 -> "ASTORE"
    * f1 -> SpilledArg()
    * f2 -> Reg()
    */
    public String visit(AStoreStmt n, String argu) {
        Integer offset = Integer.parseInt(n.f1.f1.f0.toString()) + 3;
        MIPCcode += "\tsw " + n.f2.accept(this, argu) + ", -" + offset*4 + "($fp)\n";
        return "";
    }

    /**
    * f0 -> "PASSARG"
    * f1 -> IntegerLiteral()
    * f2 -> Reg()
    */
    public String visit(PassArgStmt n, String argu) {
        Integer offset = Integer.parseInt(n.f1.f0.toString());
        MIPCcode += "\tsw " + n.f2.accept(this, argu) + ", -" + (offset+2)*4 + "($sp)\n";
        return "";
    }

    /**
    * f0 -> "CALL"
    * f1 -> SimpleExp()
    */
    public String visit(CallStmt n, String argu) {
        String code;
        if(n.f1.f0.choice instanceof Label) {
            code = "\tjal " + n.f1.accept(this, argu) + "\n";
        } else {
            code = "\tjalr " + n.f1.accept(this, argu) + "\n";
        }
        MIPCcode += code;
        return "";
    }

    /**
    * f0 -> HAllocate()
    *       | BinOp()
    *       | SimpleExp()
    */
    public String visit(Exp n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> "HALLOCATE"
    * f1 -> SimpleExp()
    */
    public String visit(HAllocate n, String argu) {
        String req_space = n.f1.accept(this, null);
        if(n.f1.f0.choice instanceof Reg) MIPCcode += "\tmove $a0, " + req_space + "\n";
        else MIPCcode += "\tli $a0, " + req_space + "\n";
        MIPCcode += "\tjal _halloc\n";
        if(argu != null && argu.startsWith("move,")) {
            String dest = argu.split(",")[1];
            MIPCcode += "\tmove " + dest + ", $v0\n";
        }
        return req_space;
    }

    /**
    * f0 -> Operator()
    * f1 -> Reg()
    * f2 -> SimpleExp()
    */
    public String visit(BinOp n, String argu) {
        String op = n.f0.accept(this, argu);
        String dest = "$v0";
        String reg = n.f1.accept(this, null);
        String expr = n.f2.accept(this, null);
        if(argu != null && argu.startsWith("move,")) {
            dest = argu.split(",")[1];
        }
        MIPCcode += "\t" + op + " " + dest + ", " + reg + ", " + expr + "\n";
        return dest;
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
        String op = n.f0.choice.toString();
        if(op.equals("LE")) {
            return "sle";
        } else if(op.equals("NE")) {
            return "sne";
        } else if(op.equals("PLUS")) {
            return "add";
        } else if(op.equals("MINUS")) {
            return "sub";
        } else if(op.equals("TIMES")) {
            return "mul";
        } else if(op.equals("DIV")) {
            return "div";
        }
        return "";
    }

    /**
    * f0 -> "a0"
    *       | "a1"
    *       | "a2"
    *       | "a3"
    *       | "t0"
    *       | "t1"
    *       | "t2"
    *       | "t3"
    *       | "t4"
    *       | "t5"
    *       | "t6"
    *       | "t7"
    *       | "s0"
    *       | "s1"
    *       | "s2"
    *       | "s3"
    *       | "s4"
    *       | "s5"
    *       | "s6"
    *       | "s7"
    *       | "t8"
    *       | "t9"
    *       | "v0"
    *       | "v1"
    */
    public String visit(Reg n, String argu) {
        String reg = "$" + n.f0.choice.toString();
        if(argu != null && argu.startsWith("move,")) {
            String dest = argu.split(",")[1];
            MIPCcode += "\tmove " + dest + ", " + reg + "\n";
        }        
        return reg;
    }

    /**
    * f0 -> "SPILLEDARG"
    * f1 -> IntegerLiteral()
    */
    public String visit(SpilledArg n, String argu) {
        Integer spilled_offset = Integer.parseInt(n.f1.toString());
        return spilled_offset.toString();
    }

    /**
    * f0 -> Reg()
    *       | IntegerLiteral()
    *       | Label()
    */
    public String visit(SimpleExp n, String argu) {
        return n.f0.accept(this, argu);
    }

    /**
    * f0 -> <INTEGER_LITERAL>
    */
    public String visit(IntegerLiteral n, String argu) {
        String val = n.f0.toString();
        if(argu != null && argu.startsWith("move,")) {
            String dest = argu.split(",")[1];
            MIPCcode += "\tli " + dest + ", " + val + "\n";
        }
        return val;
    }

    /**
    * f0 -> <IDENTIFIER>
    */
    public String visit(Label n, String argu) {
        if(argu == null) return n.f0.toString();
        else if(argu.equals("label")) {
            MIPCcode += n.f0.toString() + ":\n";
            return "";
        }
        else if(argu.startsWith("move,")) {
            String dest = argu.split(",")[1];
            MIPCcode += "\tla " + dest + ", " + n.f0.toString() + "\n";
        }
        return n.f0.toString();
    }

    /**
    * f0 -> "//"
    * f1 -> SpillStatus()
    */
    public String visit(SpillInfo n, String argu) {
        return "";
    }

    /**
    * f0 -> <SPILLED>
    *       | <NOTSPILLED>
    */
    public String visit(SpillStatus n, String argu) {
        return "";
    }

}

