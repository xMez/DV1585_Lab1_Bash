%skeleton "lalr1.cc" 
%defines
%define api.value.type variant
%define api.token.constructor
%code requires{
  #include "node.hh"
}
%code{
  unsigned int total = 0;
  #include <string>
  #define YY_DECL yy::parser::symbol_type yylex()
  YY_DECL;
  Node root;
}
%token <std::string> WORD
%token <std::string> VAR
%token <std::string> QUOTE
%token <std::string> SEMI
%token <std::string> PIPE
%token <std::string> BLANK
%token <std::string> NL
%type <Node> stream
%type <Node> optline
%type <Node> line
%type <Node> anything 
%token END 0 "end of file"
%%

stream
	: optline		{ $$ = Node("stream", "");
				  $$.children.push_back($1);
				  root = $$;
				}
	| stream NL optline	{ $$ = $1;
				  $$.children.push_back($3);
				}
	;

optline
	: /*empty*/		{ $$ = Node("optline", "empty"); }
	| line			{ $$ = Node("optline", "has line");
				  $$.children.push_back($1);
				}
	;

line
	: anything		{ $$ = $1; }
	| line anything		{ $$ = Node("line", ""); 
				  $$.children.push_back($1);
				  $$.children.push_back($2);
				}
	;

anything
	: WORD			{ $$ = Node("WORD", $1); }
	| VAR			{ $$ = Node("VAR", $1); }
	| QUOTE			{ $$ = Node("QUOTE", $1); }
	| SEMI			{ $$ = Node("SEMI", $1);  }
	| PIPE			{ $$ = Node("PIPE", $1); }
	| BLANK			{ $$ = Node("BLANK", $1); }
	| NL	     		{  }
	;
