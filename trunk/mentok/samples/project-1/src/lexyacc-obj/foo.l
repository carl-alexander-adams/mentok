%{
    /* My toy lexer */
#include <bar.tab.h>

    extern int yylval;

%}

%s STATE1 STATE2

%%

[0-9]+ { yylval = atoi(yytext)  ; return NUMBER ;} /* an int */
[ \t] {;} /* ignore whitespace */
\n {return 0;} /* treat EOL as EOF */
. {return yytext[0];} /* return unmatched single chars */

%%

void yyerror(char *s) {
  /* hush compiler warnings */
  (void) s;
  fprintf(stderr, "yyerror: '%s'\n", yytext);
/*
  fprintf(stderr, "exiting due to error.\n\n");
  exit(1);
*/
}


