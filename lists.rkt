#lang racket

(first '("spam" "is" "awesome"))
(rest '("spam" "is" "awesome"))
(first '("spam"))
(rest '("spam"))

(append '(1 2 3) '(4 5 6))
(list '(1 2 3) '(4 5 6))
(list 1 2 3 4 5 6)
(append '(1 2) '(3 4) '(5 6))

(define (keepEvenNumbers myList)
  (cond
    [(null? myList) '()]
    [(= 1 (modulo (first myList) 2)) ; odd
     (keepEvenNumbers (rest myList))]
    [else ; even
     (cons (first myList) (keepEvenNumbers (rest myList)))]))

(keepEvenNumbers '(1 2 3 4 5 6 7 8 9 10))

(define (incrementAll myList)
  (if (null? myList)
      '()
      (cons (+ 1 (first myList)) (incrementAll (rest myList)))))

(incrementAll '(10 11 12)) ; 12 13 14

;-------------------------- copy, remove, reverse

(define (copy L)
  (if (null? L) '()
      (cons (first L) (copy (rest L)))))

(define A '(1 2 3))

(define CopyA (copy A))

A
CopyA

(equal? A CopyA) ; #t
(eq? A CopyA) ; #f
; (= A CopyA) -- expects numbers, not lists

(define (remove x L)
  (cond [(null? L) '()]
        [(equal? (first L) x) (rest L)]
      [else (cons (first L) (remove x (rest L)))]))

(remove 42 '())
(remove 42 '(42))
(remove 42 '(1 42 42 3))
(remove "remove-me" '(3 "remove-me" "rose" #t)) ; because we used "equal" instead of "="

(define (reverse L)
  (cond [(null? L) '()]
        [(null? (rest L)) L] ; perhaps redundant
        [else (append (reverse (rest L)) (list (first L)))]))

(reverse '()) ; '()
(reverse '("single element"))
(reverse '(1 2 3)) ; (3 2 1)

; ---------------------------- flattening

(define (flatten L)
  (cond [(null? L) '()]
        [(list? (first L))
         (append (flatten (first L)) (flatten (rest L)))] ; rest L is always a list
        [else (cons (first L) (flatten (rest L))) ])) ; for example (cons 1 '())

(flatten '()) ; '()
(flatten '("one")) ; '("one")
(flatten '((((("one")))))) ; '("one")
(flatten '( (("one") "two") "three"))
; '("one" "two" "three") -- flattens first, flattens rest and appends?

; -------------------------- sublists

(define (sublists L)
  (if (null? L)
      '(())
      (let* ( [e (first L)] ; let* allows later uses of variable e
             [without-e (sublists (rest L))]
             [with-e (map (lambda (sublist) (cons e sublist)) without-e)]) ; map takes in a function and a list
            
      (append without-e with-e))
      ))
        

(sublists '()) ; '(())
(sublists '(b)) ; '((), (b)) -- takes an empty list and cons b to it
(sublists '(b c)) ; '((), (b), (c), (b c))
(sublists '(a b c)) ; '((), (b), (c), (b c), (a), (a b), (a c), (a b c))

; car: "Contents of the Address part of the Register"
; cdr: "Contents of the Decrement part of the Register"

(define (sumList L)
  (if (empty? L) 0
      (+ (car L) (sumList (cdr L)))))

(sumList '(3 3 3 3 4 4 1))


; --- implementing cons without built-in


; procedure
(define (cons-L F R)
  (lambda (string)
    (cond [(equal? string "first") F] ; element
          [(equal? string "rest") R] ; always a list
          [else "ERROR"])))

(define myProcedure (cons-L 12 '(13 14 15 16)))
(myProcedure "first") ; 12
(myProcedure "rest") ; '(13 14 15 16)

(define (my-first f)
  (f "first"))

(define (my-rest f)
  (f "rest"))

(my-first myProcedure)
(my-rest myProcedure)

(define z (cons-L 1 (cons-L 2 (cons-L 3 '()))))
z ; still a procedure

; ---------------------------- dots

(cons 1 2) ; a pair '(1 . 2) -- when the second argument is not a list
(cons 1 '()) ; still a pair '(1 . ()) but written as '(1)
(cons 1 '(2)) ; '(1 2) actually (cons 1 (cons 2 '()))
