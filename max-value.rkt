#lang racket

; assume non-empty list of numbers L
(define (max-value L)
  (if (null? (rest L))
      (first L)
      (max (first L) (max-value (rest L)))))

(max-value '( 1 4 2 1 5 -4 -4))

; without max function (inefficient)

(define (max-value-2 L)
  (cond [(null? (rest L)) (first L)]
        [(> (first L) (max-value-2 (rest L))) (first L)]
        [else (max-value-2 (rest L))])) ; another computation

(max-value-2 '( 1 4 2 1 5 -4 -4))

; without max function (efficient)

(define (max-value-3 L)
  (if (null? (rest L))
      (first L)
      (maxHelper (rest L) (first L))))

(define (maxHelper L acc)
  (cond [(null? L) acc]
        [(> (first L) acc) (maxHelper (rest L) (first L))]
        [else (maxHelper (rest L) acc)]))
  

(max-value-3 '( 1 4 2 1 5 -4 9 -4))