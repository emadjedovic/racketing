#lang racket

3
(+ 3 4)
(sqrt 16)
(+ 3 (sqrt 16))
(+)
(*)

#|
block comments
uwu
|#

9 ; integers
9.9 ; reals
1/9 ; rationals
#i1/9 ; inexact
1+2i ; complex
#b101 ; binary
#o77 ; octal
#xfff ; hex
(and 1 #f)
(or 1 #f)

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

(string-append "Hello" " " "World")
(string-ref "Apple" 1)

(let ([who "Bob"]
      [and "Alice"])
  (string-append who " and " and))

; let* is like let, but allows you to use previous bindings in creating later bindings
(let* ([who "Bob"]
      [who-again who])
  (string-append "Alice and " who-again))

; letrec allows to define recursive and mutually recursive functions
(letrec ([is-even (lambda (x)
                   (or (= 0 x) (is-odd (- x 1))))]
         [is-odd (lambda (x)
                   (and (not (= 0 x)) (is-even (- x 1))))])
  (is-odd 17))

#(1 2 3) ; vector
(vector-append #(1 2) #(3 3 3 3))

(set 1 2 3 3 3 3)
(list->set '(8 2 4 1 8 2 3 3 2 8 1))
(set-add (set 1 3) 2)
(set-remove (set 1 2 3) 1)


; multi-variadic functions

(define hello4 (case-lambda
                [() "Hello World"]
                [(name) (string-append "Hello " name)]))
(hello4)
(hello4 "Ema")
(define (hello-optional [name ""])
  (string-append "Hello " name))
(hello-optional "Dino")

(let ([x '()]
      [y '()])
  (eq? x y)) ; #t

(let ([x '(3)]
      [y '(3)])
  (eq? x y)) ; #f

(let* ([x '(3)]
      [y x])
  (eq? x y)) ; #t

(define (divisible-15? n)
  (match (list (remainder n 3) (remainder n 5))
    [(list 0 0) #t]
    [(list 0 _) "Divisible by 3, but not by 5."]
    [(list _ 0) "Divisible by 5, but not by 3."]))

(divisible-15? 30)
(divisible-15? 20)
(divisible-15? 9)

(define (loop i)
  (when (< i 10)
    (displayln i) (loop (add1 i))))

(loop 1)

(define value 13)
(define value2 value)
value2
(set! value 14)
value2
value




