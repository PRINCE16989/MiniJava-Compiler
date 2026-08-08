import helpers.*;
import visitor.*;
import syntaxtree.*;
public class P2 {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
         // Invoke the parser, match the Goal production and return the
         // syntax tree.

         // System.out.println("Program parsed successfully");
         dataCollector data = new dataCollector();
         root.accept(data);
         // data.data.info();
         // root.accept(new Typechecker<Object>(data.collector));
         typeChecker obj = new typeChecker(data.data);
         root.accept(obj, null);
         System.out.println("Program type checked successfully");
         // System.out.println("Type error");
         // System.out.println("Symbol not found");
         // pass the visitor to each syntax tree node.
         //  System.out.println("Num of assgn stmts = "+v.cnt);
         // data.print_status();
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
      catch (SNF e) {
         System.out.println(e.getMessage());
         // System.out.println("Program type checked successfully");
         // System.out.println(e.error_message);
      }
      catch (TE e) {
         System.out.println("Type error");
         // System.out.println("Program type checked successfully");
         // System.out.println(e.error_message);
      }
   }
}
