#lang racket
(require lang/htdp-advanced) ; quicksort

(define (op x y o)
  (o x y))

(op 3 5 (lambda (x y) (+ x y)))

(quicksort '(2 3 0 -1 444 1) <)

(define even '(1 2 3 4 5 6 7 8 9 10))
(define odds '(1 2 3 4 5 6 7 8 9 10))

(filter (lambda (x) (even? x)) even)
(filter (lambda (x) (odd? x)) odds)

(define (make_even L)
  (map (lambda (x) (* 2 x)) L))

(make_even odds)

(remainder 117 6)

; composition (f x1 (f x2 (f x3 (f x4 base))))
; (foldr f base '(x1 x2 x3 x4))
; composition (f x4 (f x3 (f x2 (f x1 base))))
; (foldl f base '(x1 x2 x3 x4))

(define (multiply-all numbers)
  (foldr (lambda (x y) (* x y)) 1 numbers))

(multiply-all '(1 2 3 4 5)) ; factorial
(multiply-all '())
(multiply-all '(1))
(multiply-all '(2))
(multiply-all '(1 2))
(multiply-all '(1 2 3 4))
