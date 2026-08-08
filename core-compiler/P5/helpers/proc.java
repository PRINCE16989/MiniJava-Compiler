package helpers;
import java.util.*;

public class proc {
    public String name;
    public Integer arguments = 0;
    public Integer stack_space = 0;
    public Integer max_args = 0;
    public Integer no_of_nodes = 0; 
    public Map<Integer, Integer> spilled_index = new HashMap<>();
    public Integer next_spill_index = 0;
    Map<Integer, helperNode> nodes = new HashMap<>();
    public Map<Integer, interval> intervals = new HashMap<>();
    public Map<Integer, String> temp_to_reg = new HashMap<>();
    public Integer next_pass_index = 1;
    public boolean has_call = false;

    public proc() {
        temp_to_reg.put(0, "t0");
        temp_to_reg.put(1, "t1");
        temp_to_reg.put(2, "t2");
        temp_to_reg.put(3, "t3");
        temp_to_reg.put(4, "t4");
        temp_to_reg.put(5, "t5");
        temp_to_reg.put(6, "t6");
        temp_to_reg.put(7, "t7");
        temp_to_reg.put(8, "t8");
        temp_to_reg.put(9, "t9");
        temp_to_reg.put(10, "s0");
        temp_to_reg.put(11, "s1");
        temp_to_reg.put(12, "s2");
        temp_to_reg.put(13, "s3");
        temp_to_reg.put(14, "s4");
        temp_to_reg.put(15, "s5");
        temp_to_reg.put(16, "s6");
        temp_to_reg.put(17, "s7");  
    }

    public helperNode get_node(Integer x) {
        if(nodes.containsKey(x)) return nodes.get(x);
        else {
            helperNode new_node = new helperNode(x);
            nodes.put(x, new_node);
            no_of_nodes++;
            return new_node;
        }
    }

    public String get_temp(Integer temp_no, Integer instr_no) {
        if(intervals.containsKey(temp_no)) {
            interval itv = intervals.get(temp_no);
            if(itv.reg_no != -1) {
                return temp_to_reg.get(itv.reg_no);
            } else if(spilled_index.containsKey(temp_no)) {
                return "SPILLEDARG " + spilled_index.get(temp_no);
            } else {
                System.out.println("Error: temp " + temp_no + " is spilled but no stack slot assigned.");
                return null;
            }
        }
        return null;
    }

    public void info() {
        System.out.println("Procedure Info: " + name);
        // System.out.println("No of nodes: " + no_of_nodes);
        // System.out.println("Arguments: " + arguments);
        // System.out.println("Stack Space: " + stack_space);
        // System.out.println("Max Args: " + max_args);
        // for(Integer i : nodes.keySet()) {
        //     helperNode hn = nodes.get(i);
        //     hn.info();
        //     System.out.println();
        // }

        System.out.println("Live ranges: ");
        for(Map.Entry<Integer, interval> it : intervals.entrySet()) {
            System.out.print("temp_no : " + it.getKey());
            String regInfo = (it.getValue().reg_no != -1) ? ("reg=" + it.getValue().reg_no) : ("spilled->slot=" + spilled_index.getOrDefault(it.getKey(), -1));
            System.out.println(" -> (" + it.getValue().start + ", " + it.getValue().end + ") " + regInfo);
        }
    }


    private void liveness_analysis() {
        boolean changed = true;
        while (changed) {
            changed = false;
            for (helperNode hn : nodes.values()) {
                Set<Integer> old_in = new HashSet<>(hn.live_in);
                Set<Integer> old_out = new HashSet<>(hn.live_out);
                Set<Integer> new_out = new HashSet<>();
                for (helperNode succ : hn.children) {
                    new_out.addAll(succ.live_in);
                }

                Set<Integer> new_in = new HashSet<>(hn.use);
                Set<Integer> out_minus_def = new HashSet<>(new_out);
                out_minus_def.removeAll(hn.def);
                new_in.addAll(out_minus_def);
                if (!hn.live_in.equals(new_in)) {
                    hn.live_in.clear();
                    hn.live_in.addAll(new_in);
                }
                if (!hn.live_out.equals(new_out)) {
                    hn.live_out.clear();
                    hn.live_out.addAll(new_out);
                }
                if (!old_in.equals(hn.live_in) || !old_out.equals(hn.live_out)) {
                    changed = true;
                }
            }
        }
    }

