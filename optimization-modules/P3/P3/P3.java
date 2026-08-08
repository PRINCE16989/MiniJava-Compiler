import Taco2Parser.*;
import syntaxtree.Goal;
import visitor.ConstPropVisitor;

public class P3 {
    public static void main(String[] args) throws Exception {
        Goal root = parse();
        ConstPropVisitor visitor = new ConstPropVisitor();
        System.out.print(visitor.optimize(root));
    }

    private static Goal parse() throws ParseException {
        try {
            new TACoJavaParser(System.in);
        } catch (Error ignored) {
            TACoJavaParser.ReInit(System.in);
        }
        return TACoJavaParser.Goal();
    }
}
