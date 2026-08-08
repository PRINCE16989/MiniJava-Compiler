%{
#include "P1.tab.h"
#include <string.h>
#include <iostream>
using namespace std;
extern int lc;
%}

%%

"//"[^\n]*    { /* skip single-line comment */ }

"<"                      { return '<'; }
">"                      { return '>'; }
"import"                        { return IMPORT; }
"java.util.function.Function"   { return IMPORT_FUNCT; }
"#define"                       { return DEFINE; }
"Function"                      { return FUNCTION; }
"class"                  { return CLASS; }
"public"                 { return PUBLIC; }
"static"                 { return STATIC; }
"void"                   { return VOID; }
"main"                   { return MAIN; }
"System.out.println"     { return PRINT; }
"return"                 { return RETURN; }
"extends"                { return EXTENDS; }
"int"                    { return INT; }
"boolean"                { return BOOLEAN; }
"if"                     { return IF; }
"else"                   { return ELSE; }
"while"                  { return WHILE; }
"this"                   { return THIS; }
"new"                    { return NEW; }
"true"                   { return TRUE; }
"false"                  { return FALSE; }
"length"                 { return LENGTH; }
"String"                 { return STRING; }

"&&"                     { return AND; }
"||"                     { return OR; }
"!="                     { return NEQ; }
"<="                     { return LEQ; }
"->"                     { return SPO; }
"("                      { return '('; }
")"                      { return ')'; }
"{"                      { return '{'; }
"}"                      { return '}'; }
";"                      { return ';'; }
","                      { return ','; }
"="                      { return '='; }
"["                      { return '['; }
"]"                      { return ']'; }
"+"                      { return '+'; }
"-"                      { return '-'; }
"*"                      { return '*'; }
"/"                      { return '/'; }

0|[1-9][0-9]*            { yylval.val = strdup(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*   { yylval.val = strdup(yytext); return IDENTIFIER; }

[ \t\r]+               { /* skip whitespace */ }
[\n]                        { lc++; }
.                        { return yytext[0]; }

%%

int yywrap() { return 1; }