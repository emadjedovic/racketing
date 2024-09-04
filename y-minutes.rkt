#lang racket

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

(define hello (case-lambda
                [() "Hello World"]
                [(name) (string-append "Hello " name)]))
(hello)
(hello "Ema")
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
  