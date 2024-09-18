#lang racket
(require htdp/testing)
(require racket/trace)

; --------- embedded recursion
; The recursive call is followed by other operations.

(check-expect (fac 1) 1)
(check-expect (fac 2) 2)
(check-expect (fac 3) 6)
(check-expect (fac 4) 24)
(check-expect (fac 5) 120)

; x should be greater than 0
(define (fac x)
  (if (= x 1)
      1
      (* x (fac(- x 1)))))

(trace fac)

; ------------ tail recursion
; The recursive call is the last operation.

(check-expect (facT 1) 1)
(check-expect (facT 2) 2)
(check-expect (facT 3) 6)
(check-expect (facT 4) 24)
(check-expect (facT 5) 120)

(define (facT x)
  (facT-acc x 1))

(define (facT-acc x acc)
  (if (= x 1) ; base case
      acc
      (facT-acc (- x 1) (* x acc) )))

(trace facT)

(generate-report)
