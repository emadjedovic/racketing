#lang racket

; (
; (2 ((0 . 1) (1 . 2) (2 . 4) (3 . 8) (4 . 16)...))
; (3 ((0 . 1) (1 . 2) (2 . 9) (3 . 27) (4 . 81)...))
; ...)

(define memo '())  ; Start with an empty list for memoization

(define (check-memo n k)
  (let ([n-row (assoc n memo)])
    (if n-row (assoc k (cdr n-row)) #f)))

        
(define (add-to-memo n k result)
  (let ([n-row (assoc n memo)])
    (if n-row
        ; replace the old row
        (let ([new-n-row (cons n (cons (cons k result) (cdr n-row)))])
        (set! memo (cons new-n-row (remove n-row memo))))
        ; add new row and new value in it
        (set! memo (cons (cons n (list (cons k result))) memo))))) ; list because its only one element


(define (raise-power-memo n k)
  (cond
    [(= 0 k) 1]
    [(= 1 k) n]
    [#t (let* ([existing (check-memo n k)])  ; check if memoized
          (if existing
              (cdr existing)  ; return memoized
              (let* ([half (raise-power-memo n (quotient k 2))]
                     [result (* half half)]
                     [final-result (if (= 1 (remainder k 2)) (* n result) result)])
                (add-to-memo n k final-result)  ; memoize
                final-result)))]))

(raise-power-memo 2 5)
(raise-power-memo 3 4)
(raise-power-memo 2 4)

