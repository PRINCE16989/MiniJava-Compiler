%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <string>
    #include <sstream>
    #include <unordered_map>
    #include <vector>
    #include <iostream>
    using namespace std;
    typedef struct {
        string name;
        vector<string> args;
        string body;
        int isExprMac;
    } Macro;

    unordered_map<string, Macro> macro_table;
    int lc = 1;

    vector<string> parse_args(const string &args_str) {
        vector<string> arg_list;
        stringstream ss(args_str);
        string token;

        while (getline(ss, token, ',')) {
            arg_list.push_back(token);
        }

        return arg_list;
    }

    string expand_macro(const Macro& macro, const vector<string>& arg_values, int isExpr) {
        string result = "";
        unordered_map<string, string> argmap;
        for (int i = 0; i < macro.args.size() && i < arg_values.size(); ++i)
            argmap[macro.args[i]] = arg_values[i];
        const string& s = macro.body;
        size_t i = 0;
        while (i < s.size()) {
            if (isalpha(s[i]) || s[i] == '_') {
                // Start of identifier
                size_t start = i;
                while (i < s.size() && (isalnum(s[i]) || s[i] == '_')) ++i;
                string ident = s.substr(start, i - start);
                auto it = argmap.find(ident);
                if (it != argmap.end()) 
                    result += "(" + it->second + ")";
                else
                    result += ident;
            } else {
                // Not identifier
                result += s[i];
                ++i;
            }
        }
        return result;
    }

    void add_macro(string &name, string &arg_list, string &body, int isExprMac) {
        Macro m;
        m.name = name;
        m.args = parse_args(arg_list);
        m.body = body;
        m.isExprMac = isExprMac;
        macro_table[name] = m;
        // cout << "Macro name: " << m.name << endl;
        // cout << "Macro args: ";
        // for (size_t i = 0; i < m.args.size(); ++i) {
        //     cout << m.args[i];
        //     if (i < m.args.size() - 1) cout << ", ";
        // }
        // cout << endl;
        // cout << "Macro body: " << m.body << endl;
    }

    void yyerror(const char *);
    int yylex(void);
%}

%union {
    char* val;
}

%token <val> IDENTIFIER PRINT NUM 
%token IMPORT IMPORT_FUNCT CLASS DEFINE PUBLIC RETURN STATIC VOID MAIN EXTENDS IF ELSE INT BOOLEAN   
%token WHILE NEW THIS TRUE FALSE LENGTH STRING AND NEQ LEQ OR SPO FUNCTION
%type <val> expression statement statements primaryExpression Identifier_list 
%type <val> expressionListOpt expressionList program MainClass VarClasses VarClass
%type <val> Var_Decl Var_Decls Var_Type Identifier_list_opt
%type <val> Method_Decls Method_Decl Import Argument Argument_list 

%%
program     : Import MacroDefs MainClass VarClasses {
                string temp = string($1) + "\n" + string($3) + "\n" + string($4);
                cout << temp << endl;
            }
            ;

Import      : IMPORT IMPORT_FUNCT ';'{
                string temp = "import java.util.function.Function;\n";
                $$ = strdup(temp.c_str());
            }
            | { $$ = strdup(""); }
            ;

MacroDefs   : MacroDefs MacroDef
            | 
            ;

MacroDef    : DEFINE IDENTIFIER '(' Identifier_list_opt ')' '{' statements '}' {
                string name = string($2);
                string body = string($7);
                string arg_list = string($4);
                add_macro(name, arg_list, body, 0);
                // cout << "statement mac : " << name << endl;
            }
            | DEFINE IDENTIFIER '(' Identifier_list_opt ')' primaryExpression {
                string name = string($2);
                string body = string($6);
                string arg_list = string($4);
                add_macro(name, arg_list, body, 1);
            }
            ;

Identifier_list_opt
            : Identifier_list { $$ = $1; }
            |   { $$ = strdup(""); }
            ;

Identifier_list
            : IDENTIFIER { $$ = $1; }
            | IDENTIFIER ',' Identifier_list {
                string temp = string($1) + "," + string($3);
                $$ = strdup(temp.c_str());
            }
            ;

MainClass   : CLASS IDENTIFIER '{' 
                PUBLIC STATIC VOID MAIN '(' STRING '[' ']' IDENTIFIER ')' '{'
                    PRINT '(' expression ')' ';' 
                '}'
            '}' {
                string temp = "class " + string($2) + "{\n" + 
                    "public static void main (String[] " + string($12) + ") {\n" +
                    "System.out.println(" + string($17) + ");\n}\n}" ;
                $$ = strdup(temp.c_str());
                // cout << "main class parsed successfully..\n";
                // cout << temp << endl;
            }

