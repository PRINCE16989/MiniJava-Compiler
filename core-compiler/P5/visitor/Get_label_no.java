package visitor;
import syntaxtree.*;
import java.util.*;
public class Get_label_no extends GJDepthFirst<String, String> {
    public Map<String, Integer> label_to_node = new HashMap<>();
    Integer Instruction_no = 0;

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
        n.f0.accept(this, null);
        Instruction_no++;
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
    * f0 -> "BEGIN"
    * f1 -> StmtList()
    * f2 -> "RETURN"
    * f3 -> SimpleExp()
    * f4 -> "END"
    */
    public String visit(StmtExp n, String argu) {
        String _ret=null;
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        Instruction_no++;
        return _ret;
    }
    
    /**
    * f0 -> <IDENTIFIER>
     */
    public String visit(Label n, String argu) {
        String _ret = null;
        if(argu == null) return _ret;
        if(argu.equals("label")) {
            label_to_node.put(n.f0.toString(), Instruction_no);
            // System.out.println("label: " + n.f0.toString() + " no : " + (Instruction_no + 17));
        }
        return _ret;
    }
}
