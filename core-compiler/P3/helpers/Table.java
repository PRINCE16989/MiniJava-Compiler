package helpers;

import java.util.LinkedHashMap;
import java.util.Map;

public class Table {
    public Map<String, pair<String, Integer>> vtable = new LinkedHashMap<>();
    public Map<String, Integer> field_offset = new LinkedHashMap<>();     
    public Integer cur_off = 4;
    public Integer method_offset = 0;

    public Table() {}
    public Table(Table A) {
        this.vtable = new LinkedHashMap<>(A.vtable);
        this.field_offset = new LinkedHashMap<>(A.field_offset);
        this.cur_off = A.cur_off;
        this.method_offset = A.method_offset;
    }

    public void info() {
        for(String method : vtable.keySet()) {
            System.out.println("method : " + method + " offset :  " + vtable.get(method).first);
        }
        for(String field : field_offset.keySet()) {
            System.out.println("field : " + field + " offset : " + field_offset.get(field));
        }
    }
}
