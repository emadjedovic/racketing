#lang racket

; car: "Contents of the Address part of the Register"
; cdr: "Contents of the Decrement part of the Register"

(define (sumList L)
  (if (empty? L) 0
      (+ (car L) (sumList (cdr L)))))

(sumList '(3 3 3 3 4 4 1))


; --- implementing cons without built-in


; procedure
(define (cons-L F R)
  (lambda (string)
    (cond [(equal? string "first") F] ; element
          [(equal? string "rest") R] ; always a list
          [else "ERROR"])))

(define myProcedure (cons-L 12 '(13 14 15 16)))
(myProcedure "first") ; 12
(myProcedure "rest") ; '(13 14 15 16)

(define (first f)
  (f "first"))

(define (rest f)
  (f "rest"))

(first myProcedure)
(rest myProcedure)

(define z (cons-L 1 (cons-L 2 (cons-L 3 '()))))
z ; still a procedure

; ---------------------------- dots

(cons 1 2) ; a pair '(1 . 2) -- when the second argument is not a list
(cons 1 '()) ; still a pair '(1 . ()) but written as '(1)
(cons 1 '(2)) ; '(1 2) actually (cons 1 (cons 2 '()))