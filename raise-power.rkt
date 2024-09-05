#lang racket

(define (my-delay f)
 (mcons #f f))

(define (my-force par)
  (if (mcar par) (mcdr par)
      (begin
        (set-mcar! par #t)
        (set-mcdr! par ((mcdr par))) ; value
        (mcdr par))
      ))

(define i 0)
(define increment
  (lambda ()
    (set! i (add1 i))
    i))
(define i++
  (my-delay increment))

(displayln i)
(displayln (mcar i++))
(displayln (my-force i++))
(displayln (mcar i++))
(displayln (my-force i++))
(displayln (my-force i++))
(displayln (string-append "value of i: " (number->string i)))

(define (raise-power evaluate k)
  (cond
    [(= k 0) 1]
    [(= k 1) (my-force evaluate)] ; dont evaluate twice?
    [#t (let* ([half (raise-power evaluate (quotient k 2))]
               [result (* half half)])
               (if (= 1 (remainder k 2))
                   (* result (my-force evaluate))
                   result))]))

(define delay-evaluate
  (my-delay (lambda () (begin (displayln "calling...") 2))))

(raise-power delay-evaluate 5)
(raise-power delay-evaluate 5)
(raise-power delay-evaluate 6)

                      
                   
