package visitor;

import Exceptions.*;
import syntaxtree.*;
import java.util.*;
public class Visitor1 extends GJDepthFirst <Set<String>, Set<String>> {
    Set<String> final_declarations = new HashSet<>();


    /**
    * f0 -> SimpleVarDeclaration()
    *       | FinalVarDeclaration()
    */
    public Set<String> visit(VarDeclaration n, Set<String> argu) {
        return n.f0.accept(this, argu);
    }
    
    /**
    * f0 -> Type()
    * f1 -> Identifier()
    * f2 -> ";"
    */
    public Set<String> visit(SimpleVarDeclaration n, Set<String> argu) {
        Set<String> _ret=null;
        String id = n.f1.f0.toString();
        argu.add(id);
        return _ret;
    }

    /**
    * f0 -> "final"
    * f1 -> Type()
    * f2 -> Identifier()
    * f3 -> "="
    * f4 -> Expression()
    * f5 -> ";"
    */
    public Set<String> visit(FinalVarDeclaration n, Set<String> argu) {
        String id = n.f2.f0.toString();
        argu.add(id);
        n.f4.accept(this, argu);
        argu.remove(id);
        final_declarations.add(id);
        return null;
    }

    /**
    * f0 -> "public"
    * f1 -> Type()
    * f2 -> Identifier()
    * f3 -> "("
    * f4 -> ( FormalParameterList() )?
    * f5 -> ")"
    * f6 -> "{"
    * f7 -> ( VarDeclaration() )*
    * f8 -> ( Statement() )*
    * f9 -> "return"
    * f10 -> Expression()
    * f11 -> ";"
    * f12 -> "}"
    */
    public Set<String> visit(MethodDeclaration n, Set<String> argu) {
        Set<String> _ret=null;
        n.f1.accept(this, argu);
        n.f2.accept(this, argu);
        n.f4.accept(this, argu);
        Set<String> s = new HashSet<>();
        final_declarations.clear();
        n.f7.accept(this, s);
        // System.out.println("initial : " + s);
        for(int i = 0; i < n.f8.size(); ++i) {
            Node s1 = n.f8.nodes.elementAt(i);
            s = s1.accept(this, s);
        }
        n.f10.accept(this, s);
        // System.out.println("final : " + s);
        return _ret;
    }

    /**
    * f0 -> "{"
    * f1 -> ( Statement() )*
    * f2 -> "}"
    */
    public Set<String> visit(Block n, Set<String> argu) {
        Set<String> _ret = new HashSet<>(argu);
        for(int i = 0; i < n.f1.size(); ++i) {
            Node s1 = n.f1.nodes.elementAt(i);
            _ret = s1.accept(this, _ret);
        }
        return _ret;
    }

    /**
    * f0 -> Identifier()
    * f1 -> "="
    * f2 -> Expression()
    * f3 -> ";"
    */
    public Set<String> visit(AssignmentStatement n, Set<String> argu) {
        Set<String> _ret = new HashSet<>(argu);
        String id = n.f0.f0.toString();
        if(final_declarations.contains(id)) throw new RFV();
        n.f2.accept(this, argu);
        _ret.remove(id);
        return _ret;
    }

    /**
    * f0 -> Identifier()
    * f1 -> "["
    * f2 -> Expression()
    * f3 -> "]"
    * f4 -> "="
    * f5 -> Expression()
    * f6 -> ";"
    */
    public Set<String> visit(ArrayAssignmentStatement n, Set<String> argu) {
        String id = n.f0.f0.toString();
        if(argu.contains(id)) throw new UIV();
        n.f2.accept(this, argu);
        n.f5.accept(this, argu);
        return argu;
    }

    /**
    * f0 -> "if"
    * f1 -> "("
    * f2 -> Expression()
    * f3 -> ")"
    * f4 -> Statement()
    * f5 -> "else"
    * f6 -> Statement()
    */
    public Set<String> visit(IfStatement n, Set<String> argu) {
        n.f2.accept(this, argu);
        Set<String> _ret = new HashSet<>(argu);
        Set<String> s1 = n.f4.accept(this, _ret);
        _ret = new HashSet<>(argu);
        Set<String> s2 = n.f6.accept(this, _ret);
        // System.out.println(s1);
        // System.out.println(s2);
        s1.addAll(s2);
        return s1;
    }

    /**
    * f0 -> "for"
    * f1 -> "("
    * f2 -> Identifier()
    * f3 -> "="
    * f4 -> Expression()
    * f5 -> ";"
    * f6 -> Expression()
    * f7 -> ";"
    * f8 -> Identifier()
    * f9 -> "="
    * f10 -> Expression()
    * f11 -> ")"
    * f12 -> Statement()
    */
    public Set<String> visit(ForStatement n, Set<String> argu) {
        Set<String> _ret = new HashSet<>(argu);
        String id = n.f2.f0.toString();
        if(final_declarations.contains(id)) throw new RFV();
        n.f4.accept(this, _ret);  
        _ret.remove(id);          
        n.f6.accept(this, _ret);  
        n.f12.accept(this, _ret); 
        id = n.f8.f0.toString();
        if(final_declarations.contains(id)) throw new RFV();
        n.f10.accept(this, _ret); 
        
        // return argu with only init var removed (guaranteed to execute)
        Set<String> result = new HashSet<>(argu);
        result.remove(n.f2.f0.toString());
        return result;
    }


    /**
    * f0 -> <IDENTIFIER>
    */
    public Set<String> visit(Identifier n, Set<String> argu) {
        String id = n.f0.toString();
        if(argu.contains(id)) throw new UIV();
        return argu;
    }
}
