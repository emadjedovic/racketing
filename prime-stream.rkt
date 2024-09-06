#lang racket

(define (make-const-stream a)
  (cons a (lambda () (make-const-stream a))))

(define (make-natural-stream a)
  (cons a (lambda () (make-natural-stream (+ 1 a)))))

(define (make-prime-stream)
  (letrec ([prime? (lambda (p d)
                     (cond [(= 1 p) #f] ; not prime
                           [(= 2 p) #t] ; is prime
                           [(>= d p) #t] ; all possible divisors checked
                           [(= (remainder p d) 0) #f] ; p divisible by d, not prime
                           ; evaluated
                           [#t (prime? p (+ d 1))]))]
           [next-prime (lambda (p)
                         (cond [(prime? (+ 1 p) 2) (+ 1 p)] ; start checking divisibility from 2
                               ; not prime
                               [#t (next-prime (+ 1 p))]))]
           [start-stream (lambda (x) (cons x (lambda () (start-stream (next-prime x)))))])
    (start-stream 2)))

(define p1 (make-prime-stream))
(define p2 ((cdr p1)))
(define p3 ((cdr p2)))
(define p4 ((cdr p3)))
(define p5 ((cdr p4)))
(define p6 ((cdr p5)))

  

  