package helpers;
import java.util.Map;
import java.util.HashMap;
import java.util.Vector;

public class collector {
    public collector(String name) {
        class_name = name;
    }
    public Map<String, String> fields = new HashMap<>();
    public Map<String, Method> methods = new HashMap<>();
    public String class_name = "";

    public String get_type_in_class(String var) {
        if(fields.containsKey(var))
            return fields.get(var);
        return null;
    }

    public void add_method(String method_name) {
        if(methods.containsKey(method_name)) 
            throw new Error("Overloading");
        methods.put(method_name, new Method());
    }

    public void add_field(String var, String var_type) {
        if(fields.containsKey(var))
            throw new Error("Redefinition");
        fields.put(var, var_type);
    }
    
    public void remove_field(String var) {
        if(!fields.containsKey(var))
            throw new Error("removing a variable that does not exist");
        fields.remove(var);
    }
    
    public Method get_method(String name) {
        if(methods.containsKey(name)) 
            return methods.get(name);   
        // return null;
        throw new SNF("method " + name + "is not found");
    }

    public class Method {
        public Map<String, String> method_fields = new HashMap<>(), params = new HashMap<>();
        public Vector<String> param_list = new Vector<>();
        public String return_type;
        public String class_name;

        public void add_field(String var, String var_type) {
            if(method_fields.containsKey(var)) 
                throw new Error("Redefinition");
            method_fields.put(var, var_type);
        }

        public void remove_field(String var) {
            if(!method_fields.containsKey(var))
                throw new Error("removing a variable that does not exist");
            method_fields.remove(var);
        }

        public String get_type_in_method(String var) {
            for(String field : method_fields.keySet()) {
                if(field.equals(var)) return method_fields.get(field);
            }

            for(String param : params.keySet()) {
                if(param.equals(var)) return params.get(param);
            }
            
            return null;
        }
    }
}

