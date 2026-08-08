package visitor;
import helpers.*;
import syntaxtree.*;
import java.util.*;

public class dataCollector extends GJDepthFirst<String, String> {
    public dataCollector(Map<String, Integer> labelToNode) {
        LabelToNode = labelToNode;
    }
    Map<String, Integer> LabelToNode;
    public Map<String, proc> procs = new HashMap<>();
    proc current_proc;
    helperNode cur_node;
    Integer Instruction_no = 0;

    /**
    * f0 -> "MAIN"
    * f1 -> StmtList()
    * f2 -> "END"
    * f3 -> ( Procedure() )*
    * f4 -> <EOF>
    */
    public String visit(Goal n, String argu) {
        String _ret = null;
        String proc_name = n.f0.toString();
        current_proc = new proc();
        procs.put("MAIN", current_proc);
        current_proc.name = proc_name;
        // current_proc.startNode = Instruction_no;
        n.f1.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
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
        String _ret = null;
        String proc_name = n.f0.f0.toString();
        
        current_proc = new proc();
        current_proc.name = proc_name;
        current_proc.arguments = Integer.parseInt(n.f2.f0.toString());
        // current_proc.startNode = Instruction_no;
        procs.put(proc_name, current_proc);
        n.f4.accept(this, argu);    
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
        String _ret = null;
        helperNode entryNode = current_proc.get_node(Instruction_no);
        for (int i = 0; i < current_proc.arguments; i++) {
            entryNode.def.add(i);
        }
        n.f1.accept(this, argu);
        cur_node = current_proc.get_node(Instruction_no);
        if(n.f3.f0.choice instanceof Temp) {
            Integer temp_no = Integer.parseInt(((Temp)n.f3.f0.choice).f1.f0.toString());
            cur_node.use.add(temp_no);
        } else if(n.f3.f0.choice instanceof IntegerLiteral) {
            // Do nothing
        }
        Instruction_no++;
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
        String _ret = null;
        cur_node = current_proc.get_node(Instruction_no);
        n.f0.accept(this, argu);
        Instruction_no++;
        return _ret;
    }

    /**
    * f0 -> "NOOP"
    */
    public String visit(NoOpStmt n, String argu) {
        String _ret = null;
        cur_node.children.add(current_proc.get_node(Instruction_no + 1));
        return _ret;
    }

    /**
    * f0 -> "ERROR"
    */
    public String visit(ErrorStmt n, String argu) {
        String _ret=null;
        cur_node.children.add(current_proc.get_node(Instruction_no + 1));
        return _ret;
    }

    /**
    * f0 -> "CJUMP"
    * f1 -> Temp()
    * f2 -> Label()
    */
    public String visit(CJumpStmt n, String argu) {
        String _ret=null;
        Integer temp_no = Integer.parseInt(n.f1.f1.f0.toString());
        Integer to_branch = LabelToNode.get(n.f2.f0.toString());
        cur_node.children.add(current_proc.get_node(to_branch));
        cur_node.children.add(current_proc.get_node(Instruction_no + 1));
        cur_node.use.add(temp_no);
        return _ret;
    }

    /**
    * f0 -> "JUMP"
    * f1 -> Label()
    */
    public String visit(JumpStmt n, String argu) {
        String _ret = null;
        Integer to_branch = LabelToNode.get(n.f1.f0.toString());
        cur_node.children.add(current_proc.get_node(to_branch));
        return _ret;
    }

    /**
    * f0 -> "HSTORE"
    * f1 -> Temp()
    * f2 -> IntegerLiteral()
    * f3 -> Temp()
    */
    public String visit(HStoreStmt n, String argu) {
        String _ret = null;
        Integer temp_no1 = Integer.parseInt(n.f1.f1.f0.toString());
        Integer temp_no2 = Integer.parseInt(n.f3.f1.f0.toString());
        cur_node.use.add(temp_no1);
        cur_node.use.add(temp_no2);
        cur_node.children.add(current_proc.get_node(Instruction_no + 1));
        return _ret;
    }

    /**
    * f0 -> "HLOAD"
    * f1 -> Temp()
    * f2 -> Temp()
    * f3 -> IntegerLiteral()
    */
    public String visit(HLoadStmt n, String argu) {
        String _ret = null;
        Integer temp_no1 = Integer.parseInt(n.f1.f1.f0.toString());
        Integer temp_no2 = Integer.parseInt(n.f2.f1.f0.toString());
        cur_node.def.add(temp_no1);
        cur_node.use.add(temp_no2);
        cur_node.children.add(current_proc.get_node(Instruction_no + 1));
        return _ret;
    }

    /**
    * f0 -> "MOVE"
    * f1 -> Temp()
    * f2 -> Exp()
    */
    public String visit(MoveStmt n, String argu) {
        String _ret = null;
        Integer temp_no1 = Integer.parseInt(n.f1.f1.f0.toString());
        cur_node.def.add(temp_no1);
        n.f2.accept(this, "use");
        cur_node.children.add(current_proc.get_node((Instruction_no + 1)));
        return _ret;
    }

    /**
    * f0 -> "PRINT"
    * f1 -> SimpleExp()
    */
    public String visit(PrintStmt n, String argu) {
        String _ret=null;
        n.f1.accept(this, "use");
        cur_node.children.add(current_proc.get_node(Instruction_no + 1));
        return _ret;
    }

    /**
    * f0 -> Call()
    *       | HAllocate()
    *       | BinOp()
    *       | SimpleExp()
    */
    public String visit(Exp n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        return _ret;
    }

    /**
    * f0 -> "CALL"
    * f1 -> SimpleExp()
    * f2 -> "("
    * f3 -> ( Temp() )*
    * f4 -> ")"
    */
    public String visit(Call n, String argu) {
        String _ret = null;
        current_proc.has_call = true;
        n.f1.accept(this, argu);
        for(int i = 0; i < n.f3.size(); ++i) {
            Temp t = (Temp) n.f3.elementAt(i);
            cur_node.use.add(Integer.parseInt(t.f1.f0.tokenImage));
        }
        current_proc.max_args = Math.max(current_proc.max_args, n.f3.size());
        return _ret;
    }

    /**
    * f0 -> "HALLOCATE"
    * f1 -> SimpleExp()
    */
    public String visit(HAllocate n, String argu) {
        String _ret = null;
        n.f1.accept(this, argu);
        return _ret;
    }

    /**
    * f0 -> Operator()
    * f1 -> Temp()
    * f2 -> SimpleExp()
    */
    public String visit(BinOp n, String argu) {
        String _ret = null;
        cur_node.use.add(Integer.parseInt(n.f1.f1.f0.tokenImage));
        n.f2.accept(this, argu);
        return _ret;
    }
    
    /**
    * f0 -> Temp()
    *       | IntegerLiteral()
    *       | Label()
    */
    public String visit(SimpleExp n, String argu) {
        if(argu == null) return n.f0.accept(this, argu);
        if(n.f0.choice instanceof Temp) {
            if(argu.equals("use")) cur_node.use.add(Integer.parseInt(((Temp)n.f0.choice).f1.f0.tokenImage));
        }
        return n.f0.accept(this, null);
    }
}
