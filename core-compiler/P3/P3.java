import syntaxtree.*;
import visitor.*;
import helpers.*;

import java.util.*;
public class P3 {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
         dataCollector offset_data = new dataCollector();
         root.accept(offset_data);
         
         Map<String, Table> offset_d = offset_data.table;
         symbolTable s = offset_data.data;
         IRgen ir = new IRgen(offset_d, s);
         String IRCode = root.accept(ir, null); 
         // for(String key : ir.offsets.keySet()) {
         //    System.out.println("Table : " + key + "\n");
         //    ir.offsets.get(key).info();
         //    System.out.println();
         // }
         // s.info();
         System.out.println(IRCode);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
}  
