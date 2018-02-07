%top{
#include "binary.tab.hh"
#define YY_DECL yy::parser::symbol_type yylex()
}
%option noyywrap nounput batch noinput
%%
(\\.|[^\\\n$;|'=<()\t ])+		{ return yy::parser::make_WORD(yytext); }
(\$[a-zA-Z]+)				{ return yy::parser::make_VAR(yytext); }
('[^\n']+')				{ return yy::parser::make_QUOTE(yytext); }
[;]					{ return yy::parser::make_SEMI(yytext); }
[|]					{ return yy::parser::make_PIPE(yytext); }
[\t ]+					{ return yy::parser::make_BLANK(yytext); }
[=]					{ return yy::parser::make_EQUAL(yytext); }
[<][(]					{ return yy::parser::make_SUBSTART(yytext); }
[)]					{ return yy::parser::make_SUBEND(yytext); }
[\n]					{ return yy::parser::make_NL(yytext); }
<<EOF>>					return yy::parser::make_END();
%%
