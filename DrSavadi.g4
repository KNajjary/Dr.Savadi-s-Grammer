grammar DrSavadi ;

programm
        :
        importRule*
        ( classDefinitionRule
        | funcRule
        )*
        ;


//-------------------------------------------------------------

statement
            : declRule
            | funcRule
            | whileRule
            | forInRule
            | forInRangeRule
            | declArrey
            | switchCaseRule
            | ifRule
            | classDefinitionRule
            | exeptionRule
            | fileRule
            | binaryOperatorEXpretion
            | unaryOperatorEXpretion
            | assignRule
            | returnRule
            | printRule
            ;
//-------------------------------------------------------------------
declRule:
         (INTKeyword param '=' intValue ';!:')
         | (CHARKeyword  param'=' charValue ';!:')
         | (STRINGKeyword param '=' stringValue ';!:')
         | (BOOLKeyword param '=' boolValue ';!:')
         ;

param : NAME ;
intValue: INT;
charValue : CHAR ;
stringValue : STRING;
boolValue : TRUE | FALSE;

//--------------------------------------------------------------------
assignRule:
         ( param '=' intValue ':!;')
         | ( param'=' charValue ':!;')
         | ( param '=' stringValue ':!;')
         |( param '='  (INT|NAME|CHAR|STRING) '+' (INT|NAME|CHAR|STRING) ';!:' )
         | ( param '=' (INT|NAME|CHAR|STRING) '-' (INT|NAME|CHAR|STRING) ';!:')
         | ( param '=' (INT|NAME) '*'  (INT|NAME) ';!:')
         |(  param '=' (INT|NAME) '/' (INT|NAME) ';!:')
         | ( param '=' (INT|NAME) '%'  (INT|NAME) ';!:')
         | ( param '=' (INT|NAME) 'or' (INT|NAME) ';!:')
         | ( param '=' (INT|NAME) 'and' (INT|NAME) ';!:')
         | ( param '=''**'NAME ';!:' )
         | ( param '=' NAME'++' ';!:' )
         | ( param '=' '++' NAME ';!:' )
         | ( param '=''--' NAME ';!:' )
         | ( param '='NAME '--' ';!:' )

         ;

//--------------------------------------------------------------------

importRule
           : ( myImport '!' LIB '!' ';!:')
           |( from '!' LIB '!' myImport NAME ';!:' )
           ;
myImport : IMPORT ;
from : FROM;//'from'
FROM : [Ff][Rr][Oo][Mm];
IMPORT : [Ii][Mm][Pp][Oo][Rr][Tt];

//-------------------------------------------------------------------------
funcRule:
          funcType?  FUN NAME type '!' NAME (',' NAME)? '!' ':{'
          statement*
          //RETURN (type  NAME)?  ';!:'
          returnRule
           '}:'
           ;
//fun: FUN;
type: INTKeyword | CHARKeyword | BOOLKeyword | STRINGKeyword ;
//return: RETURN;
RETURN : [Rr][Ee][Tt][Uu][Rr][Nn];
FUN : [Ff][Uu][Nn];
/*statement : NAME '=' INT ';!:'
          | NAME '=' CHAR ';!:'
          | NAME '=' STRING ';!:';*/

funcType : PUBLIC |PRIVATE|PROTECTED;
PUBLIC : [Pp][Uu][Bb][Ll][Ii][Cc];
PRIVATE : [Pp][Rr][Ii][Vv][Aa][Tt][Ee];
PROTECTED : [Pp][Rr][Oo][Tt][Ee][Cc][Tt][Ee][Dd];
//--------------------------------------------------------------------
whileRule: //works
           WHILE '!' condition '!'':{'
           statement+
           '}:' ;
forInRule:
           FOR NAME IN NAME ':{'
           statement+
           '}:';

forInRangeRule :
                 FOR NAME IN RANGE '!'INT','NAME'!' ':{'
                 statement+
                 '}:';
