#lang racket

#|

Any code in Racket that uses a cond call can be replaced with a nested one if calls. For example the code 

(cond	[(> x 3) x]
	[(= x 2) (+ x 1)]
	[#t 4]) 

can be replaced with the equivalent code 

(if (> x 3) x
	(if (= x 2) (+ x 1)
		4))

Implement a macro my-cond that converts an expression using cond syntax into an equivalent expression
which uses nested if statements. You can assume that the last branch in the cond expression has the condition #t.
Why is it necessary to implement my-cond defined in this way using macros, and not as a function?

|#

(define-syntax my_cond
  (syntax-rules () ; keywords
     ; the first clause
    [(my_cond [condition action] [condition2 action2] ...)
     (if condition action
         (my_cond [condition2 action2] ...))]
    ; the last branch with condition #t
    [(my_cond [#t action]) action]
    ))


; macros operate at compile-time, modifies/generates the code before it runs
; functions operate at runtime, would only process values - not the code structure
; ellipsis ... - the preceding pattern element can appear zero or more times

(define x 1)
(displayln "Testing...")
(cond	[(> x 3) x]
	[(= x 2) (+ x 1)]
	[#t 4]) 