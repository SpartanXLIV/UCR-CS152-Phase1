   /* cs152-miniL phase1 */
%{
/* write your C code here for definitions of variables and including headers */
        int currLine = 1, currPos = 1;
%}

 /* some common rules */

DIGIT   [0-9]
                                /*if he hears he'll knock all day*/
COMMENT ##.*



%%

   /* specific lexer rules in regex */
        /* who can it be knocking at my door*/

"-"             {printf("SUB\n"); currPos += yyleng;}
"+"             {printf("ADD\n"); currPos += yyleng;}
"*"             {printf("MULT\n"); currPos += yyleng;}
"/"             {printf("DIV\n"); currPos += yyleng;}
"="             {printf("EQUAL\n"); currPos += yyleng;}
"("             {printf("L_PAREN\n"); currPos += yyleng;}
")"             {printf("R_PAREN\n"); currPos += yyleng;}
"_"             {printf("UNDER_SCORE\n"); currPos += yyleng;}
"%"             {printf("MOD\n"); currPos += yyleng;}

        /* I've done no harm I keep to myself*/

"function"      {printf("FUNCTION\n"); currPos += yyleng;}
"beginparams"   {printf("BEGIN_PARAMS\n"); currPos += yyleng;}
"endparams"     {printf("END_PARAMS\n"); currPos += yyleng;}
"beginlocals"   {printf("BEGIN_LOCALS\n"); currPos += yyleng;}
"endlocals"     {printf("END_LOCALS\n"); currPos += yyleng;}
"beginbody"     {printf("BEGIN_BODY\n"); currPos += yyleng;}
"endbody"       {printf("END_BODY\n"); currPos += yyleng;}
"integer"       {printf("INTEGER\n"); currPos += yyleng;}
"array"         {printf("ARRAY\n"); currPos += yyleng;}
"enum"          {printf("ENUM\n"); currPos += yyleng;}
"of"            {printf("OF\n"); currPos += yyleng;}
"if"            {printf("IF\n"); currPos += yyleng;}
"then"          {printf("THEN\n"); currPos += yyleng;}
"endif"         {printf("ENDIF\n"); currPos += yyleng;}
"else"          {printf("ELSE\n"); currPos += yyleng;}
"for"           {printf("FOR\n"); currPos += yyleng;}
"while"         {printf("WHILE\n"); currPos += yyleng;}
"do"            {printf("DO\n"); currPos += yyleng;}
"beginloop"     {printf("BEGINLOOP\n"); currPos += yyleng;}
"endloop"       {printf("ENDLOOP\n"); currPos += yyleng;}
"continue"      {printf("CONTINUE\n"); currPos += yyleng;}
"read"          {printf("READ\n"); currPos += yyleng;}
"write"         {printf("WRITE\n"); currPos += yyleng;}
"and"           {printf("AND\n"); currPos += yyleng;}
"or"            {printf("OR\n"); currPos += yyleng;}
"not"           {printf("NOT\n"); currPos += yyleng;}
"true"          {printf("TRUE\n"); currPos += yyleng;}
"false"         {printf("FALSE\n"); currPos += yyleng;}
"return"        {printf("RETURN\n"); currPos += yyleng;}

        /* I like it here with my childhood friend*/

"=="            {printf("EQ\n"); currPos += yyleng;}
"<>"            {printf("NEQ\n"); currPos += yyleng;}
"<"             {printf("LT\n"); currPos += yyleng;}
">"             {printf("GT\n"); currPos += yyleng;}
"<="            {printf("LTE\n"); currPos += yyleng;}
">="            {printf("GTE\n"); currPos += yyleng;}

        /* Nothing wrong with my state of mental health*/

";"             {printf("SEMICOLON\n"); currPos += yyleng;}
":"             {printf("COLON\n"); currPos += yyleng;}
","             {printf("COMMA\n"); currPos += yyleng;}
"["             {printf("L_SQUARE_BRACKET\n"); currPos += yyleng;}
"]"             {printf("R_SQUARE_BRACKET\n"); currPos += yyleng;}
":="            {printf("ASSIGN\n"); currPos += yyleng;}

        /* make no sound, tip-toe across the floor*/

(\.{DIGIT}+)|({DIGIT}+(\.{DIGIT}*)?([eE][+-]?[0-9]+)?)        {printf("NUMBER %s\n", yytext); currPos += yyleng;}

[ \t]+          {/* ignore spaces */ currPos += yyleng;}

        /* I'll be trapped and here I'll have to stay */

{COMMENT}      	{currLine++; currPos = 1;}


[a-zA-Z]([a-zA-Z0-9_]*[a-zA-Z0-9])*         {printf("IDENT %s\n", yytext); currPos += yyleng;}

[0-9_][a-zA-Z0-9_]*		{printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPos, yytext); exit(0);}

[a-zA-Z][a-zA-Z0-9_]*[_]	{printf("Error at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", currLine, currPos, yytext); exit(0);}

        /* Here they come, THOSE FEELINGS AGAIN*/

"\n"            {currLine++; currPos = 1;}

.               {printf("Error at line %d, column %d: unrecognized symbol \"%s\" \n", currLine, currPos, yytext); exit(0);}

%%

        /* C functions used in lexer */

int main(int argc, char ** argv)
{
        if(argc >= 2)
        {
                yyin = fopen(argv[1], "r");
                if(yyin == NULL)
                {
                        yyin = stdin; //take input directly from terminal run line (text file)
                }
        }
        else
        {
                yyin = stdin;
        }
        yylex();        //who can it be now?

}
