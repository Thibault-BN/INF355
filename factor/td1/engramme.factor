! Copyright (C) 2013 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: math.primes.factors math.primes kernel sequences assocs combinators ;
IN: engramme

: >engramme ( n -- str ) { { [ dup 0 = ] [ drop "0" ] } 
                           { [ dup 1 = ] [ drop "1" ] } 
                           [ group-factors [ last first primes-upto ] keep [ at 0 or ] curry map [ >engramme ] map concat "(" ")" surround ] 
                         } cond ;

M: sequence >integer dup length 1 = [ first 2 swap (pow) ] [ dup length nprimes swap [ (pow) ] 2map product ] if ;

EBNF: parse-engramme
rule0 = "0" => [[ 0 ]]
rule1 = "1" => [[ 1 ]]
rulec = "("~ parse-engramme+ => [[ >integer ]] ")"~
parse-engramme = rule0 | rule1 | rulec
;EBNF

ERROR: malformed ;

M: string >integer [ parse-engramme ] [ malformed ] recover ;