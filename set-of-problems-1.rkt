#lang racket

; for input n generate n random numbers between 100 and 1000

(define (generate-n-random n)
  (if (= 1 n)
      (cons (random 100 1000) '())
      (cons (random 100 1000) (generate-n-random (- n 1)))))

(displayln "generating random...")
(generate-n-random 1)
(generate-n-random 2)
(generate-n-random 5)

; subtract the second largest from the second smallest element of the given list L

(define (difference L)
  (if (null? L) 0
      (let ([ascending (sort L <)]
            [descending (sort L >)])
        (- (second descending) (second ascending)))))

(displayln "difference...")
(difference '(5 2 6 4 1 3)) ; 5-2=3
(difference '(9 22 3 8 11 6)) ; 11-6=5

; the same problem without "second"

(define (second-largest L)
  (let ([sorted (sort L >)])
       (car (cdr sorted))))

(define (second-smallest L)
  (let ([sorted (sort L <)])
       (car (cdr sorted))))

(displayln "second-largest and second-smallest...")
(second-largest '(5 9 2 1 8 4 4)) ; 8
(second-smallest '(5 9 2 1 8 4 4)) ; 2

(define (difference2 L)
  (- (second-largest L) (second-smallest L)))

(displayln "difference2...")
(difference2 '(5 2 6 4 1 3)) ; 5-2=3
(difference2 '(9 22 3 8 11 6)) ; 11-6=5


; insert a given number into its correct position in a sorted list, maintaining the sorted order

(define (insert x L)
  (cond [(null? L) (list x)]
        [(<= x (car L)) (cons x L)]
        [else (cons (car L) (insert x (cdr L)))]))

(displayln "inserting...")
(insert 7 '())
(insert 2 '(3 4 4 6 7 8))
(insert 9 '(3 4 4 6 7 8))
(insert 7 '(3 4 4 6 7 8))

; a perfect number is a positive integer that is equal to the sum of its positive proper divisors

(define (divisors n)
  (filter (lambda (x) (= 0 (modulo n x)))
          ; generates a list of numbers from 1 to n-1
          (sequence->list (in-range 1 n))))

(define (sum-divisors divisors)
  (foldr + 0 divisors))

(define (perfect? n)
  ; Ensures n has more than one divisor and checks if the sum equals n
  (and (> (length (divisors n)) 1) (= (sum-divisors (divisors n))  n)))

(displayln "perfect numbers...")
(perfect? 5) ; #f
(perfect? 6) ; #t
(perfect? 28) ; #t

; a function that takes a natural number, calculates the value of reversed digits, and
; outputs the absolute difference |original - reversed|

(define (f original)
  (let* ([original_list (string->list (number->string original))]
        [reverse_list (reverse original_list)]
        [reverse_value (string->number (list->string reverse_list))])
    (abs(- original reverse_value))))

(displayln "original - reversed...")
(f 100) ; 100-1=99
(f 99) ; 99-99=0
(f 114) ; 411-114=297
                                               
