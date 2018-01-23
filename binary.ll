%top{
#include "binary.tab.hh"
#define YY_DECL yy::parser::symbol_type yylex()
}
%option noyywrap nounput batch noinput
%%
^\n*		{ std::cout << "Line:" += yytext += "\n"; }
\n*		{ std::cout << "NL:" += yytext; }
<<EOF>>		return yy::parser::make_END();
%%
