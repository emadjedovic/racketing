#lang racket

(define memo '((2 . 5) (3 . 8) (4 . 6) (5 . 10)))

; Search for the value associated with the key 4
(define result (assoc 4 memo))
result

(define (memoize-hash f)
  (let ([cache (make-hash)]) ; create a hash table to store results
    (lambda (x)
      (if (hash-has-key? cache x) ; check if result is cached
          (hash-ref cache x)
          ; else
          (let ([result (f x)]) ; compute result if not cached
            (hash-set! cache x result) ; store the result in cache
            result)))))

(define (fib-regular n)
  (cond [(= n 1) 1]
        [(= n 2) 1]
        [else (+ (fib-regular (- n 2)) (fib-regular (- n 1)))]))


(define fib-memoize
  (memoize-hash fib-regular))

(fib-memoize 1)
(fib-memoize 2)
(fib-memoize 3)
(fib-memoize 4)
(fib-memoize 5)
(fib-memoize 6)
(fib-memoize 7)

(define (memoize-list f)
  (let ([cache '()])
    (lambda (x)
      (let ([cached-result (assoc x cache)])
        (if cached-result
            (cdr cashed-result)
            (let ([result (f x)])
              ; add the new result to the cache and return it
              (set! cache (cons (cons x result) cache))
              result))))))

