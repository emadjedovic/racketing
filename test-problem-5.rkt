#lang racket

#|

We define stream as a thunk, which when called returns a pair where the cdr
of that pair is again a stream, and car of that pair is some value we generate.

a) Implement a stream which generates numbers of this form:
(-1)^k * (4k+1) for all k=1,2,3... .

b) Implement a function "enumerate" which takes in a stream s whose elements
are arbitrary, and returns a new stream v. If the stream produced an element
e on the position "i", then stream v should produce a pair (i, e) on the same
position "i". Test the function with stream from part a). Indexing starts at i=0.

c) Implement a function "greater_than_previous" which takes in stream s and
returns a stream v which consists of all the elements from s that are greater
than all the previous elements from stream s. Test the function with a stream from part a).

|#

(displayln "Generator...")

(define (generator-helper k)
    (cons (* (expt -1 k) (+ (* 4 k) 1)) (lambda () (generator-helper (+ 1 k)))))

(define generator
  (generator-helper 1))

generator
((cdr generator))
(( cdr ((cdr generator))))

(displayln "Naturals...")

(define (naturals-helper start)
  (cons start (lambda () (naturals-helper (+ 1 start)))))

(define naturals
  (naturals-helper 1))

naturals
((cdr naturals))
(( cdr ((cdr naturals))))

(displayln "Enumerate naturals...")


(define (enumerate-helper s start)
  (cons (cons start (car s)) ; a pair (i, e)
        (lambda () (enumerate-helper ((cdr s)) (+ 1 start)))))

(define (enumerate s)
  (enumerate-helper s 0))

(enumerate naturals)
((cdr (enumerate naturals)))
(( cdr ((cdr (enumerate naturals)))))


(displayln "Enumerate generated...")

(enumerate generator)
((cdr (enumerate generator)))
(( cdr ((cdr (enumerate generator)))))
((cdr (( cdr ((cdr (enumerate generator)))))))
((cdr ((cdr (( cdr ((cdr (enumerate generator)))))))))
(( cdr (( cdr ((cdr (( cdr ((cdr (enumerate generator)))))))))))

(displayln "Greater than previous...")

(define (helper s acc)
  (if (> (car s) acc) (cons (car s) (lambda () (helper ((cdr s)) (car s))))
      (helper ((cdr s)) acc)))

(define (greater_than_previous s)
  (cons (car s) (lambda () (helper ((cdr s)) (car s)))))


(define v (greater_than_previous generator)) ; testing
v
((cdr v))
((cdr ((cdr v))))
(( cdr ((cdr ((cdr v))))))
(( cdr (( cdr ((cdr ((cdr v))))))))
