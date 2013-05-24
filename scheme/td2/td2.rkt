#lang racket

(define (fail) (error "No more alternatives"))

(define-syntax amb
  (syntax-rules ()
    ((amb) (fail))
    ((amb x) x)
    ((amb x y)
     (let ((old-fail fail))
       (let/cc k
         (set! fail (lambda ()
                      (set! fail old-fail)
                      (k (begin y))))
         x)))
    ((amb x y ...) (amb x (amb y ...)))
    ))

; Function to help compiler understand that fail is not a constant
(define (foobar)
  (amb 1 2))

(define (mult)
  (let ((x (amb 1 2 3 4 5 6 7 8 9 10))
        (y (amb 1 2 3 4 5 6 7 8 9 10)))
     (if (= (* x y) 30) (list x y) (amb))))
(mult)

(define (produce n)
  (printf "Producing ~s~n" n)
  n)

; Test to check if we don't evaluate all the arguments
(amb (produce 1) (produce 2) (produce 3))