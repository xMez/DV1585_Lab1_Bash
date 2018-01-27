%top{
#include "binary.tab.hh"
#define YY_DECL yy::parser::symbol_type yylex()
}
%option noyywrap nounput batch noinput
%%
(\\[^\n]|[^\\\n;|\t ])*	{ return yy::parser::make_LINE(yytext); }
[;]			{ return yy::parser::make_SEMI(yytext); }
[|]			{ return yy::parser::make_PIPE(yytext); }
[\t ]*			{ return yy::parser::make_BLANK(yytext); }
[\n]*			{ return yy::parser::make_NL(yytext); }
<<EOF>>			return yy::parser::make_END();
%%
