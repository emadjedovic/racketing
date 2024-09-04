#lang racket

; The first element is immediately available,
; subsequent elements are computed on demand.

(define (stream-cons head tail-thunk)
  (cons head tail-thunk))

(define (stream-first s)
  (car s))

(define (stream-rest s)
  ((cdr s))) ; cdr s is a thunk

; Because of their lazy nature, streams can represent infinite sequences.

(define (naturals n)
  (stream-cons n (lambda () (naturals (+ 1 n)))))

(stream-first (naturals 1))
(stream-first (stream-rest (naturals 1)))

; stream-map, stream-filter, stream-fold... (require racket/stream)