VarClasses  : VarClasses VarClass {
                string temp = string($1) + "\n" + string($2);
                $$ = strdup(temp.c_str());
            }
            | { $$ = strdup(""); }
            ;

VarClass    : CLASS IDENTIFIER '{' Var_Decls Method_Decls '}' {
                string temp = "class " + string($2) + "{\n" + string($4) + string($5) + "\n}" ;
                $$ = strdup(temp.c_str());
                // cout << "var_class parsed successfully..\n";
                // cout << temp << endl;
            }
            | CLASS IDENTIFIER EXTENDS IDENTIFIER '{' Var_Decls Method_Decls '}' {
                string temp = "class " + string($2) + " extends " + string($4) + "{\n" + string($6) + string($7) + "\n}" ;
                $$ = strdup(temp.c_str());
                // cout << "var_class parsed successfully..\n";
                // cout << temp << endl;
            }
            ;

Var_Type    : INT '[' ']' {
                string temp = "int[]";
                $$ = strdup(temp.c_str());
            }
            | INT { string temp = "int"; $$ = strdup(temp.c_str()); }
            | BOOLEAN { string temp = "boolean"; $$ = strdup(temp.c_str()); }
            | IDENTIFIER { $$ = $1; }
            | FUNCTION '<' IDENTIFIER ',' IDENTIFIER '>' { 
                string temp = "Function <" + string($3) + ", " + string($5) + "> ";
                $$ = strdup(temp.c_str());
            }
            ;

Var_Decls   : Var_Decls Var_Decl {
                string temp = string($1) + string($2);
                $$ = strdup(temp.c_str());
            }
            | { $$ = strdup(""); }
            ;

Var_Decl    : Var_Type IDENTIFIER ';' {
                string temp = string($1) + " " + string($2) + ";\n";
                $$ = strdup(temp.c_str()); 
            }
            ;

Argument_list
            : Argument { $$ = $1; }
            | Argument ',' Argument_list {
                string temp = string($1) + "," + string($3);
                $$ = strdup(temp.c_str());
            }
            | { $$ = strdup(""); }
            ;

Argument    : Var_Type IDENTIFIER {
                string temp = string($1) + " " + string($2);
                $$ = strdup(temp.c_str());
            }
            ;

Method_Decls
            : { $$ = strdup(""); }
            | Method_Decls Method_Decl { 
                string temp = string($1) + string($2); 
                $$ = strdup(temp.c_str()); 
            }
            ;
            
Method_Decl
            : PUBLIC Var_Type IDENTIFIER '(' Argument_list ')' '{' Var_Decls statements RETURN expression ';' '}'  {
                string temp = "public " + string($2) + " " + string($3) + "(" + string($5) + ") {\n" +
                    string($8) + "\n" + string($9) + "\n" + "return " + string($11) + ";\n}";
                $$ = strdup(temp.c_str()); 
            }
            ;

expressionListOpt
            : expressionList { $$ = $1; }
            | { $$ = strdup(""); }
            ;

expressionList
            : expression { $$ = $1; }
            | expressionList ',' expression {
                string temp = string($1) + "," + string($3);
                $$ = strdup(temp.c_str());
            }
            ;

