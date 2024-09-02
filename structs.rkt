#lang racket

(define-struct card (type value))
(define demo (make-card 'hearts 7))

; procedures
card-type
card-value

demo
(card-type demo)
(card-value demo)

(define (create-card type value)
  (make-card type value))

(equal? (create-card 'hearts 7) demo) ; #f
(equal? (card-type demo) (card-type (create-card 'hearts 7))) ; #t
(equal? (card-value demo) (card-value (create-card 'hearts 7))) ; #t