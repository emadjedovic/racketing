#lang racket

; removing first half of natural number list L

(define (remove-helper L to_remove)
  (if (>= to_remove (length L)) L ; removed half
      (remove-helper (remove to_remove L) (+ to_remove 1))))

(define (remove-elements L)
  (remove-helper L 1))

(displayln "Removing...")
(remove-elements '(1 2 3 4 5 6 7 8 9 10 11 12))

; find the first missing integer in a sorted list of integers

(define (missing-helper sortedL)
  (cond [(null? (cdr sortedL)) (+ 1 (car sortedL))]
    [(equal? (+ 1 (car sortedL)) (car (cdr sortedL)))
         (missing-helper (cdr sortedL))]
        [else (+ 1 (car sortedL))]))

(define (missing-integer L)
  (missing-helper (sort L <)))

(displayln "Missing integer...")
(missing-integer '(1))
(missing-integer '(1 2 3 5 6 7 8))
(missing-integer '(1 2 3 4 5 6 7 8))

; first missing integer without sorting

(define (checkValue x L)
  (if (member x L) (checkValue (+ 1 x) L) (- x 1)))

(define (missingInteger L)
  (let ([min_value (apply min L)])
    (+ 1 (checkValue min_value L))))

(displayln "Checking for first missing integer...")
(missingInteger '(7 2 9 3 2 2 4 2 11))

; removes every second element from a list
; alternate between #t (remove the element) and #f (keep the element)
; similar procedure for keeping every other element

(define (removeHelper L shouldRemove)
  (cond
    [(null? L) '()]
    [shouldRemove (removeHelper (cdr L) #f)]
    [else (cons (car L) (removeHelper (cdr L) #t))]))

(define (removeEverySecond L)
  (removeHelper L #f))  ; the first element should not be removed

(displayln "Removing every second...")
(removeEverySecond '(1 2 3 4 5 6 7 8 9 10))

; keep every third element (using counter)

(define (keepHelper L counter)
  (cond [(null? L) '()]
        [(= 0 (remainder counter 3)) ; keep
         (cons (car L) (keepHelper (cdr L) (+ 1 counter)))]
        [else (keepHelper (cdr L) (+ 1 counter))]))

(define (keepEveryThird L)
  (keepHelper L 1))

(displayln "Keeping every third...")
(keepEveryThird '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

; remove every n-th element

(define (helper L n counter)
  (if (null? L) L ; reached the end
      (cond  [(= 1 n) '()] ; remove every element
             [(= 0 (modulo counter n)) ; remove element
              (helper (cdr L) n (+ 1 counter))]
             [else (cons (car L) (helper (cdr L) n (+ 1 counter)))])))

(define (removeEveryNth L n)
  (helper L n 1))

(displayln "Removing every nth element...")
(removeEveryNth '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) 1)
(removeEveryNth '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) 2)
(removeEveryNth '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) 4)
(removeEveryNth '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15) 14)

; find the missing integer (the smallest one if there are multiple missing integers)

(define (findSmallestSkippedInteger xs)
  (let* ([sorted_integers (sort xs <)]
         [the_smallest (car sorted_integers)])
    (define (traverse xs the_smallest)
            (if (= (car xs) the_smallest) ; exists
                (traverse (cdr xs) (+ 1 the_smallest))
                the_smallest)) ; skipped (missing)
    (traverse sorted_integers the_smallest)))

(displayln "Finding smallest skipped integer...")
(findSmallestSkippedInteger '(15 11 16 13 12 8 18 7 9 14)) ; 10, then 17

; return the list of elements appearing at least one-third of the total length

(define (occurrences xs n)
  (cond
    [(null? xs) 0]
    [(equal? (car xs) n) (+ (occurrences (cdr xs) n) 1)]
    [else (occurrences (cdr xs) n)]))

(define (function xs)
  (let ([elements_set (remove-duplicates xs)]) ;
    (define (helper elements_all elements_set)
      (cond
        [(null? elements_set) null]
        [(>= (occurrences elements_all (car elements_set)) (/ (length xs) 3))
         (cons (car elements_set) (helper elements_all (cdr elements_set)))]
        [else (helper elements_all (cdr elements_set))]))
    (helper xs elements_set)))

(displayln "Elements appearing 1/3 or more of list length...")
(function (list 1 2 2 2 3 3 3))  ; => (list 2 3)
(function (list 1 2 2 2 2))      ; => (list 2)
(function (list 1 2 3 4 1 1))    ; => (list 1)



