%skeleton "lalr1.cc" 
%defines
%define api.value.type variant
%define api.token.constructor
%code{
  #include <string>
  std::string output;
  #define YY_DECL yy::parser::symbol_type yylex()
  YY_DECL;
}
%token <std::string> LINE
%token <std::string> NL
%type <std::string> text
%token END 0 "end of file"
%%
text : 
     | LINE	{ std::cout << "Line:" << $1[0] << "\n"; }
     | NL	{ std::cout << "NL:" << $1[0]; }
     ;
