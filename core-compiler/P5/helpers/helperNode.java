package helpers;
import java.util.*;

public class helperNode {
    public Integer node_no;
    public Set<Integer> use = new HashSet<>();
    public Set<Integer> def = new HashSet<>();
    public Set<Integer> live_in = new HashSet<>(), live_out = new HashSet<>();
    public Set<helperNode> children = new HashSet<>();

    public helperNode(Integer x) {
        node_no = x;
    }

    public void info() {
        System.out.println("Node no: " + node_no);
        System.out.print("Use: ");
        for(Integer i : use) System.out.print(i + " ");
        System.out.println();
        System.out.print("Def: ");
        for(Integer i : def) System.out.print(i + " ");
        System.out.println();
        System.out.print("Live In: ");
        for(Integer i : live_in) System.out.print(i + " ");
        System.out.println();
        System.out.print("Live Out: ");
        for(Integer i : live_out) System.out.print(i + " ");
        System.out.println();
        System.out.print("Children: ");
        for(helperNode hn : children) System.out.print(hn.node_no + " ");
        System.out.println();
    }
}
