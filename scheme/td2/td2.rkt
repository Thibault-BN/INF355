#lang racket

(define fail #f)

(define (reset)
  (set! fail (lambda () (error "No more alternative"))))

(reset)

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

(define (mult)
  (let ((x (amb 1 2 3 4 5 6 7 8 9 10))
        (y (amb 1 2 3 4 5 6 7 8 9 10)))
    (if (= (* x y) 30) (list x y) (amb))))
(mult)

(define (produce n)
  (printf "Producing ~s~n" n)
  n)

(reset)

; Test to check if we don't evaluate all the arguments
(amb (produce 1) (produce 2) (produce 3))

(reset)

(define (bag-of f)
  (let ((results '()))
    (amb
     (begin (set! results (cons (f) results))
            (fail))
     (reverse results))))

(define (check column row placed)
  (unless (empty? placed)
    (let loop ((pair (car placed))
               (list (cdr placed)))
      (let ((col2 (car pair))
            (row2 (cdr pair)))
        (cond 
          ((equal? column col2) (amb))
          ((equal? row row2) (amb))
          ((equal? (- column row) (- col2 row2)) (amb))
          ((equal? (+ column row) (+ col2 row2)) (amb)))
        (unless (empty? list)
          (loop (car list) (cdr list)))))))

(define (queens)
  (let loop ((placed '())
             (column 1))
    (if (equal? 8 (length placed))
        placed
        (let* ((row (amb 1 2 3 4 5 6 7 8))
               (pair (cons column row)))
          (check column row placed)
          (loop (cons pair placed) (+ column 1))
          ))
    ))

; Checking that we have all 92 possibilities
 (length (bag-of queens))
