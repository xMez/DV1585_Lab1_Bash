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
%token <std::string> SPACE
%type <std::string> number
%token END 0 "end of file"
%%
numbers : number	       { std::cout << total << " "; }
        | numbers SPACE number { std::cout << total << " "; }

number : BIT         	{ 		    total = $1[0]-'0'; }
       | number BIT     { total = total<<1; total += $2[0]-'0'; }
       ;