expression  : primaryExpression AND primaryExpression { string temp = string($1) + " && " + string($3); $$ = strdup(temp.c_str()); }
            | primaryExpression OR primaryExpression  { string temp = string($1) + " || " + string($3); $$ = strdup(temp.c_str()); }
            | primaryExpression NEQ primaryExpression { string temp = string($1) + " != " + string($3); $$ = strdup(temp.c_str()); }
            | primaryExpression LEQ primaryExpression { string temp = string($1) + " <= " + string($3); $$ = strdup(temp.c_str()); }
            | primaryExpression '+' primaryExpression { string temp = string($1) + " + " + string($3);  $$ = strdup(temp.c_str()); }
            | primaryExpression '-' primaryExpression { string temp = string($1) + " - " + string($3);  $$ = strdup(temp.c_str()); }
            | primaryExpression '*' primaryExpression { string temp = string($1) + " * " + string($3);  $$ = strdup(temp.c_str()); }
            | primaryExpression '/' primaryExpression { string temp = string($1) + " / " + string($3);  $$ = strdup(temp.c_str()); }
            | primaryExpression '[' primaryExpression ']' {
                string temp = string($1) + "[" + string($3) + "]";
                $$ = strdup(temp.c_str());
            }
            | primaryExpression '.' IDENTIFIER '(' expressionListOpt ')' {
                string temp = string($1) + "." + string($3) + "(" + string($5) + ")";
                $$ = strdup(temp.c_str());
            }
            | primaryExpression '.' LENGTH {
                string temp = string($1) + ".length";
                $$ = strdup(temp.c_str());
            }
            | primaryExpression { $$ = $1; }
            | IDENTIFIER '(' expressionListOpt ')' {
                string macro_name = string($1);
                vector<string> arg_values = parse_args(string($3));
                auto it = macro_table.find(macro_name);
                if (it != macro_table.end()) {
                    Macro m = it->second;
                    if(!m.isExprMac) yyerror("isnotExprMac");
                    if(m.args.size() != arg_values.size()) yyerror("notsameargs");
                    string body = expand_macro(m, arg_values, 1);
                    $$ = strdup(body.c_str());
                } else {
                    string temp = macro_name + "(" + string($3) + ")";
                    $$ = strdup(temp.c_str());
                }
            }
            | '(' IDENTIFIER ')' SPO expression {
                string temp = "(" + string($2) + ")->" + string($5);
                $$ = strdup(temp.c_str()); 
            }
            ;

primaryExpression
            : NUM { $$ = $1; }
            | TRUE { string temp = "true"; $$ = strdup(temp.c_str()); }
            | FALSE { string temp = "false"; $$ = strdup(temp.c_str()); }
            | IDENTIFIER { $$ = $1; }
            | THIS { string temp = "this"; $$ = strdup(temp.c_str()); }
            | NEW INT '[' expression ']' {
                string temp = "new int[" + string($4) + "]";
                $$ = strdup(temp.c_str());
            }
            | NEW IDENTIFIER '(' ')' {
                string temp = "new " + string($2) + "()";
                $$ = strdup(temp.c_str());  
            }
            | '!' expression {
                string temp = "!" + string($2);
                $$ = strdup(temp.c_str());
            }
            | '(' expression ')' {
                string temp = "(" + string($2) + ")";
                $$ = strdup(temp.c_str());
            }
            ;

statements  : statement statements {
                string combined = string($1) + string($2);
                $$ = strdup(combined.c_str());
            }
            | { $$ = strdup(""); }
            ;

statement   : '{' statements '}' {
                string temp = "{\n" + string($2) + "}\n";
                $$ = strdup(temp.c_str());
                // cout << temp << endl;
            }
            | PRINT '(' expression ')' ';' {
                string temp = "System.out.println(" + string($3) + ");\n";
                $$ = strdup(temp.c_str());
            }
            | IDENTIFIER '=' expression ';' {
                string temp = string($1) + " = " + string($3) + ";\n";
                $$ = strdup(temp.c_str());
            }
            | IDENTIFIER '[' expression ']' '=' expression ';' {
                string temp = string($1) + "[" + string($3) + "] = " + string($6) + ";\n";
                $$ = strdup(temp.c_str());
            }
            | IF '(' expression ')' statement ELSE statement {
                string temp = "if (" + string($3) + ") \n" + string($5) + "else " + string($7);
                $$ = strdup(temp.c_str());
            }
            | IF '(' expression ')' statement {
                string temp = "if (" + string($3) + ") " + string($5);
                $$ = strdup(temp.c_str());
            }
            | WHILE '(' expression ')' statement {
                string temp = "while (" + string($3) + ") " + string($5);
                $$ = strdup(temp.c_str());
            }
            | IDENTIFIER '(' expressionListOpt ')' ';' {
                string macro_name = string($1);
                vector<string> arg_values = parse_args(string($3));
                auto it = macro_table.find(macro_name);
                if (it != macro_table.end()) {
                    // cout << "macname : " << m.name << endl;
                    // cout << "isExprMac : " << m.isExprMac << endl; 
                    if((it->second).isExprMac) yyerror("isExprMac Should be StatMac");
                    string body = expand_macro(it->second, arg_values, 0);
                    $$ = strdup(body.c_str());
                } else {
                    string temp = macro_name + "(" + string($3) + ")";
                    $$ = strdup(temp.c_str());
                }
            }
            ;
        
%%

void yyerror(const char *s) {
    /* cout << "line :" << lc << " error" << endl; */
    cout << "// Failed to parse macrojava code." << endl;
    /* cout << string(s) << endl; */
    exit(1);
}

int main() {
    return yyparse();
}