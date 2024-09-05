#lang racket

; thunks and lazy eval

(define (my-delay f)
  (mcons #f f))

(define (my-force par)
  (if (mcar par) (mcdr par) ; already evaluated
      (begin
              (set-mcar! par #t)
              (set-mcdr! par ((mcdr par)))
              (mcdr par))))

(define (fibonacci n)
  (cond [(= n 0) 1]
        [(= n 1) 1]
        ; mpair, evaluated
        [#t (+ (fibonacci (- n 1)) (fibonacci (- n 2)))]))

(define fib-40 (my-delay (lambda () (fibonacci 40))))
(displayln "first try... (slow)")
;(my-force fib-40)
(displayln "second try... (fast)")
;(my-force fib-40)
(displayln "third try... (fast)")
;(my-force fib-40)

; memoization
; ((1, 1), (2, 1), (3, 2), (4, 3), (5, 5), ... memo

(define memo '())

(define fib-memo
  (lambda (n)
    (let ([existing (assoc n memo)])
      (if existing (cdr existing)
          (let ([new_value
                 (cond
                   [(= n 0) 1]
                   [(= n 1) 1]
                   ; evaluated
                   [#t (+ (fib-memo (- n 1)) (fib-memo (- n 2)))])])
            (begin
              (set! memo (cons (cons n new_value) memo))
              new_value))))))

(displayln "fib-memo for 0, 1, 2, 3...")
(fib-memo 0)
(fib-memo 1)
(fib-memo 2)
(fib-memo 3)
(display "first fib-memo... ")
(fib-memo 40) ; Computes and returns fib(40), storing intermediate results
(display "second fib-memo... ")
(fib-memo 40) ; Returns the cached result from memo, without recomputing
