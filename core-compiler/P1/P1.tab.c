/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "P1.y"

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

#line 151 "P1.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "P1.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_IDENTIFIER = 3,                 /* IDENTIFIER  */
  YYSYMBOL_PRINT = 4,                      /* PRINT  */
  YYSYMBOL_NUM = 5,                        /* NUM  */
  YYSYMBOL_IMPORT = 6,                     /* IMPORT  */
  YYSYMBOL_IMPORT_FUNCT = 7,               /* IMPORT_FUNCT  */
  YYSYMBOL_CLASS = 8,                      /* CLASS  */
  YYSYMBOL_DEFINE = 9,                     /* DEFINE  */
  YYSYMBOL_PUBLIC = 10,                    /* PUBLIC  */
  YYSYMBOL_RETURN = 11,                    /* RETURN  */
  YYSYMBOL_STATIC = 12,                    /* STATIC  */
  YYSYMBOL_VOID = 13,                      /* VOID  */
  YYSYMBOL_MAIN = 14,                      /* MAIN  */
  YYSYMBOL_EXTENDS = 15,                   /* EXTENDS  */
  YYSYMBOL_IF = 16,                        /* IF  */
  YYSYMBOL_ELSE = 17,                      /* ELSE  */
  YYSYMBOL_INT = 18,                       /* INT  */
  YYSYMBOL_BOOLEAN = 19,                   /* BOOLEAN  */
  YYSYMBOL_WHILE = 20,                     /* WHILE  */
  YYSYMBOL_NEW = 21,                       /* NEW  */
  YYSYMBOL_THIS = 22,                      /* THIS  */
  YYSYMBOL_TRUE = 23,                      /* TRUE  */
  YYSYMBOL_FALSE = 24,                     /* FALSE  */
  YYSYMBOL_LENGTH = 25,                    /* LENGTH  */
  YYSYMBOL_STRING = 26,                    /* STRING  */
  YYSYMBOL_AND = 27,                       /* AND  */
  YYSYMBOL_NEQ = 28,                       /* NEQ  */
  YYSYMBOL_LEQ = 29,                       /* LEQ  */
  YYSYMBOL_OR = 30,                        /* OR  */
  YYSYMBOL_SPO = 31,                       /* SPO  */
  YYSYMBOL_FUNCTION = 32,                  /* FUNCTION  */
  YYSYMBOL_33_ = 33,                       /* ';'  */
  YYSYMBOL_34_ = 34,                       /* '('  */
  YYSYMBOL_35_ = 35,                       /* ')'  */
  YYSYMBOL_36_ = 36,                       /* '{'  */
  YYSYMBOL_37_ = 37,                       /* '}'  */
  YYSYMBOL_38_ = 38,                       /* ','  */
  YYSYMBOL_39_ = 39,                       /* '['  */
  YYSYMBOL_40_ = 40,                       /* ']'  */
  YYSYMBOL_41_ = 41,                       /* '<'  */
  YYSYMBOL_42_ = 42,                       /* '>'  */
  YYSYMBOL_43_ = 43,                       /* '+'  */
  YYSYMBOL_44_ = 44,                       /* '-'  */
  YYSYMBOL_45_ = 45,                       /* '*'  */
  YYSYMBOL_46_ = 46,                       /* '/'  */
  YYSYMBOL_47_ = 47,                       /* '.'  */
  YYSYMBOL_48_ = 48,                       /* '!'  */
  YYSYMBOL_49_ = 49,                       /* '='  */
  YYSYMBOL_YYACCEPT = 50,                  /* $accept  */
  YYSYMBOL_program = 51,                   /* program  */
  YYSYMBOL_Import = 52,                    /* Import  */
  YYSYMBOL_MacroDefs = 53,                 /* MacroDefs  */
  YYSYMBOL_MacroDef = 54,                  /* MacroDef  */
  YYSYMBOL_Identifier_list_opt = 55,       /* Identifier_list_opt  */
  YYSYMBOL_Identifier_list = 56,           /* Identifier_list  */
  YYSYMBOL_MainClass = 57,                 /* MainClass  */
  YYSYMBOL_VarClasses = 58,                /* VarClasses  */
  YYSYMBOL_VarClass = 59,                  /* VarClass  */
  YYSYMBOL_Var_Type = 60,                  /* Var_Type  */
  YYSYMBOL_Var_Decls = 61,                 /* Var_Decls  */
  YYSYMBOL_Var_Decl = 62,                  /* Var_Decl  */
  YYSYMBOL_Argument_list = 63,             /* Argument_list  */
  YYSYMBOL_Argument = 64,                  /* Argument  */
  YYSYMBOL_Method_Decls = 65,              /* Method_Decls  */
  YYSYMBOL_Method_Decl = 66,               /* Method_Decl  */
  YYSYMBOL_expressionListOpt = 67,         /* expressionListOpt  */
  YYSYMBOL_expressionList = 68,            /* expressionList  */
  YYSYMBOL_expression = 69,                /* expression  */
  YYSYMBOL_primaryExpression = 70,         /* primaryExpression  */
  YYSYMBOL_statements = 71,                /* statements  */
  YYSYMBOL_statement = 72                  /* statement  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   198

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  50
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  23
/* YYNRULES -- Number of rules.  */
#define YYNRULES  69
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  186

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   287


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    48,     2,     2,     2,     2,     2,     2,
      34,    35,    45,    43,    38,    44,    47,    46,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    33,
      41,    49,    42,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    39,     2,    40,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    36,     2,    37,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    94,    94,   100,   104,   107,   108,   111,   118,   127,
     128,   132,   133,   139,   152,   156,   159,   165,   173,   177,
     178,   179,   180,   186,   190,   193,   200,   201,   205,   208,
     215,   216,   223,   231,   232,   236,   237,   243,   244,   245,
     246,   247,   248,   249,   250,   251,   255,   259,   263,   264,
     279,   286,   287,   288,   289,   290,   291,   295,   299,   303,
     309,   313,   316,   321,   325,   329,   333,   337,   341,   345
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "IDENTIFIER", "PRINT",
  "NUM", "IMPORT", "IMPORT_FUNCT", "CLASS", "DEFINE", "PUBLIC", "RETURN",
  "STATIC", "VOID", "MAIN", "EXTENDS", "IF", "ELSE", "INT", "BOOLEAN",
  "WHILE", "NEW", "THIS", "TRUE", "FALSE", "LENGTH", "STRING", "AND",
  "NEQ", "LEQ", "OR", "SPO", "FUNCTION", "';'", "'('", "')'", "'{'", "'}'",
  "','", "'['", "']'", "'<'", "'>'", "'+'", "'-'", "'*'", "'/'", "'.'",
  "'!'", "'='", "$accept", "program", "Import", "MacroDefs", "MacroDef",
  "Identifier_list_opt", "Identifier_list", "MainClass", "VarClasses",
  "VarClass", "Var_Type", "Var_Decls", "Var_Decl", "Argument_list",
  "Argument", "Method_Decls", "Method_Decl", "expressionListOpt",
  "expressionList", "expression", "primaryExpression", "statements",
  "statement", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-122)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      10,    20,    21,  -122,    -3,  -122,    54,  -122,    29,    31,
    -122,  -122,     8,    17,    58,    60,    65,    71,  -122,    63,
      41,    45,  -122,    -1,    68,    65,    62,    73,  -122,    77,
    -122,  -122,  -122,    23,  -122,  -122,  -122,    66,     9,    66,
    -122,    46,    74,    67,    70,    69,    79,   100,    64,   115,
      -6,    81,    83,    84,     9,    82,     9,  -122,  -122,  -122,
      72,  -122,    56,    99,  -122,     1,   103,    95,    66,    66,
      38,  -122,   104,   104,   104,   104,   104,   104,   104,   104,
     104,    14,    66,    66,    66,    66,    66,    66,    94,  -122,
    -122,    74,    92,   130,   102,    74,  -122,  -122,    97,  -122,
     106,   105,   101,  -122,   116,  -122,  -122,  -122,  -122,   109,
    -122,  -122,  -122,  -122,   117,  -122,   118,   110,   122,   121,
     128,   129,  -122,     5,  -122,   119,  -122,   162,   126,  -122,
    -122,    66,    66,  -122,    66,   134,   120,  -122,   135,     9,
       9,  -122,   167,   137,   169,  -122,  -122,   138,  -122,    66,
    -122,   157,  -122,   133,    74,   141,  -122,   144,     9,  -122,
     175,   145,   143,   146,  -122,  -122,  -122,   147,    74,   180,
    -122,  -122,   151,     4,    66,    -6,   168,   152,    66,   153,
     155,   154,   156,   158,  -122,  -122
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       4,     0,     0,     6,     0,     1,     0,     3,     0,     0,
       5,    15,     0,     0,     2,     0,    10,     0,    14,     0,
      11,     0,     9,     0,     0,     0,     0,     0,    24,     0,
      12,    54,    51,     0,    55,    52,    53,     0,    61,     0,
       8,     0,    30,     0,     0,     0,    54,     0,     0,    48,
       0,     0,     0,     0,    61,     0,    61,    58,    24,    21,
      19,    20,     0,     0,    23,     0,     0,     0,     0,    34,
      54,    59,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,    34,     0,     0,     0,     0,     0,     0,     7,
      60,    30,     0,     0,     0,     0,    16,    31,     0,    57,
       0,     0,    33,    35,     0,    37,    39,    40,    38,     0,
      41,    42,    43,    44,     0,    47,     0,     0,     0,     0,
       0,     0,    62,     0,    18,     0,    25,     0,     0,    56,
      49,     0,     0,    45,    34,     0,     0,    64,     0,     0,
       0,    17,     0,     0,     0,    36,    50,     0,    69,     0,
      63,    67,    68,     0,    28,     0,    46,     0,     0,    22,
       0,     0,    26,     0,    65,    66,    29,     0,    28,     0,
      24,    27,     0,    61,     0,    21,     0,     0,     0,     0,
       0,     0,     0,     0,    32,    13
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -122,  -122,  -122,  -122,  -122,  -122,   164,  -122,  -122,  -122,
     -90,   -54,  -122,    22,  -122,   107,  -122,   -73,  -122,   -37,
     -20,   -53,  -121
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_uint8 yydefgoto[] =
{
       0,     2,     3,     6,    10,    21,    22,    11,    14,    18,
      63,    42,    64,   161,   162,    65,    97,   101,   102,   103,
      49,    55,    56
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      48,    88,    57,    90,    91,   127,    40,   175,    51,   116,
      48,    95,    50,    51,    27,    95,     1,   114,   151,   152,
      52,     5,    60,    61,    53,    52,    44,     4,    82,    53,
       7,   100,    12,    83,    13,    28,    62,   165,    96,   115,
      54,    45,   141,    84,    15,    54,   117,   118,   119,   120,
     121,    16,   105,   106,   107,   108,   109,   110,   111,   112,
     113,   147,     8,     9,   160,    31,    17,    32,    20,    46,
      19,    32,    69,   104,    23,    24,    41,    59,   160,    25,
      26,    29,    58,    33,    34,    35,    36,    33,    34,    35,
      36,    43,    60,    61,   145,   146,    37,    93,    38,    71,
      47,    66,    94,    70,    67,    32,    62,    31,    68,    32,
      39,    92,   157,    69,    39,    85,   173,    86,    87,    89,
     176,    33,    34,    35,    36,    33,    34,    35,    36,    98,
      99,   122,   124,   125,    47,   126,   128,   177,    37,   131,
     130,   180,    72,    73,    74,    75,   129,   132,    39,   133,
     136,   134,    39,   135,    76,   137,   138,   142,    77,    78,
      79,    80,    81,   139,   140,   143,   144,   148,   150,   149,
     153,   154,   155,   156,   158,   159,   163,   164,   166,   178,
     167,   168,   169,   170,   172,   174,   181,   179,   182,    30,
     171,   183,     0,   184,     0,   185,     0,     0,   123
};

