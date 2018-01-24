%top{
#include "binary.tab.hh"
#define YY_DECL yy::parser::symbol_type yylex()
}
%option noyywrap nounput batch noinput
%%
[^\n]*		{ return yy::parser::make_LINE(yytext); }
[\n]*		{ return yy::parser::make_NL(yytext); }
<<EOF>>		return yy::parser::make_END();
%%