    class interval {
        public Integer temp_no;
        public Integer start, end;
        public Integer reg_no = -1;

        public interval(Integer temp_no, Integer s, Integer e) {
            this.temp_no = temp_no;
            start = s;
            end = e;
        }
    }

    private void generate_intervals(){
        for(Map.Entry<Integer, helperNode> entry : nodes.entrySet()){
            Integer node_no = entry.getKey();
            helperNode node = entry.getValue();
            for(Integer in : node.live_in){
                interval range = intervals.get(in);
                if(range != null){
                    range.start = Math.min(range.start,node_no);
                    range.end = Math.max(range.end,node_no);
                } else {
                    intervals.put(in,new interval(in, node_no,node_no));
                }
            }
            for(Integer out : node.live_out){
                interval range = intervals.get(out);
                if(range != null){
                    range.start = Math.min(range.start,node_no);
                    range.end = Math.max(range.end,node_no);
                }else{
                    intervals.put(out,new interval(out, node_no,node_no));
                }
            }
            for(Integer in : node.use){
                interval range = intervals.get(in);
                if(range != null){
                    range.start = Math.min(range.start,node_no);
                    range.end = Math.max(range.end,node_no);
                } else {
                    intervals.put(in,new interval(in, node_no,node_no));
                }
            }
            for(Integer def : node.def){
                interval range = intervals.get(def);
                if(range != null){
                    range.start = Math.min(range.start,node_no);
                    range.end = Math.max(range.end,node_no);
                } else {
                    intervals.put(def,new interval(def, node_no,node_no));
                }
            }
        }
    }

    public void register_allocation() {
        final int R = 18; 
        Vector<interval> intervalList = new Vector<>(intervals.values());
        intervalList.sort(Comparator.comparingInt(i -> i.start));
        List<interval> active = new ArrayList<>();
        Deque<Integer> freeRegs = new ArrayDeque<>();
        
        for (int r = 0; r < R; ++r) freeRegs.add(r);

        for (interval cur : intervalList) {
            expireOldIntervals(active, cur, freeRegs);
            if (freeRegs.isEmpty()) {
                spillAtInterval(active, cur);
            } else {
                int reg = freeRegs.removeFirst();
                cur.reg_no = reg;
                active.add(cur);
                active.sort(Comparator.comparingInt(i -> i.end));
            }
        }
    }

    private void expireOldIntervals(List<interval> active, interval cur, Deque<Integer> freeRegs) {
        List<interval> toRemove = new ArrayList<>();
        for (interval iv : active) {
            if (iv.end < cur.start) {
                toRemove.add(iv);
            } else {
                break;
            }
        }
        for (interval iv : toRemove) {
            active.remove(iv);
            if (iv.reg_no != -1) freeRegs.addLast(iv.reg_no);
        }
    }

    private void spillAtInterval(List<interval> active, interval cur) {
        if (active.isEmpty()) {
            cur.reg_no = -1;
            spilled_index.putIfAbsent(cur.temp_no, next_spill_index++);
            return;
        }
        interval spill = active.get(active.size() - 1);
        if (spill.end > cur.end) {
            int reg = spill.reg_no;
            cur.reg_no = reg;
            spilled_index.putIfAbsent(spill.temp_no, next_spill_index++);
            spill.reg_no = -1;
            active.remove(active.size() - 1);
            active.add(cur);
            active.sort(Comparator.comparingInt(i -> i.end));
        } else {
            cur.reg_no = -1;
            spilled_index.putIfAbsent(cur.temp_no, next_spill_index++);
        }
    }

    public void allocate_registers() {
        liveness_analysis();
        generate_intervals();
        next_spill_index = ((arguments - 4 <= 0) ? 0 : (arguments - 4)) + 8;
        if(name.equals("MAIN")) next_spill_index = 0;
        if(has_call) next_spill_index += 10;
        register_allocation();
    }
}
