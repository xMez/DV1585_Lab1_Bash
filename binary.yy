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
%token <std::string> LINE
%token <std::string> NL
%type <std::string> text
%type <std::string> text_list
%token END 0 "end of file"
%%
text_list : text
	  | text_list text

text :
     | LINE		{ total = $1[0]; std::cout << "FOUND LINE" << std::endl; }
     | NL	     	{ total = $1[0]; std::cout << "FOUND NEW LINE" << std::endl; }
     ;
