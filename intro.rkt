#lang racket

3
(+ 3 4)
(sqrt 16)
(+ 3 (sqrt 16))
(+)
(*)
(- 1 1 1 1)
"hello"
;hello --- unbound identifier
(define a 3)
a
(+ a 3)
(define hello "hi!")
hello
(define b (+ 3 5))
b
(define addFun +)
(addFun 3 4)
(+ 3 4)

;----------------- functions

(define (avg x y)
  (quotient (+ x y) 2))

(avg 4 8)

(define (warm temp)
  (if (> temp 15)
      "warm"
      "cold"))

(define (cool temp)
  (cond
    [(> temp 25) "hot"]
    [(< temp 15) "cold"]
    [ else "ok"]))

(warm 25)
(warm 15)
(cool 26)
(cool 20)
(cool 13)

(define (spam)
  (let ([a 3]
        [b 4])
    (+ a b)))

spam ; procedure
+ ; procedure
(spam) ; 7
; (7) -- parentheses are trying to call a function, which 7 is not

(= 2) ; #t
(odd? 4) ; #f
(if (odd? 3) "summer" "winter") ; summer
(if (odd? 3) + "winter") ; procedure +
((if (odd? 3) + -) 2 5) ; 7
((if (even? 3) + -) 2 5) ; -3

; -------------------- maps and lambdas

(define bar (lambda (num) (+ 1 num)))

bar
(bar 59)

(define double (lambda (num) (* 2 num)))

(double 59)

(define (doubleList L)
  (map double L))

(doubleList '(10 20 30 40 50))

(define (tripleList L)
  (map (lambda (el) (* 3 el)) L))

(tripleList '(1 2 3 4 5))




