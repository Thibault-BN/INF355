! Copyright (C) 2013 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test engramme ;
IN: engramme.tests

{ "0" "1" } [ 0 >engramme 1 >engramme ] unit-test
{ "(1)" "(01)" } [ 2 >engramme 3 >engramme ] unit-test
{ "((1))" "(001)" } [ 4 >engramme 5 >engramme ] unit-test
{ "((01))" "(0(1))" } [ 8 >engramme 9 >engramme ] unit-test
{ "((1)(1))" "((11))" } [ 36 >engramme 64 >engramme ] unit-test
{ "((1)(1)101)" "(0010000000000000000000000000000000000000000000000000000000000000000000000000001)" } [ 1980 >engramme 2005 >engramme ] unit-test