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
  Root root;
}
%token <std::string> WORD
%token <std::string> VAR
%token <std::string> QUOTE
%token <std::string> SEMI
%token <std::string> PIPE
%token <std::string> BLANK
%token <std::string> EQUAL
%token <std::string> SUBSTART
%token <std::string> SUBEND
%token <std::string> NL
%type <Node> stream
%type <Node> optline
%type <Node> line
%type <Node> pipeline
%type <Node> optspace
%type <Node> optspaceex
%type <Node> command
%type <Node> concatenate
%type <Node> equals
%type <Node> units
%type <Node> unit
%token END 0 "end of file"
%%

stream
	: optline		{ $$ = Stream("stream", "");
				  $$.children.push_back($1);
				  root = $$;
				}
	| stream NL optline	{ $$ = $1;
				  $$.children.push_back($3);
				  root = $$;
				}
	;

optline
	: /*empty*/		{ $$ = Optline("optline", "empty"); }
	| line			{ $$ = Optline("optline", "has line");
				  $$.children.push_back($1);
				}
	;

line
	: pipeline		{ $$ = $1; }
	| line SEMI pipeline	{ $$ = Line("line", "");
				  $$.children.push_back($1);
				  $$.children.push_back($3);
				}
	;

pipeline
	: optspaceex		{ $$ = $1; }
	| pipeline PIPE optspaceex
				{ $$ = Pipe("pipeline", "");
				  $$.children.push_back($1);
				  $$.children.push_back($3);
				}
	;

optspace
	: /*empty*/ 	
	| BLANK
	;

optspaceex
	: optspace equals optspace
				{ $$ = $2; }
	;

equals
	: command		{ $$ = $1; }
	| WORD EQUAL concatenate BLANK equals
				{ $$ = Equals("equals", ""); 
				  $$.children.push_back(WordChar("WORD", $1));
				  $$.children.push_back($3);
				  $$.children.push_back($5);
				}
	;

command
	: concatenate
				{ $$ = Command("command", "");
				  $$.children.push_back($1);
				}
	| command BLANK concatenate
				{ $$ = $1; 
				  $$.children.push_back($3);
				}
	;

concatenate
	: unit			{ $$ = $1; }
	| units			{ $$ = $1; }
	;

units
	: unit unit		{ $$ = Concat("concatenate", "");
				  $$.children.push_back($1);
				  $$.children.push_back($2);
				}
	| units unit 		{ $$ = $1; 
				  $$.children.push_back($2);
				}
	;

unit
	: WORD			{ $$ = WordChar("WORD", $1); }
	| VAR			{ $$ = VarChar("VAREXP", $1); }
	| QUOTE			{ $$ = QuotedChar("QUOTED", $1); }
	| EQUAL			{ $$ = EqualChar("EQUAL", $1); }
	| SUBSTART stream SUBEND
				{ $$ = Subshell("SUBSHELL", ""); 
				  $$.children.push_back($2);
				}
	;
