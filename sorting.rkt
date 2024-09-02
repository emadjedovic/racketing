#lang racket
(require rackunit)
(require racket/trace)

(sort '(5 7 1 -5 9 2) <)
(sort '(5 7 1 -5 9 2) >)
(sort '("k" "a" "t" "T" "t" "m" "p" "A" "w") string<?)
(sort '("k" "a" "t" "T" "t" "m" "p" "A" "w") string>?)

(define (abs-greater x y)
  (> (abs x) (abs y)))

(sort '(5 7 1 -5 9 2) abs-greater)

;----------------------------- MERGE SORT

; ----------------------------- merging

(define (merge A B)
  (cond [(null? B) A]
        [(null? A) B]
        [else
         (if (<= (first A) (first B))
             (cons (first A) (merge (rest A) B))
             (cons (first B) (merge A (rest B))))]))

(check-equal? (merge '() '()) '())
(check-equal? (merge '(3 4 5) '()) '(3 4 5))
(check-equal? (merge '() '(3 4 5)) '(3 4 5))
(check-equal? (merge '(3) '(4)) '(3 4))
(check-equal? (merge '(4) '(3)) '(3 4))
(check-equal? (merge '(2 3 6) '(1 4 5)) '(1 2 3 4 5 6))

; splitting the list, we need list length

(define (firstHalf L)
  (firstHalf-helper L (quotient (length L) 2))) ; number of elements to keep

(define (firstHalf-helper L num)
  (if (= 0 num)
      '()
      (cons (first L) (firstHalf-helper (rest L) (- num 1)))))

(define (secondHalf L)
  (secondHalf-helper L (quotient (length L) 2))) ; number of elements to get rid of

(define (secondHalf-helper L num)
  (if (= 0 num)
      L
      (secondHalf-helper (rest L) (- num 1))))

(check-equal? (firstHalf '()) '())
(check-equal? (secondHalf '()) '())
(check-equal? (firstHalf '(3)) '())
(check-equal? (secondHalf '(3)) '(3))
(check-equal? (firstHalf '(3 4)) '(3))
(check-equal? (secondHalf '(3 4)) '(4))
(check-equal? (firstHalf '(3 4 5)) '(3))
(check-equal? (secondHalf '(3 4 5)) '(4 5))

; -------------------------- mergeSort

(define (mergeSort L)
  (cond [(null? L) '()]
        [(null? (rest L)) L]
        [ else (merge
         (mergeSort (firstHalf L))
         (mergeSort (secondHalf L)))]))

(trace mergeSort)
         
(check-equal? (mergeSort '()) '())
(check-equal? (mergeSort '(3)) '(3))
(check-equal? (mergeSort '(8 3)) '(3 8))
(check-equal? (mergeSort '(5 4 10 8 1 3)) '(1 3 4 5 8 10))
