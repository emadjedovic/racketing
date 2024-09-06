#lang racket

(define (stream-naturals a)
  (cons a (lambda () (stream-naturals (+ 1 a)))))

(define (count-until-total-is-more s limit)
  (if (<= 0 limit) 0 ; no need to sum anything, the smallest number in the stream is 1
      ; we have to add at least one number
      (let ([first-num (car s)]
            [the-rest ((cdr s))])
        (+ 1 (count-until-total-is-more the-rest (- limit first-num))))))

(define test-stream (stream-naturals 1))
(define s1 (car test-stream))
(define s2 ((cdr test-stream)))
(define s3 ((cdr s2)))

(define (third-element s)
  (car ((cdr ((cdr s))))))

(define (every-third s)
  (cons (third-element s) (lambda () (every-third ((cdr ((cdr ((cdr s))))))))))

; returns a stream
(define (from-nth-element s n)
  (if (= 1 n) s
      (from-nth-element ((cdr s)) (- n 1))))

(define (every-nth s n)
  (cons (car (from-nth-element s n)) (lambda () (every-nth (from-nth-element ((cdr s)) n) n))))

        
        