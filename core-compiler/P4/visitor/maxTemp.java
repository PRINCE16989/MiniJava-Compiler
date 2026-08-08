package visitor;

import syntaxtree.Goal;
import syntaxtree.IntegerLiteral;
import syntaxtree.Temp;

public class maxTemp extends GJDepthFirst<Integer, String> {
    public Integer maxTemp = 0;

    /**
    * f0 -> "MAIN"
    * f1 -> StmtList()
    * f2 -> "END"
    * f3 -> ( Procedure() )*
    * f4 -> <EOF>
    */
    public Integer visit(Goal n, String argu) {
        n.f0.accept(this, argu);
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        n.f3.accept(this, argu);
        n.f4.accept(this, argu);
        return maxTemp;
    }

    /**
    * f0 -> "TEMP"
    * f1 -> IntegerLiteral()
    */
    public Integer visit(Temp n, String argu) {
        Integer x = n.f1.accept(this, null);
        maxTemp = Integer.max(maxTemp, x);
        return null;
    }

    /**
    * f0 -> <INTEGER_LITERAL>
    */
    public Integer visit(IntegerLiteral n, String argu) {
        return Integer.parseInt(n.f0.toString());
    }
}
