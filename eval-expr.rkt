#lang racket

(displayln "QUOTE")

; quoting prevents evaluation of expressions
(define my-list (quote (1 2 3 4))) ; the same as '(1 2 3 4)

;; Display the quoted list
(displayln my-list)

(displayln "\n------------ COMMON LIST")

(define (const a) (list 'const a))
; The function list takes each of its arguments, evaluates them,
; and constructs a list containing those results.
; we don't want to evaluate const, hence quote (')
(define (multiply a b) (list 'multiply a b))
(define (add a b) (list 'add a b))
(define (negate a) (list 'negate a))

(define (eval-expr e) ; e consists of the former types
  (cond
    [(equal? 'const (first e)) (second e)] ; if constant, return its value
    [(equal? 'multiply (first e))
     (* (eval-expr (second e)) (eval-expr (third e)))]
    [(equal? 'add (first e))
     (+ (eval-expr (second e)) (eval-expr (third e)))]
    [(equal? 'negate (first e))
     (- 0 (eval-expr (second e)))]
    [else (displayln "Error in eval-expr.")]))

(eval-expr (multiply (const 2) (add (negate (const 3)) (const 5)))) ; 4


(displayln "\n------------ STRUCT")

(struct const2 (a) #:transparent) ; #:transparent adds functionalities
(struct multiply2 (a b) #:transparent)
(struct add2 (a b) #:transparent)
(struct negate2 (a) #:transparent)

(define (eval-expr2 e)
  (cond
    [(const2? e) (const2-a e)]
    [(multiply2? e) (* (eval-expr2 (multiply2-a e)) (eval-expr2 (multiply2-b e)))]
    [(add2? e) (+ (eval-expr2 (add2-a e)) (eval-expr2 (add2-b e)))]
    [(negate2? e) (- 0 (eval-expr2 (negate2-a e)))]
    [else (displayln "Error in eval-expr2.")]))

(eval-expr2 (multiply2 (const2 4) (add2 (negate2 (const2 3)) (const2 5)))) ; 8

