! Copyright (C) 2013 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel math sequences ;
IN: hanoi

: move ( a b -- str ) [ 10 >base ] bi@ " -> " glue ;