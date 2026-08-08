import FunkyTacoParser.FunkyTacoJavaParser;
import inliner.CallGraphBuilder;
import inliner.InlinePrinter;
import inliner.PointsToAnalysis;
import inliner.ProgramModel;
import inliner.SymbolTableBuilder;
import syntaxtree.Goal;

public final class P4 {
    private P4() {
    }

    public static void main(String[] args) throws Exception {
        new FunkyTacoJavaParser(System.in);
        Goal goal = FunkyTacoJavaParser.Goal();

        ProgramModel program = SymbolTableBuilder.build(goal);
        CallGraphBuilder.markRecursiveMethods(goal, program);
        PointsToAnalysis.AnalysisResult analysis = PointsToAnalysis.analyze(program);
        System.out.print(InlinePrinter.print(goal, program, analysis));
    }
}
