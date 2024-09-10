#lang racket

#|

An array of Tribonacci numbers is defined as a0=0, a1=0, a2=1 and
ai=a(i-1)+a(i-2)+a(i-3) for all i>=3.

Implement a function "calculate_Tribonacci" which takes in a natural
number n and returns nth element of the "a_n" array.
Use principle of memoization when implementing.

Next, implement function "first_N_Tribonacci which takes in natural
numbers n and k. It creates and returns a thunk using delay methods.
The thunk contains a list of the first n members of the array that
are greater than k. The thunk returned by the function
should be able to evaluate to a common list using force method.

|#

(define memo (make-hash)) ; storing calculated values

(define (calculate_Tribonacci n)
  (cond [(hash-has-key? memo n) (force (hash-ref memo n))]
        [(= 0 n) (delay 0)]
        [(= 1 n) (delay 0)]
        [(= 2 n) (delay 1)]
        [else (let ([result (+ (force (calculate_Tribonacci (- n 1)))
                               (force (calculate_Tribonacci (- n 2)))
                               (force (calculate_Tribonacci (- n 3))))])
                (hash-set! memo n (delay result)) ; cache the result
                (delay result))]
        ))

(force (calculate_Tribonacci 3))
(force (calculate_Tribonacci 4))
(force (calculate_Tribonacci 5))
(force (calculate_Tribonacci 6))
(force (calculate_Tribonacci 7))
(force (calculate_Tribonacci 8))

(define (helper remaining k position)
  (if (= 0 remaining) (delay '())
      (let ([current_tribonacci (force (calculate_Tribonacci position))])
        (if (> current_tribonacci k)
            (delay (cons current_tribonacci (force (helper (- remaining 1) k (+ 1 position)))))
            (helper remaining k (+ 1 position))))
  ))

(define (first_N_Tribonacci n k)
  (helper n k 0))

(force (first_N_Tribonacci 4 2))