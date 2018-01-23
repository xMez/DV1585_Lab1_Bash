%skeleton "lalr1.cc" 
%defines
%define api.value.type variant
%define api.token.constructor
%code{
  unsigned int total = 0;
  #include <string>
  #define YY_DECL yy::parser::symbol_type yylex()
  YY_DECL;
}
%token <std::string> BIT
%token <std::string> HEX
%type <std::string> number
%token END 0 "end of file"
%%
number : BIT         	{                   total += $1[0]-'0'; }
       | HEX		{ 		    total += $1[0]-'7'; }
       | number HEX	{ total = total<<4; total += $2[0]-'7'; }
       | number BIT     { total = total<<4; total += $2[0]-'0'; }
       ;
