%{
    /* My toy yacc parser */
    extern void yyerror(char *msg, ...);
%}

%token LVAL NUMBER

%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

%%
statement:  LVAL '=' expression
        | expression {printf("= %d\n",$1);}
        ;
expression: expression '+' expression { $$ = $1 + $3 ;}
        | expression '-' expression { $$ = $1 - $3 ;}
        | expression '*' expression { $$ = $1 * $3 ;}
        | expression '/' expression {
	    if ($3 == 0) {
		yyerror("Divide by zero (Bad.. Mkay\n");
	    }
	    else {
		$$ = $1 / $3 ;
	    }
	}
        | '-' expression %prec UMINUS {$$ = -$2;}
        | '(' expression ')' {$$ = $2;}
        | NUMBER {$$ = $1 ;}
        ;
%%

