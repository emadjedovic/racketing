#lang racket
(require racket/trace)

; (foldr/foldl func init L)
; function, initial value, list

(foldr + 0 '(1 2 3)) ; 3+0, 3+2, 5+1 -- 6
(foldl + 0 '(1 2 3)) ; 1+0, 2+1, 3+3 -- 6

(foldr cons '() '(1 2 3)) ; '(3), cons 2 '(3), cons 1 '(2 3), '(1 2 3)
(foldl cons '() '(1 2 3)) ; '(3 2 1)

(foldr list 42 '(1 2 3)) ; list 3 42, list 2 '(3 42), list 1 '(2 (3 42)), '(1 (2 (3 42)))
(foldl list 42 '(1 2 3)) ; list 1 42, list 2 '(1 42), list 3 '(2 (1 42)), '(3 (2 (1 42)))

; ------- first - last
; ------- rest - butlast

(define (last L)
  (if  (null? (rest L))
       (first L)
       (last (rest L))))

(define (butlast L)
  (if (null? (rest L))
      '() ; only one element, thats the last one
      (cons (first L) (butlast (rest L)))))

(last '(88 61 74 90 82 -2 -33))
(butlast '(88 61 74 90 82 -2 -33))

; -------- fold implementation

; use first and rest
(define (myFoldR func init L)
  (if (null? L)
      init
      (func (first L)
             (myFoldR func init (rest L)))))

; use last and butlast
(define (myFoldL func init L)
  (if (null? L)
      init
      (func (last L)
            (myFoldL func init (butlast L)))))

(myFoldR cons '() '(1 2 3)) ; '(1 2 3)
(myFoldL cons '() '(1 2 3)) ; '(3 2 1)

(myFoldR list 42 '(1 2 3)) ; '(1 (2 (3 42)))
(myFoldL list 42 '(1 2 3)) ; '(3 (2 (1 42)))

; ---------- smush (concatenates all of the lists of a bigger list)

(define (smush L)
  (foldr append '() L))

(smush '((1 2 3) (4 5) (6 7 8 9))) ; '(1 2 3 4 5 6 7 8 9)
(smush '((1) (2) ((((3 4)))) (5))) ; '(1 2 (((3 4))) 5)

; removes only outer parentheses


  

