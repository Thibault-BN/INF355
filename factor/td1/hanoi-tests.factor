! Copyright (C) 2013 Thibault FRANCOIS.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test hanoi io.streams.string ;
IN: hanoi.tests

{ "1 -> 2" } [ 1 2 move ] unit-test
{ 1 1 } [ 2 3 other 3 2 other ] unit-test
{ 2 2 } [ 1 3 other 3 1 other ] unit-test
{ 3 3 } [ 1 2 other 2 1 other ] unit-test
{ 1 3 2 3 } [ 1 2 partial 2 1 partial ] unit-test
{ 1 2 3 2 } [ 1 3 partial 3 1 partial ] unit-test
{ 2 1 3 1 } [ 2 3 partial 3 2 partial ] unit-test
{ "1 -> 2\n" } [ 1 2 1 [ hanoi ] with-string-writer ] unit-test
{ "1 -> 3\n" } [ 1 3 1 [ hanoi ] with-string-writer ] unit-test
{ "3 -> 2\n" } [ 3 2 1 [ hanoi ] with-string-writer ] unit-test
{ "1 -> 3\n1 -> 2\n3 -> 2\n" } [ 1 2 2 [ hanoi ] with-string-writer ] unit-test
{ "1 -> 2\n1 -> 3\n2 -> 3\n" } [ 1 3 2 [ hanoi ] with-string-writer ] unit-test
{ "1 -> 2\n1 -> 3\n2 -> 3\n1 -> 2\n3 -> 1\n3 -> 2\n1 -> 2\n" } [ 1 2 3 [ hanoi ] with-string-writer ] unit-test
{ "1 -> 3\n1 -> 2\n3 -> 2\n1 -> 3\n2 -> 1\n2 -> 3\n1 -> 3\n" } [ 1 3 3 [ hanoi ] with-string-writer ] unit-test