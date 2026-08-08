import java.util.HashMap;

import ParseFiles.*;
import syntaxtree.*;
import visitor.*;

public class P2 {
   public static void main(String[] args) {
      try {
         Node root = new BuritoJavaParser(System.in).Goal();
         HashMap<String, types.Types> ClassMethod_table = new HashMap<String, types.Types>();
         root.accept(new types(ClassMethod_table), null);
         String TacoCode = "";
         root.accept(new visitor1(ClassMethod_table), TacoCode);
         System.out.println(TacoCode);
      } catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
}
