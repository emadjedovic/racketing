#lang racket

; the largest digit in a number

; ((32 . 3), (1234 . 4), ...)
(define memo-list '())

(define (lookup-memo-list num memo)
  (cond [(null? memo) #f]
        [(= num (car (car memo))) (cdr (car memo))]
         [else (lookup-memo-list num (cdr memo))]))
        
(define (largestDigit num)
  (cond [(< num 10) num]
        ; memoization: Check if the result is already cached in the list
        [(lookup-memo-list num memo-list)  => identity]
        ; otherwise, compute the largest digit lazily
        [else
         (let* ([currentDigit (remainder num 10)]
               [nextLargest (delay (largestDigit (quotient num 10)))]
               [result
                (if (>= currentDigit (force nextLargest)) currentDigit (force nextLargest))])
               ; save to memo list
               (set! memo-list (cons (cons num result) memo-list))
           result)]))

(displayln "Largest digit in a number...")
(largestDigit 12345)
(largestDigit 12543)
(largestDigit 54321)

; the largest digit in a list of numbers

(define (largestDigit2 num)
  (cond [(< num 10) num]
        [(>= (remainder num 10) (largestDigit2 (quotient num 10))) (remainder num 10)]
        [else (largestDigit2 (quotient num 10))]))

(define (helper list_of_num current_largest)
  (cond [(null? list_of_num) current_largest]
        [(>= (largestDigit2 (car list_of_num)) current_largest)
         (helper (cdr list_of_num) (largestDigit2 (car list_of_num)))]
        [else (helper (cdr list_of_num) current_largest)]))

(define (largestDigitList list_of_num)
  (let ([first_number_largest_digit (largestDigit2 (car list_of_num))])
    (helper (cdr list_of_num) first_number_largest_digit)))

(displayln "Largest digit in a list of numbers...")
(largestDigitList (list 123 324))
(largestDigitList (list 245 12 564 124))

; tail recursion

(define (helper1 num acc)
  (cond [(= 0 num) acc]
        [(> (remainder num 10) acc) (helper1 (quotient num 10) (remainder num 10))]
        [else (helper1 (quotient num 10) acc)]))

(define (largest1 num)
  (helper1 num 0))

(define (helper2 L acc)
  (if (null? L) acc
      (let ([first_num (largest1 (car L))])
        (if (> first_num acc) (helper2 (cdr L) first_num)
            (helper2 (cdr L) acc)))))

(define (largest2 L)
  (helper2 L 0))

(displayln "Largest digit in a number...")
(largest1 12345)
(largest1 12543)
(largest1 54321)
(displayln "Largest digit in a list of numbers...")
(largest2 '(123 324))
(largest2 '(245 12 564 124))