static const yytype_int16 yycheck[] =
{
      37,    54,    39,    56,    58,    95,    26,     3,     4,    82,
      47,    10,     3,     4,    15,    10,     6,     3,   139,   140,
      16,     0,    18,    19,    20,    16,     3,     7,    34,    20,
      33,    68,     3,    39,     3,    36,    32,   158,    37,    25,
      36,    18,    37,    49,    36,    36,    83,    84,    85,    86,
      87,    34,    72,    73,    74,    75,    76,    77,    78,    79,
      80,   134,     8,     9,   154,     3,     8,     5,     3,     3,
      10,     5,    34,    35,     3,    12,     3,     3,   168,    38,
      35,    13,    36,    21,    22,    23,    24,    21,    22,    23,
      24,    14,    18,    19,   131,   132,    34,    41,    36,    35,
      34,    34,     3,     3,    34,     5,    32,     3,    39,     5,
      48,    39,   149,    34,    48,    34,   170,    34,    34,    37,
     173,    21,    22,    23,    24,    21,    22,    23,    24,    26,
      35,    37,    40,     3,    34,    33,    39,   174,    34,    38,
      35,   178,    27,    28,    29,    30,    40,    31,    48,    40,
      40,    34,    48,    35,    39,    33,    35,    38,    43,    44,
      45,    46,    47,    35,    35,     3,    40,    33,    33,    49,
       3,    34,     3,    35,    17,    42,    35,    33,     3,    11,
      35,    38,    36,    36,     4,    34,    33,    35,    33,    25,
     168,    37,    -1,    37,    -1,    37,    -1,    -1,    91
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     6,    51,    52,     7,     0,    53,    33,     8,     9,
      54,    57,     3,     3,    58,    36,    34,     8,    59,    10,
       3,    55,    56,     3,    12,    38,    35,    15,    36,    13,
      56,     3,     5,    21,    22,    23,    24,    34,    36,    48,
      70,     3,    61,    14,     3,    18,     3,    34,    69,    70,
       3,     4,    16,    20,    36,    71,    72,    69,    36,     3,
      18,    19,    32,    60,    62,    65,    34,    34,    39,    34,
       3,    35,    27,    28,    29,    30,    39,    43,    44,    45,
      46,    47,    34,    39,    49,    34,    34,    34,    71,    37,
      71,    61,    39,    41,     3,    10,    37,    66,    26,    35,
      69,    67,    68,    69,    35,    70,    70,    70,    70,    70,
      70,    70,    70,    70,     3,    25,    67,    69,    69,    69,
      69,    69,    37,    65,    40,     3,    33,    60,    39,    40,
      35,    38,    31,    40,    34,    35,    40,    33,    35,    35,
      35,    37,    38,     3,    40,    69,    69,    67,    33,    49,
      33,    72,    72,     3,    34,     3,    35,    69,    17,    42,
      60,    63,    64,    35,    33,    72,     3,    35,    38,    36,
      36,    63,     4,    61,    34,     3,    71,    69,    11,    35,
      69,    33,    33,    37,    37,    37
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    50,    51,    52,    52,    53,    53,    54,    54,    55,
      55,    56,    56,    57,    58,    58,    59,    59,    60,    60,
      60,    60,    60,    61,    61,    62,    63,    63,    63,    64,
      65,    65,    66,    67,    67,    68,    68,    69,    69,    69,
      69,    69,    69,    69,    69,    69,    69,    69,    69,    69,
      69,    70,    70,    70,    70,    70,    70,    70,    70,    70,
      71,    71,    72,    72,    72,    72,    72,    72,    72,    72
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     4,     3,     0,     2,     0,     8,     6,     1,
       0,     1,     3,    21,     2,     0,     6,     8,     3,     1,
       1,     1,     6,     2,     0,     3,     1,     3,     0,     2,
       0,     2,    13,     1,     0,     1,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     4,     6,     3,     1,     4,
       5,     1,     1,     1,     1,     1,     5,     4,     2,     3,
       2,     0,     3,     5,     4,     7,     7,     5,     5,     5
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* program: Import MacroDefs MainClass VarClasses  */
#line 94 "P1.y"
                                                    {
                string temp = string((yyvsp[-3].val)) + "\n" + string((yyvsp[-1].val)) + "\n" + string((yyvsp[0].val));
                cout << temp << endl;
            }
#line 1326 "P1.tab.c"
    break;

  case 3: /* Import: IMPORT IMPORT_FUNCT ';'  */
#line 100 "P1.y"
                                     {
                string temp = "import java.util.function.Function;\n";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1335 "P1.tab.c"
    break;

  case 4: /* Import: %empty  */
#line 104 "P1.y"
              { (yyval.val) = strdup(""); }
#line 1341 "P1.tab.c"
    break;

  case 7: /* MacroDef: DEFINE IDENTIFIER '(' Identifier_list_opt ')' '{' statements '}'  */
#line 111 "P1.y"
                                                                               {
                string name = string((yyvsp[-6].val));
                string body = string((yyvsp[-1].val));
                string arg_list = string((yyvsp[-4].val));
                add_macro(name, arg_list, body, 0);
                // cout << "statement mac : " << name << endl;
            }
#line 1353 "P1.tab.c"
    break;

  case 8: /* MacroDef: DEFINE IDENTIFIER '(' Identifier_list_opt ')' primaryExpression  */
#line 118 "P1.y"
                                                                              {
                string name = string((yyvsp[-4].val));
                string body = string((yyvsp[0].val));
                string arg_list = string((yyvsp[-2].val));
                add_macro(name, arg_list, body, 1);
            }
#line 1364 "P1.tab.c"
    break;

  case 9: /* Identifier_list_opt: Identifier_list  */
#line 127 "P1.y"
                              { (yyval.val) = (yyvsp[0].val); }
#line 1370 "P1.tab.c"
    break;

  case 10: /* Identifier_list_opt: %empty  */
#line 128 "P1.y"
                { (yyval.val) = strdup(""); }
#line 1376 "P1.tab.c"
    break;

  case 11: /* Identifier_list: IDENTIFIER  */
#line 132 "P1.y"
                         { (yyval.val) = (yyvsp[0].val); }
#line 1382 "P1.tab.c"
    break;

  case 12: /* Identifier_list: IDENTIFIER ',' Identifier_list  */
#line 133 "P1.y"
                                             {
                string temp = string((yyvsp[-2].val)) + "," + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1391 "P1.tab.c"
    break;

  case 13: /* MainClass: CLASS IDENTIFIER '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' IDENTIFIER ')' '{' PRINT '(' expression ')' ';' '}' '}'  */
#line 143 "P1.y"
                {
                string temp = "class " + string((yyvsp[-19].val)) + "{\n" + 
                    "public static void main (String[] " + string((yyvsp[-9].val)) + ") {\n" +
                    "System.out.println(" + string((yyvsp[-4].val)) + ");\n}\n}" ;
                (yyval.val) = strdup(temp.c_str());
                // cout << "main class parsed successfully..\n";
                // cout << temp << endl;
            }
#line 1404 "P1.tab.c"
    break;

  case 14: /* VarClasses: VarClasses VarClass  */
#line 152 "P1.y"
                                  {
                string temp = string((yyvsp[-1].val)) + "\n" + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1413 "P1.tab.c"
    break;

  case 15: /* VarClasses: %empty  */
#line 156 "P1.y"
              { (yyval.val) = strdup(""); }
#line 1419 "P1.tab.c"
    break;

  case 16: /* VarClass: CLASS IDENTIFIER '{' Var_Decls Method_Decls '}'  */
#line 159 "P1.y"
                                                              {
                string temp = "class " + string((yyvsp[-4].val)) + "{\n" + string((yyvsp[-2].val)) + string((yyvsp[-1].val)) + "\n}" ;
                (yyval.val) = strdup(temp.c_str());
                // cout << "var_class parsed successfully..\n";
                // cout << temp << endl;
            }
#line 1430 "P1.tab.c"
    break;

  case 17: /* VarClass: CLASS IDENTIFIER EXTENDS IDENTIFIER '{' Var_Decls Method_Decls '}'  */
#line 165 "P1.y"
                                                                                 {
                string temp = "class " + string((yyvsp[-6].val)) + " extends " + string((yyvsp[-4].val)) + "{\n" + string((yyvsp[-2].val)) + string((yyvsp[-1].val)) + "\n}" ;
                (yyval.val) = strdup(temp.c_str());
                // cout << "var_class parsed successfully..\n";
                // cout << temp << endl;
            }
#line 1441 "P1.tab.c"
    break;

  case 18: /* Var_Type: INT '[' ']'  */
#line 173 "P1.y"
                          {
                string temp = "int[]";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1450 "P1.tab.c"
    break;

  case 19: /* Var_Type: INT  */
#line 177 "P1.y"
                  { string temp = "int"; (yyval.val) = strdup(temp.c_str()); }
#line 1456 "P1.tab.c"
    break;

  case 20: /* Var_Type: BOOLEAN  */
#line 178 "P1.y"
                      { string temp = "boolean"; (yyval.val) = strdup(temp.c_str()); }
#line 1462 "P1.tab.c"
    break;

  case 21: /* Var_Type: IDENTIFIER  */
#line 179 "P1.y"
                         { (yyval.val) = (yyvsp[0].val); }
#line 1468 "P1.tab.c"
    break;

  case 22: /* Var_Type: FUNCTION '<' IDENTIFIER ',' IDENTIFIER '>'  */
#line 180 "P1.y"
                                                         { 
                string temp = "Function <" + string((yyvsp[-3].val)) + ", " + string((yyvsp[-1].val)) + "> ";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1477 "P1.tab.c"
    break;

  case 23: /* Var_Decls: Var_Decls Var_Decl  */
#line 186 "P1.y"
                                 {
                string temp = string((yyvsp[-1].val)) + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1486 "P1.tab.c"
    break;

  case 24: /* Var_Decls: %empty  */
#line 190 "P1.y"
              { (yyval.val) = strdup(""); }
#line 1492 "P1.tab.c"
    break;

  case 25: /* Var_Decl: Var_Type IDENTIFIER ';'  */
#line 193 "P1.y"
                                      {
                string temp = string((yyvsp[-2].val)) + " " + string((yyvsp[-1].val)) + ";\n";
                (yyval.val) = strdup(temp.c_str()); 
            }
#line 1501 "P1.tab.c"
    break;

  case 26: /* Argument_list: Argument  */
#line 200 "P1.y"
                       { (yyval.val) = (yyvsp[0].val); }
#line 1507 "P1.tab.c"
    break;

  case 27: /* Argument_list: Argument ',' Argument_list  */
#line 201 "P1.y"
                                         {
                string temp = string((yyvsp[-2].val)) + "," + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1516 "P1.tab.c"
    break;

  case 28: /* Argument_list: %empty  */
#line 205 "P1.y"
              { (yyval.val) = strdup(""); }
#line 1522 "P1.tab.c"
    break;

  case 29: /* Argument: Var_Type IDENTIFIER  */
#line 208 "P1.y"
                                  {
                string temp = string((yyvsp[-1].val)) + " " + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1531 "P1.tab.c"
    break;

  case 30: /* Method_Decls: %empty  */
#line 215 "P1.y"
              { (yyval.val) = strdup(""); }
#line 1537 "P1.tab.c"
    break;

  case 31: /* Method_Decls: Method_Decls Method_Decl  */
#line 216 "P1.y"
                                       { 
                string temp = string((yyvsp[-1].val)) + string((yyvsp[0].val)); 
                (yyval.val) = strdup(temp.c_str()); 
            }
#line 1546 "P1.tab.c"
    break;

  case 32: /* Method_Decl: PUBLIC Var_Type IDENTIFIER '(' Argument_list ')' '{' Var_Decls statements RETURN expression ';' '}'  */
#line 223 "P1.y"
                                                                                                                   {
                string temp = "public " + string((yyvsp[-11].val)) + " " + string((yyvsp[-10].val)) + "(" + string((yyvsp[-8].val)) + ") {\n" +
                    string((yyvsp[-5].val)) + "\n" + string((yyvsp[-4].val)) + "\n" + "return " + string((yyvsp[-2].val)) + ";\n}";
                (yyval.val) = strdup(temp.c_str()); 
            }
#line 1556 "P1.tab.c"
    break;

  case 33: /* expressionListOpt: expressionList  */
#line 231 "P1.y"
                             { (yyval.val) = (yyvsp[0].val); }
#line 1562 "P1.tab.c"
    break;

  case 34: /* expressionListOpt: %empty  */
#line 232 "P1.y"
              { (yyval.val) = strdup(""); }
#line 1568 "P1.tab.c"
    break;

  case 35: /* expressionList: expression  */
#line 236 "P1.y"
                         { (yyval.val) = (yyvsp[0].val); }
#line 1574 "P1.tab.c"
    break;

  case 36: /* expressionList: expressionList ',' expression  */
#line 237 "P1.y"
                                            {
                string temp = string((yyvsp[-2].val)) + "," + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1583 "P1.tab.c"
    break;

  case 37: /* expression: primaryExpression AND primaryExpression  */
#line 243 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " && " + string((yyvsp[0].val)); (yyval.val) = strdup(temp.c_str()); }
#line 1589 "P1.tab.c"
    break;

  case 38: /* expression: primaryExpression OR primaryExpression  */
#line 244 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " || " + string((yyvsp[0].val)); (yyval.val) = strdup(temp.c_str()); }
#line 1595 "P1.tab.c"
    break;

  case 39: /* expression: primaryExpression NEQ primaryExpression  */
#line 245 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " != " + string((yyvsp[0].val)); (yyval.val) = strdup(temp.c_str()); }
#line 1601 "P1.tab.c"
    break;

  case 40: /* expression: primaryExpression LEQ primaryExpression  */
#line 246 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " <= " + string((yyvsp[0].val)); (yyval.val) = strdup(temp.c_str()); }
#line 1607 "P1.tab.c"
    break;

  case 41: /* expression: primaryExpression '+' primaryExpression  */
#line 247 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " + " + string((yyvsp[0].val));  (yyval.val) = strdup(temp.c_str()); }
#line 1613 "P1.tab.c"
    break;

  case 42: /* expression: primaryExpression '-' primaryExpression  */
#line 248 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " - " + string((yyvsp[0].val));  (yyval.val) = strdup(temp.c_str()); }
#line 1619 "P1.tab.c"
    break;

  case 43: /* expression: primaryExpression '*' primaryExpression  */
#line 249 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " * " + string((yyvsp[0].val));  (yyval.val) = strdup(temp.c_str()); }
#line 1625 "P1.tab.c"
    break;

  case 44: /* expression: primaryExpression '/' primaryExpression  */
#line 250 "P1.y"
                                                      { string temp = string((yyvsp[-2].val)) + " / " + string((yyvsp[0].val));  (yyval.val) = strdup(temp.c_str()); }
#line 1631 "P1.tab.c"
    break;

  case 45: /* expression: primaryExpression '[' primaryExpression ']'  */
#line 251 "P1.y"
                                                          {
                string temp = string((yyvsp[-3].val)) + "[" + string((yyvsp[-1].val)) + "]";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1640 "P1.tab.c"
    break;

  case 46: /* expression: primaryExpression '.' IDENTIFIER '(' expressionListOpt ')'  */
#line 255 "P1.y"
                                                                         {
                string temp = string((yyvsp[-5].val)) + "." + string((yyvsp[-3].val)) + "(" + string((yyvsp[-1].val)) + ")";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1649 "P1.tab.c"
    break;

  case 47: /* expression: primaryExpression '.' LENGTH  */
#line 259 "P1.y"
                                           {
                string temp = string((yyvsp[-2].val)) + ".length";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1658 "P1.tab.c"
    break;

  case 48: /* expression: primaryExpression  */
#line 263 "P1.y"
                                { (yyval.val) = (yyvsp[0].val); }
#line 1664 "P1.tab.c"
    break;

  case 49: /* expression: IDENTIFIER '(' expressionListOpt ')'  */
#line 264 "P1.y"
                                                   {
                string macro_name = string((yyvsp[-3].val));
                vector<string> arg_values = parse_args(string((yyvsp[-1].val)));
                auto it = macro_table.find(macro_name);
                if (it != macro_table.end()) {
                    Macro m = it->second;
                    if(!m.isExprMac) yyerror("isnotExprMac");
                    if(m.args.size() != arg_values.size()) yyerror("notsameargs");
                    string body = expand_macro(m, arg_values, 1);
                    (yyval.val) = strdup(body.c_str());
                } else {
                    string temp = macro_name + "(" + string((yyvsp[-1].val)) + ")";
                    (yyval.val) = strdup(temp.c_str());
                }
            }
#line 1684 "P1.tab.c"
    break;

  case 50: /* expression: '(' IDENTIFIER ')' SPO expression  */
#line 279 "P1.y"
                                                {
                string temp = "(" + string((yyvsp[-3].val)) + ")->" + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str()); 
            }
#line 1693 "P1.tab.c"
    break;

  case 51: /* primaryExpression: NUM  */
#line 286 "P1.y"
                  { (yyval.val) = (yyvsp[0].val); }
#line 1699 "P1.tab.c"
    break;

  case 52: /* primaryExpression: TRUE  */
#line 287 "P1.y"
                   { string temp = "true"; (yyval.val) = strdup(temp.c_str()); }
#line 1705 "P1.tab.c"
    break;

  case 53: /* primaryExpression: FALSE  */
#line 288 "P1.y"
                    { string temp = "false"; (yyval.val) = strdup(temp.c_str()); }
#line 1711 "P1.tab.c"
    break;

  case 54: /* primaryExpression: IDENTIFIER  */
#line 289 "P1.y"
                         { (yyval.val) = (yyvsp[0].val); }
#line 1717 "P1.tab.c"
    break;

  case 55: /* primaryExpression: THIS  */
#line 290 "P1.y"
                   { string temp = "this"; (yyval.val) = strdup(temp.c_str()); }
#line 1723 "P1.tab.c"
    break;

  case 56: /* primaryExpression: NEW INT '[' expression ']'  */
#line 291 "P1.y"
                                         {
                string temp = "new int[" + string((yyvsp[-1].val)) + "]";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1732 "P1.tab.c"
    break;

  case 57: /* primaryExpression: NEW IDENTIFIER '(' ')'  */
#line 295 "P1.y"
                                     {
                string temp = "new " + string((yyvsp[-2].val)) + "()";
                (yyval.val) = strdup(temp.c_str());  
            }
#line 1741 "P1.tab.c"
    break;

  case 58: /* primaryExpression: '!' expression  */
#line 299 "P1.y"
                             {
                string temp = "!" + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1750 "P1.tab.c"
    break;

  case 59: /* primaryExpression: '(' expression ')'  */
#line 303 "P1.y"
                                 {
                string temp = "(" + string((yyvsp[-1].val)) + ")";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1759 "P1.tab.c"
    break;

  case 60: /* statements: statement statements  */
#line 309 "P1.y"
                                   {
                string combined = string((yyvsp[-1].val)) + string((yyvsp[0].val));
                (yyval.val) = strdup(combined.c_str());
            }
#line 1768 "P1.tab.c"
    break;

  case 61: /* statements: %empty  */
#line 313 "P1.y"
              { (yyval.val) = strdup(""); }
#line 1774 "P1.tab.c"
    break;

  case 62: /* statement: '{' statements '}'  */
#line 316 "P1.y"
                                 {
                string temp = "{\n" + string((yyvsp[-1].val)) + "}\n";
                (yyval.val) = strdup(temp.c_str());
                // cout << temp << endl;
            }
#line 1784 "P1.tab.c"
    break;

  case 63: /* statement: PRINT '(' expression ')' ';'  */
#line 321 "P1.y"
                                           {
                string temp = "System.out.println(" + string((yyvsp[-2].val)) + ");\n";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1793 "P1.tab.c"
    break;

  case 64: /* statement: IDENTIFIER '=' expression ';'  */
#line 325 "P1.y"
                                            {
                string temp = string((yyvsp[-3].val)) + " = " + string((yyvsp[-1].val)) + ";\n";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1802 "P1.tab.c"
    break;

  case 65: /* statement: IDENTIFIER '[' expression ']' '=' expression ';'  */
#line 329 "P1.y"
                                                               {
                string temp = string((yyvsp[-6].val)) + "[" + string((yyvsp[-4].val)) + "] = " + string((yyvsp[-1].val)) + ";\n";
                (yyval.val) = strdup(temp.c_str());
            }
#line 1811 "P1.tab.c"
    break;

  case 66: /* statement: IF '(' expression ')' statement ELSE statement  */
#line 333 "P1.y"
                                                             {
                string temp = "if (" + string((yyvsp[-4].val)) + ") \n" + string((yyvsp[-2].val)) + "else " + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1820 "P1.tab.c"
    break;

  case 67: /* statement: IF '(' expression ')' statement  */
#line 337 "P1.y"
                                              {
                string temp = "if (" + string((yyvsp[-2].val)) + ") " + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1829 "P1.tab.c"
    break;

  case 68: /* statement: WHILE '(' expression ')' statement  */
#line 341 "P1.y"
                                                 {
                string temp = "while (" + string((yyvsp[-2].val)) + ") " + string((yyvsp[0].val));
                (yyval.val) = strdup(temp.c_str());
            }
#line 1838 "P1.tab.c"
    break;

  case 69: /* statement: IDENTIFIER '(' expressionListOpt ')' ';'  */
#line 345 "P1.y"
                                                       {
                string macro_name = string((yyvsp[-4].val));
                vector<string> arg_values = parse_args(string((yyvsp[-2].val)));
                auto it = macro_table.find(macro_name);
                if (it != macro_table.end()) {
                    // cout << "macname : " << m.name << endl;
                    // cout << "isExprMac : " << m.isExprMac << endl; 
                    if((it->second).isExprMac) yyerror("isExprMac Should be StatMac");
                    string body = expand_macro(it->second, arg_values, 0);
                    (yyval.val) = strdup(body.c_str());
                } else {
                    string temp = macro_name + "(" + string((yyvsp[-2].val)) + ")";
                    (yyval.val) = strdup(temp.c_str());
                }
            }
#line 1858 "P1.tab.c"
    break;


#line 1862 "P1.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 362 "P1.y"


void yyerror(const char *s) {
    /* cout << "line :" << lc << " error" << endl; */
    cout << "// Failed to parse macrojava code." << endl;
    /* cout << string(s) << endl; */
    exit(1);
}

int main() {
    return yyparse();
}
