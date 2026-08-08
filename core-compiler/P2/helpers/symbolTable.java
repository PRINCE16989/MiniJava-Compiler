package helpers;
import java.util.Map;
import java.util.Vector;
import java.util.HashMap;
public class symbolTable {
    private Map<String, collector> classes = new HashMap<>();
    public Map<collector, collector> inheritMap = new HashMap<>();
    public Boolean imported_lambda = false;
    
    public collector get_class(String name) {
        if(classes.containsKey(name)) {
            return classes.get(name);
        }
        else throw new TE("Class " + name + " not found");
    }

    public void add_class(String name) {
        classes.put(name, new collector(name));
    }

    public void add_inheritence(String derived, String base) {
        inheritMap.put(get_class(derived), get_class(base));
    }

    public void add_method(String method, String class_name) {
        collector class_collector = get_class(class_name);
        class_collector.add_method(method);
    }

    public collector.Method get_method(String method_name, String cls_name) {
        if(!classes.containsKey(cls_name)) throw new TE("Class not found");
        collector curr_class = classes.get(cls_name);
        collector.Method curr_Method = null;
        try{ curr_Method = curr_class.get_method(method_name); }
        catch(SNF e) { curr_Method = null; }
        while(curr_Method == null) {
            if(inheritMap.containsKey(curr_class)) {
                curr_class = inheritMap.get(curr_class);    
                try{ curr_Method = curr_class.get_method(method_name); }
                catch(SNF e) { curr_Method = null; }
            }
            else throw new SNF();
        }
        return curr_Method;
    }

    public void add_field(String method, String class_name, String var, String type) {
        collector class_Collector = get_class(class_name);
        if(method == null || method.isEmpty()) {
            class_Collector.add_field(var, type);
        } else {
            collector.Method currMethod = class_Collector.get_method(method);
            currMethod.add_field(var, type);
        }
    }

    public void remove_field(String method, String class_name, String var) {
        collector class_Collector = get_class(class_name);
        if(method == null || method.isEmpty()) {
            class_Collector.remove_field(var);
        } else {
            collector.Method currMethod = class_Collector.get_method(method);
            currMethod.remove_field(var);
        }   
    }
    public String get_class_type(String var) {
        if(var.equals("int") || var.equals("boolean") || var.startsWith("Function<") || var.equals("int[]")) 
            return var;
        if(var.equals("Integer")) return "int";
        if(var.equals("Boolean")) return "boolean";
        for(String class_name : classes.keySet()) {
            if(class_name.equals(var)) return class_name;
        }
        throw new SNF("Type error : Class " + var + " not found");
    }

    public String get_type(String var, String method, String class_name) {
        collector currClass = get_class(class_name);
        String type = null;
        if(method != null && method != "") {
            collector.Method currMethod = currClass.get_method(method);
            type = currMethod.get_type_in_method(var);
        }
        if(type == null) type = currClass.get_type_in_class(var);
        while(type == null) {
            if(inheritMap.containsKey(currClass))
                currClass = inheritMap.get(currClass);
            else throw new SNF("Symbol not found in identifier" + var);
            type = currClass.get_type_in_class(var);
        }
        return type;
    }

    public void valid_method(String method, String class_name) {
        collector currClass = get_class(class_name);
        collector.Method currMethod = currClass.get_method(method);
        
        if(!inheritMap.containsKey(currClass)) 
            return; // No inheritance, no overriding to check
        
        collector parentClass = inheritMap.get(currClass);
        collector.Method parentMethod = null;
        while(parentClass != null) {
            try { parentMethod = parentClass.get_method(method); }
            catch (SNF e) { parentMethod = null; }
            if(parentMethod != null) break;
            if(inheritMap.containsKey(parentClass))
                parentClass = inheritMap.get(parentClass);
            else return;
        }

        // Check return type compatibility
        if (!currMethod.return_type.equals(parentMethod.return_type)) {
            throw new TE("Method " + method + " in class " + class_name + 
                        " has incompatible return type. Expected: " + parentMethod.return_type + 
                        ", Found: " + currMethod.return_type);
        }
        
        // Check parameter count
        if (currMethod.params.size() != parentMethod.params.size()) {
            throw new TE("Method " + method + " in class " + class_name + 
                        " has different number of parameters than parent method");
        }
        
        // Check parameter types (assuming params are ordered)
        Vector<String> currParamTypes = currMethod.param_list;
        Vector<String> parentParamTypes = parentMethod.param_list;
        
        for (int i = 0; i < currParamTypes.size(); i++) {
            if (!currParamTypes.get(i).equals(parentParamTypes.get(i))) {
                throw new TE("Method " + method + " in class " + class_name + 
                            " has incompatible parameter types with parent method");
            }
        }
        
        return;
    }

    public void info() {
        for(String class_name : classes.keySet()) {
            System.out.println("Class : " + class_name);
            collector currClass = classes.get(class_name);
            System.out.println("Fields : ");
            for(String field : currClass.fields.keySet()) {
                System.out.println("\t" + field + " : " + currClass.fields.get(field));
            }
            System.out.println("Methods : ");
            for(String method_name : currClass.methods.keySet()) {
                System.out.println("\tMethod : " + method_name);
                collector.Method currMethod = currClass.methods.get(method_name);
                System.out.println("\tReturn type : " + currMethod.return_type);
                System.out.println("\tParameters : ");
                for(String param : currMethod.params.keySet()) {
                    System.out.println("\t\t" + param + " : " + currMethod.params.get(param));
                }
                System.out.println("\tFields : ");
                for(String field : currMethod.method_fields.keySet()) {
                    System.out.println("\t\t" + field + " : " + currMethod.method_fields.get(field));
                }
            }
        }

        System.out.println("Inheritence : ");
        for(collector derived : inheritMap.keySet()) {
            collector base = inheritMap.get(derived);
            System.out.println("\t" + derived.class_name + " extends " + base.class_name);
        }
    }
}
