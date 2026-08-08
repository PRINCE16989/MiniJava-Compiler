import syntaxtree.*;
import visitor.*;
public class P4 {
   public static void main(String [] args) {
      try {
         Node root = new MiniIRParser(System.in).Goal();
         Integer maxTemp = root.accept(new maxTemp(), null);
         miniTomacro mm = new miniTomacro(maxTemp);
         String micorIR = root.accept(mm, null);
         System.out.println(micorIR);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
}  