WHILE : [Ww][hH][Ii][Ll][Ee];
FOR : [Ff][Oo][Rr];
IN : [Ii][Nn];
RANGE : [Rr][Aa][Nn][Gg][Ee];
value : CHAR|INT|STRING;
condition
           :  TRUE
           |  FALSE
           | NAME '==' TRUE
           | NAME '==' FALSE
           | (INT|NAME) '==' (INT|NAME)
           |  (INT|NAME) '!=' (INT|NAME)
           |  (INT|NAME) '<=' (INT|NAME)
           |  (INT|NAME) '>=' (INT|NAME)
           |  (INT|NAME) '<' (INT|NAME)
           |  (INT|NAME) '>' (INT|NAME)

           ;

//fragment
 TRUE : [Tt][Rr][Uu][Ee] ;//| ~[0];
//fragment
 FALSE : [Ff][Aa][Ll][Ss][Ee];// | [0];
//---------------------------------------------------------------------
BlockComment
    : '#$' .*? '$#' ->  skip
    ;

LineComment
    : '#' ~[\r\n]* ->  skip
    ;
//---------------------------------------------------------------------
declArrey :
            ( INTKeyword NAME '=' '!' intValue '!' INTKeyword ('{'intValue (',' intValue )*'}')? )
          | ( CHARKeyword NAME '=' '!' intValue '!' CHARKeyword ('{'charValue (',' charValue )*'}')? )
          | ( STRINGKeyword NAME '=' '!' intValue '!' STRINGKeyword ('{'stringValue (',' stringValue)*'}')? )
          | ( BOOLKeyword NAME '=' '!' intValue '!' BOOLKeyword ('{'boolValue (',' boolValue )*'}')? )

          ;

INTKeyword : [Ii][Nn][Tt];//'int';
CHARKeyword : [Cc][Hh][Aa][Rr];//'char';
STRINGKeyword : [Ss][Tt][Rr][Ii][Nn][Gg];//'string';
BOOLKeyword : [Bb][Oo][Oo][Ll];
//---------------------------------------------------------------------
ifRule : IF '!' condition '!' ':{'
         statement*
         '}:'
         ( ELSE IF '!' condition '!' ':{'
         statement*
         '}:' )?
         ( ELSE ':{'
         statement*
         '}:' )?
         ;
IF : [Ii][Ff];
ELSE : [Ee][Ll][Ss][Ee];
//----------------------------------------------------------------
switchCaseRule :
                  SW '!' NAME '!' ':{'
                  (
                  CASE INT ':'
                  statement*
                  (BREAK ';!:')?
                  )+
                  DEFAULT':' '!'
                  statement*
                  (BREAK ';!:')?
                  '!'
                  '}:'
                  ;

SW : [Ss][Ww];
DEFAULT : [Dd][Ee][Ff][Aa][Uu][Ll][Tt];
CASE : [Cc][Aa][Ss][Ee];
BREAK : [Bb][Rr][Ee][Aa][Kk];
//-----------------------------------
returnRule:
            RETURN   (type  NAME|CHAR|STRING|INT)?  ';!:'
            ;

//----------------------------------------------------------------
classDefinitionRule :
                   CLASS CLASSName  ':{'
                   (
                   declRule
                   | funcRule
                   | declArrey
                    )*
                   '}:'
                   ;
CLASS : [Cc][Ll][Aa][Ss][Ss];//
CLASSName : ([A-Za-z@%][A-Za-z@%])+
          | (NAME[A-Z]NAME)
          //| ([A-Za-z]([A-Za-z][A-Za-z]))*[A-Z]([A-Za-z]([A-Za-z][A-Za-z]))*
          ;

//---------------------------------------------------------------------
fileRule :
              ( NAME '=' OPEN '!' FILENAME ','  method  '!' ';!:' )
            | ( NAME'.' WRITE '(' stringValue ')' ';!:' )
            | ( NAME '.' CLOSE '()' ';!:' )
            ;
