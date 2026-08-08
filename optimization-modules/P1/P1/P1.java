import syntaxtree.*;
import visitor.*;
import ParserFiles.*;

import java.util.HashSet;

import Exceptions.*;

public class P1 {
   public static void main(String [] args) {
      try {
         Node root = new BuritoJavaParser(System.in).Goal();
         Visitor1 v = new Visitor1();
         root.accept(v, new HashSet<>()); // Your assignment part is invoked here.
         System.out.println("No issue with variables.");
         // System.out.println("Final variable being assigned.");
         // No issue with variables.
         // Uninitialized variable found.
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
      catch (UIV e) {
         System.out.println("Uninitialized variable found.");
      }
      catch (RFV e) {
         System.out.println("Final variable being assigned.");
      }
   }
} 


