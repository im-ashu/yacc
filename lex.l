%{
#include"y.tab.h"
#include<stdio.h>
#include<stdlib.h>
extern int yylval;
int lineno;
%}
aplha       [a-zA-Z]
digit       [0-9]
chartext    ([^'])|(\\.)
stringtext  ([^"])|(\\.)
%%
"\n"                        {   ++lineno;               }
[\t ]+                      {  /* Ignore whitespace. */ }
\/\/.*                      {  /* Ignore comment. */    }
\/\*(.*\n)*.*\*\/           {  /* Ignore comment. */    }

"{"                         {   return '{';             }
"}"                         {   return '}';             }
"["                         {   return '[';             }
"]"                         {   return ']';             }
"("                         {   return '(';             }
")"                         {   return ')';             }
";"                         {   return ';';             }
":"                         {   return ':';             }
"?"                         {   return '?';             }
"::"                        {   return COLONCOLON;      }
"."                         {   return '.';             }
".*"                        {   return DOTSTAR;         }
"+"                         {   return '+';             }
"-"                         {   return '-';             }
"*"                         {   return '*';             }
"/"                         {   return '/';             }
"%"                         {   return '%';             }
"^"                         {   return '^';             }
"&"                         {   return '&';             }
"|"                         {   return '|';             }
"~"                         {   return '~';             }
"!"                         {   return '!';             }
"="                         {   return '=';             }
"<"                         {   return '<';             }
">"                         {   return '>';             }
"+="                        {   return ADDEQ;           }
"-="                        {   return SUBEQ;           }
"*="                        {   return MULEQ;           }
"/="                        {   return DIVEQ;           }
"%="                        {   return MODEQ;           }
"^="                        {   return XOREQ;           }
"&="                        {   return ANDEQ;           }
"|="                        {   return OREQ;            }
"<<"                        {   return SL;              }
">>"                        {   return SR;              }
"<<="                       {   return SLEQ;            }
">>="                       {   return SREQ;            }
"=="                        {   return EQ;              }
"!="                        {   return NOTEQ;           }
"<="                        {   return LTEQ;            }
">="                        {   return GTEQ;            }
"&&"                        {   return ANDAND;          }
"||"                        {   return OROR;            }
"++"                        {   return PLUSPLUS;        }
"--"                        {   return MINUSMINUS;      }
","                         {   return ',';             }
"->*"                       {   return ARROWSTAR;       }
"->"                        {   return ARROW;           }

"asm"                       {   return ASM;             }
"auto"                      {   return AUTO;            }
"bool"                      {   return BOOL;            }
"break"                     {   return BREAK;           }
"case"                      {   return CASE;            }
"catch"                     {   return CATCH;           }
"char"                      {   return CHAR;            }
"class"                     {   return CLASS;           }
"compl"                     {   return COMPL;           }
"const"                     {   return CONST;           }
"const_cast"                {   return CONST_CAST       }
"continue"                  {   return CONTINUE;        }
"default"                   {   return DEFAULT;         }
"delete"                    {   return DELETE;          }
"do"                        {   return DO;              }
"double"                    {   return DOUBLE;          }
"dynamic_cast"              {   return DYNAMIC_CAST;    }
"else"                      {   return ELSE;            }
"enum"                      {   return ENUM;            }
"explicit"                  {   return EXPLICIT;        }
"export"                    {   return EXPORT;          }
"extern"                    {   return EXTERN;          }
"false"                     {   return FALSE;           }
"float"                     {   return FLOAT;           }
"for"                       {   return FOR;             }
"friend"                    {   return FRIEND;          }
"goto"                      {   return GOTO;            }
"if"                        {   return IF;              }
"inline"                    {   return INLINE;          }
"int"                       {   return INT;             }
"long"                      {   return LONG;            }
"mutable"                   {   return MUTABLE;         }
"namespace"                 {   return NAMESPACE;       }
"new"                       {   return NEW;             }
"operator"                  {   return OPERATOR;        }
"private"                   {   return PRIVATE;         }
"protected"                 {   return PROTECTED;       }
"public"                    {   return PUBLIC;          }
"register"                  {   return REGISTER;        }
"reinterpret_cast"          {   return REINTERPRET_CAST;}
"return"                    {   return RETURN;          }
"short"                     {   return SHORT;           }
"signed"                    {   return SIGNED;          }
"sizeof"                    {   return SIZEOF;          }
"static"                    {   return STATIC;          }
"static_cast"               {   return STATIC_CAST;     }
"struct"                    {   return STRUCT;          }
"switch"                    {   return SWITCH;          }
"template"                  {   return TEMPLATE;        }
"this"                      {   return THIS;            }
"throw"                     {   return THROW;           }
"true"                      {   return TRUE;            }
"try"                       {   return TRY;             }
"typedef"                   {   return TYPEDEF;         }
"typeid"                    {   return TYPEID;          }
"typename"                  {   return TYPENAME;        }
"union"                     {   return UNION;           }
"unsigned"                  {   return UNSIGNED;        }
"using"                     {   return USING;           }
"virtual"                   {   return VIRTUAL;         }
"void"                      {   return VOID;            }
"volatile"                  {   return VOLATILE;        }
"wchar_t"                   {   return WCHAR_T;         }
"while"                     {   return WHILE;           }

{alpha}({alpha}|{digit})*   {   return check_identifier(yytext);}
({digit}*\.{digit}+)        {   return FLOATING;        }
{digit}+                    {   return INTEGER;         }
"'"{chartext}*"'"           {   return CHARACTER;       }
"L'"{chartext}*"'"          {   return CHARACTER;       }
"\""{stringtext}*"\""       {   return STRING;          }
"L\""{stringtext}*"\""      {   return STRING;          }

.   { fprintf(stderr, "%d: unexpected character `%c'\n", lineno, yytext[0]); }

%%

static int yywrap(void)
{
    return 1;
}

static int check_identifier(const char *s)
{
    switch (s[0]) {
    case 'N': return NAMESPACE_NAME;
    case 'C': return CLASS_NAME;
    case 'E': return ENUM_NAME;
    case 'T': return TEMPLATE_NAME;
    }
    return IDENTIFIER;
}
