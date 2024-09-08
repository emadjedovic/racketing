#lang racket

(define-syntax-rule (when condition body ...)
  (if condition
      (begin body ...)
      '()))  ;; Provide an else branch))
(when (> 3 2)
  (displayln "3 is greater than 2"))

(define-syntax-rule (unless condition body ...)
  (if (not condition)
      (begin body ...)
      '()))
(unless (> 1 2)
  (displayln "1 is not greater than 2"))

; a) (ako e1 onda e2 inače e3)

(define-syntax my_if
  (syntax-rules (ako onda inače) ; keywords
    [(my_if ako e1 onda e2 inače e3) (if e1 e2 e3)]
    [(my_if e2 ako e1 inače e3) (if e1 e2 e3)]
    [(my_if e1 e2 e3) (if e1 e2 e3)]
    ))

(define temp 30)
(my_if "Ljeto je." ako (> temp 25) inače "Nije ljeto.")
(my_if ako (> temp 25) onda "Ljeto je." inače "Nije ljeto.")
(my_if (> temp 25) "Ljeto je." "Nije ljeto.")

; b) (my-delay e) equivalent to (mcons #f (lambda () e))

(define (my-delay-bad e) (mcons #f (lambda () e))) ; evaluates immediately
(my-delay-bad (begin (print "Hi there.") 10))

(define-syntax my-delay
  (syntax-rules () ; no keywords
    [(my-delay e) (mcons #f (lambda () e))]))

(my-delay (begin (print "Hi there.") 10)) ; isn't immediately evaluated

; c) (for lo to hi do body) simulating the for loop

(define-syntax for
  (syntax-rules (to do) ; keywords
    [(for lo to hi do body)
     (letrec ([helper (lambda (counter)
                         (if (= counter hi) (body counter) ; end of loop
                             (begin (body counter) (helper (+ counter 1)))))])
       (helper lo))]
    ))

(for 2 to 6 do displayln)

(displayln "Decrementing while greater than...")

(define-syntax while_greater_than
  (syntax-rules (do)
    [(while_greater_than limit do start)
     (letrec ([helper (lambda (current_value) (
                            if (<= current_value limit) "END"
                            (begin 
                              (displayln current_value)
                              (helper (- current_value 1))
                              )
                            ))
              ])
              
       (helper start))]))


(while_greater_than 8 do 20)
