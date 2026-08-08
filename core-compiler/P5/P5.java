import syntaxtree.*;
import visitor.*;

import java.util.HashMap;

import helpers.*;
public class P5 {
   public static void main(String [] args) {
      try {
         Node root = new microIRParser(System.in).Goal();
         Get_label_no gln = new Get_label_no();
         root.accept(gln, null);
         dataCollector visitor = new dataCollector(gln.label_to_node);
         root.accept(visitor, null);
         for(proc p : visitor.procs.values()) {
            // run full allocation (liveness, boundary collection, merging, allocation)
            p.allocate_registers();
            //  p.build_interference_graph();
            //  p.print_allocation();
            // p.info();
         }
         root.accept(new microIRtominiRA(visitor.procs), null);
      } catch (ParseException e) {
         System.out.println(e.toString());
      }
    }
} 


