#lang racket

; m - mutable

(mcar (mcons 11 12))
(mcdr (mcons 11 12))

(define mpair (mcons 111 222))
(set-mcar! mpair 100)
(set-mcdr! mpair 200)

(mcar mpair)
(mcdr mpair)

(define mlist (mcons 1 (mcons 2 (mcons 3 '()))))
(mcar mlist)
(mcdr mlist)
(set-mcdr! mlist '(42 43 44))
mlist

(define delayed-computation (delay (displayln "Computing...") (+ 1 2)))
delayed-computation ; returns a promise
(force delayed-computation) ; the result is cached (memoized)
; that subsequent calls to force on the same promise will
; return the cached result without re-evaluating the expression
(force delayed-computation)

; lazy list of natural numbers

(define (lazy-list-from n)
  (cons n (delay (lazy-list-from (+ n 1)))))

(car (lazy-list-from 5))
(cdr (lazy-list-from 5))
(force (cdr (lazy-list-from 5)))
  