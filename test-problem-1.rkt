#lang racket

#|

We define a stream as a thunk which, when called, returns a pair where the cdr of that pair is a
stream again, and car of that pair is some value that we generate.

a) Write a count-until-total-is-more function that receives two arguments: stream s (for which
we assume that it generates only positive numbers) and number limit. The function returns
the minimum number of elements from the stream that should be added to make their sum
strictly greater than the limit (in which addition of elements is done in the order in which they
appear in the stream).

b) Write a function every-third that receives a stream s and returns a stream containing every third
number from stream s.

c) Write a function every-nth that receives a stream s and a natural number n and returns a stream that
contains every nth number from stream s.

Demonstrate the calls of the specified functions using a stream of natural numbers 1, 2, 3, ...

|#

(define (count-until-total-is-more s limit)
  ; traverse through stream decreasing limit by the current number, calling the same function
  ; with cdr s instead of s, as long as limit >= 0
  ; each calling of the function adds one
  (if (< limit 0) 0 ; no elements should be added
        (+ 1 (count-until-total-is-more ((cdr s)) (- limit (car s))))))

(define (naturals start_num)
  (cons start_num (lambda () (naturals (+ 1 start_num)))))

(define testing_stream (naturals 1))

(define a1 testing_stream)
(define a2 ((cdr a1)))
(define a3 ((cdr a2)))

(count-until-total-is-more testing_stream 0) ; 1
(count-until-total-is-more testing_stream 1) ; 2
(count-until-total-is-more testing_stream 5) ; 3
(count-until-total-is-more testing_stream 50) ; 10

(define (every-third-helper s position)
  ; cons element if (modulo position 3) is zero
  (cond [(= 0 (modulo position 3)) (cons (car s) (lambda () (every-third-helper ((cdr s)) (+ 1 position))))]
        [else (every-third-helper ((cdr s)) (+ 1 position))]))

(define (every-third s)
  ; use counter and check (modulo counter 3)
  (every-third-helper s 1))

(define b1 (every-third testing_stream))
(define b2 ((cdr b1)))
(define b3 ((cdr b2)))

(define (every-nth-helper s n position)
  (cond [(= 0 (modulo position n)) (cons (car s) (lambda () (every-nth-helper ((cdr s)) n (+ 1 position))))]
        [else (every-nth-helper ((cdr s)) n (+ 1 position))]))

(define (every-nth s n)
  (every-nth-helper s n 1))

(define c1 (every-nth testing_stream 6))
(define c2 ((cdr c1)))
(define c3 ((cdr c2)))