FILENAME : '"' NAME'.'TXT  '"';
method :  R
        | W ;
R : '"'[Rr]'"';
W : '"'[Ww]'"';
CLOSE : [Cc][Ll][Oo][Ss][Ee];
OPEN : [Oo][Pp][Ee][Nn];
WRITE : [Ww][Rr][Ii][Tt][Ee];
TXT : [Tt][Xx][Tt];

//----------------------------------------------------------------------
exeptionRule :
               TRY':{'
               statement* '}:'
               EXCEPT NAME':{'
               statement*
               '}:'
               ;
TRY : [Tt][Rr][Yy];
EXCEPT : [Ee][Xx][Cc][Ee][Pp][Tt];
//------------------------------------------------------------------------
printRule :
           PRINT '!' (STRING | CHAR) '!' ';!:'
           ;
PRINT : [Pp][Rr][Ii][Nn][Tt];
//----------------------------------------------------------------------
unaryOperatorEXpretion
    : '**'NAME ';!:'
    |  NAME'++' ';!:'
    |  '++' NAME ';!:'
    | '--' NAME ';!:'
    | NAME '--' ';!:'

    ;
binaryOperatorEXpretion
        :
        (INT|NAME|CHAR|STRING) '==' (INT|NAME|CHAR|STRING) ';!:'
        |  (INT|NAME|CHAR|STRING) '!=' (INT|NAME|CHAR|STRING) ';!:'
        |  (INT|NAME|CHAR|STRING) '<=' (INT|NAME|CHAR|STRING) ';!:'
        |  (INT|NAME|CHAR|STRING) '>=' (INT|NAME|CHAR|STRING) ';!:'
        |  (INT|NAME|CHAR|STRING) '<' (INT|NAME|CHAR|STRING) ';!:'
        |  (INT|NAME|CHAR|STRING) '>' (INT|NAME|CHAR|STRING) ';!:'
        |  (INT|NAME) '%'  (INT|NAME) ';!:'
        |  (INT|NAME) '*'  (INT|NAME) ';!:'
        |  (INT|NAME) '/' (INT|NAME) ';!:'
        |  (INT|NAME) 'or' (INT|NAME) ';!:'
        |  (INT|NAME) 'and' (INT|NAME) ';!:'
        | (INT|NAME|CHAR|STRING) '+' (INT|NAME|CHAR|STRING) ';!:'
        |  (INT|NAME|CHAR|STRING) '-' (INT|NAME|CHAR|STRING) ';!:'
        ;
//----------------------------------------------------------------------------


//---------------------------------------------------------------------------
DOUBLESTAR
    : '**'
    ;

STAR
    : '*'
    ;

DIV
    : '/'
    ;

MOD
    : '%'
    ;
PLUS
    : '+'
    ;

PLUSPLUS
    : '++'
    ;

MINUS
    : '-'
    ;

MINUSMINUS
    : '--'
    ;
AND
    : 'and'
    ;

OR
    : 'or'
    ;
EQUAL
    : '=='
    ;

NOTEQUAL
    : '!='
    ;
LESS
    : '<'
    ;

LESSEQUAL
    : '<='
    ;

GREATER
    : '>'
    ;

GREATEREQUAL
    : '>='
    ;
WS : [ \r\t\n]+ -> skip ;
 INT: [0-9]+ ;
 CHAR : '\'' ~[\r\n\t\b]'\'';//;[a-zA-Z]
//FUNC: PARAMETER ;
LIB: NAME'.kh';
 NAME : [a-zA-Z@%][0-9a-zA-Z@%]* ;
 STRING : '"'(~[\r\n\t\b])+'"';

TYPE: INTKeyword  | CHARKeyword | BOOLKeyword | STRINGKeyword ;
FUNCTYPE : PUBLIC |PRIVATE|PROTECTED;
//STATEMENT: NAME '=' (STRING|CHAR|INT) ';!:' ;
