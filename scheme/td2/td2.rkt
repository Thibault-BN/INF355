#lang racket

(define (fail) ((error "No more alternatives"))

(define-syntax amb
  (syntax-rules ()
    ((amb) (fail))
    ((amb x) x)
    ((amb x y)
     (let ((old-fail fail))
       (let/cc k
         (set! fail (lambda ()
                      (set! fail old-fail)
                      (k (lambda () y))))
         (lambda () x))))
    ((amb x y ...) (amb x (amb y ...)))
    ))
