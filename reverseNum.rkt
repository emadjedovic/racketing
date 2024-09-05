#lang racket

(define (num_to_list num)
  (string->list (number->string num)))

(define (reverse list)
  (foldl cons '() list))

(define (list_to_num list)
  (string->number (list->string list)))

(define (reverse_num x)
    (list_to_num (reverse (num_to_list x))))

(reverse_num 12345)

; without conversions

(define (reverseNum-acc a acc)
  (if (< a 10) (+ (* 10 acc) a)
      (let ([new_a (quotient a 10)]
            [new_acc (+ (* 10 acc) (modulo a 10))])
        (reverseNum-acc new_a new_acc))))

(define (reverseNum a)
  (reverseNum-acc a 0))

(reverseNum 12345)
         

 
