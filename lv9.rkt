#lang racket

; ------------------------ problem #1

(define (fun L)
  (cond [(null? L) '()]
        ; at least one element
        [(number? (first L))
         (cons (first L) (fun (rest L)))]
        [(list? (first L))
         (append (fun (first L)) (fun (rest L)))]
        [else (fun (rest L))]))


(fun '(1 'a ('b 5 (2 'c)) 3))

; ------------------------ problem #2

(define (moj_if_lose uslov x y) (if uslov x y))
(define (moj_if uslov x y) (if uslov (x) (y))) ; x and y being procedures


(if (> 5 2) 3 (print "evaluacija!"))

(moj_if (> 5 2) (lambda () 3) (lambda () (print "evaluacija!")))


; (define (factorial-wrong x) (moj_if_lose (= x 0) 1 (* x (factorial-wrong (- x 1)))))
; (factorial-wrong 5)

(define (my_if condition x y)
  (if condition x y))

(let ([x 5]
      [y 8])
  (my_if #f (set! x 6) (set! y 9))
  (displayln x)
  (displayln y))

(define-syntax-rule (my_if2 condition x y)
  (if condition x y))

(let ([x 5]
      [y 8])
  (my_if2 #t (set! x 6) (set! y 9))
  (displayln x)
  (displayln y))

; easier example

(my_if (< 2 3) (displayln "yes") (displayln "no"))
(my_if2 (< 2 3) (displayln "yes") (displayln "no"))

;------------------------ problem #3

#|
Thunks are a technique used to postpone evaluation of expressions.
A thunk is a no-argument function that wraps an expression, and
that expression is evaluated only when the function is called.
|#


(define expression
  (displayln "displaying expression"))

expression ; "displaying expression"

(define thunk
  (lambda () (displayln "displaying thunk"))) ; defined with lambdas

thunk ; procedure
(thunk) ; "displaying thunk"

; more examples

(define (f1 e) (list e e e))
; treats the argument e as a value (an expression that has already been evaluated)

(define (f2 e) (list (e) (e) (e)))
; treats e as a function

(f1 (begin (print "nesto") 5))
; "nesto" '(5 5 5) --- e is not evaluated any further; it's just placed into a list as is

(f1 (lambda () (begin (print "nesto") 5)))
; places three procedures into a list

(f2 (lambda () (begin (print "nesto") 5)))
; e is evaluated (called) each time it appears in the list
;"nesto""nesto""nesto"'(5 5 5)