#lang racket

;;;; Mise en place

(define (test cond result)
  (if (equal? cond result)
      (void)
      (error "Bad test result")))

;;;; Echauffement

(define (next-odd n)
  (if (equal? 0 (modulo n 2))
      (+ n 1)
      (+ n 2)))

(define (prime? n)
  (cond 
    ((<= n 1) #f)
    ((<= n 3) #t)
    ((equal? 0 (modulo n 2)) #f)
    (else (let loop ((i 3)
               (s (sqrt n)))
       (cond
         ((> i s) #t)
         ((equal? 0 (modulo n i)) #f)
         (else (loop (+ i 2) s)))))
    ))

(define (map-interval f min max)
  (let loop ((min min))
    (if (> min max)
        '()
        (cons (f min) (loop (+ min 1))))
    ))

(define (iota n) (range n))

;;;; Tests échauffement

(test (+ 1 2) 3)
(test (next-odd 1) 3)
(test (next-odd 2) 3)
(test (prime? -5) #f)
(test (prime? 0) #f)
(test (prime? 1) #f)
(test (prime? 2) #t)
(test (prime? 3) #t)
(test (prime? 19) #t)
(test (prime? 21) #f)
(test (map-interval (lambda (x) (+ 2 x)) 10 13) '(12 13 14 15))
(test (iota 5) '(0 1 2 3 4))
(test (iota 0) '())
(test (iota -1) '())

;;;; Manipulation de données

(define (revsymb symb)
  (string->symbol (list->string (reverse (string->list (symbol->string symb))))))

(define (trans l)
  (map (lambda (x) (revsymb x)) l))