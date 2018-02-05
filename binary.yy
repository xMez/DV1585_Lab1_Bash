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
%token <std::string> EQUAL
%token <std::string> NL
%type <Node> stream
%type <Node> optline
%type <Node> line
%type <Node> pipeline
%type <Node> command
%type <Node> concatenate
%type <Node> equals
%type <Node> units
%type <Node> unit
%token END 0 "end of file"
%%

stream
	: optline		{ $$ = Node("stream", "");
				  $$.children.push_back($1);
				  root = $$;
				}
	| stream NL optline	{ $$ = $1;
				  $$.children.push_back($3);
				  root = $$;
				}
	;

optline
	: /*empty*/		{ $$ = Node("optline", "empty"); }
	| line			{ $$ = Node("optline", "has line");
				  $$.children.push_back($1);
				}
	;

line
	: pipeline		{ $$ = $1; }
	| line SEMI pipeline	{ $$ = Node("line", "");
				  $$.children.push_back($1);
				  $$.children.push_back($3);
				}
	;

pipeline
	: equals		{ $$ = $1; }
	| pipeline PIPE equals	{ $$ = Node("pipeline", "");
				  $$.children.push_back($1);
				  $$.children.push_back($3);
				}
	;

equals
	: command		{ $$ = $1; }
	| WORD EQUAL concatenate BLANK equals
				{ $$ = Node("equals", ""); 
				  $$.children.push_back(Node("WORD", $1));
				  $$.children.push_back($3);
				  $$.children.push_back($5);
				}
	;

command
	: concatenate 		{ $$ = Node("command", "");
				  $$.children.push_back($1);
				}
	| command BLANK concatenate 
				{ $$ = $1; 
				  $$.children.push_back($3);
				}
	| '<' '(' stream ')' BLANK	
				{ $$ = $3; }
	;

concatenate
	: unit			{ $$ = $1; }
	| units			{ $$ = $1; }
	;

units
	: unit unit		{ $$ = Node("concatenate", "");
				  $$.children.push_back($1);
				  $$.children.push_back($2);
				}
	| units unit 		{ $$ = $1; 
				  $$.children.push_back($2);
				}
	;

unit
	: WORD			{ $$ = Node("WORD", $1); }
	| VAR			{ $$ = Node("VAREXP", $1); }
	| QUOTE			{ $$ = Node("QUOTED", $1); }
	| EQUAL			{ $$ = Node("EQUAL", $1); }
	;
