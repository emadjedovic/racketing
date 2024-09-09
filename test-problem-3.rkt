#lang racket

#|

Implement the Catalan function that receives a natural number n and returns
the nth Catalan's number Cn = (2n)!/((n+1)! n!). In the implementation,
use the principle of memoization. Then, implement a function that receives
a list of Catalan numbers and a number t, and returns the first Catalan number
from forwarded list which is greater than t. In the implementation of this
function, use lazy evaluation for construction of a list of Catalan numbers
(using delay and force methods).

|#

(require math/number-theory) ; factorial

; ((0 . 1) (1 . 1) (2 . 2) (3 . 5) ...)
(define memo-catalan '())
(define (lookup-catalan n)
  (if (assoc n memo-catalan) (cdr (assoc n memo-catalan)) #f))


(define (nth-Catalan n)
  (if (lookup-catalan n) (lookup-catalan n)
      ; calculate nth catalan and add to memo
      (let* ([n_factorial (factorial n)]
             [numerator (factorial (* 2 n))]
             [denominator (* n_factorial (* n_factorial (+ 1 n)))])
        (/ numerator denominator))))

(define (catalan-stream n)
  (cons (nth-Catalan n) (lambda () (catalan-stream (+ n 1)))))

(define catalans (catalan-stream 0))

(define (first_greater_than stream t)
  (if (> (car stream) t) (car stream)
      (first_greater_than ((cdr stream)) t)))

; (first_greater_than catalans 2) -- repl call


