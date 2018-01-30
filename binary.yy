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
%token <std::string> VAR
%token <std::string> QUOTE
%token <std::string> SEMI
%token <std::string> PIPE
%token <std::string> BLANK
%token <std::string> NL
%type <std::string> text
%type <std::string> text_list
%token END 0 "end of file"
%%
text_list : text
	  | text_list text
          ;

text :
     | LINE		{ std::cout << "Text ->" << $1 << "<-" << std::endl; }
     | VAR		{ std::cout << "Var ->" << $1 << "<-" << std::endl; }
     | QUOTE		{ std::cout << "Quoted ->" << $1 << "<-" << std::endl; }
     | SEMI		{ std::cout << "Semi" << std::endl; }
     | PIPE		{ std::cout << "Pipe" << std::endl; }
     | BLANK		{ std::cout << "Blank " << $1.length() << " chars" << std::endl; }
     | NL	     	{ std::cout << "NL" << std::endl; }
     ;
