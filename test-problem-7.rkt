#lang racket

#|

Implement a macro "partial" which takes in an expression "call" that lacks
its last argument. The call of macro "partial" returns a function which takes
in one parametar x and returns the result of the evaluation "call" whose
parameters are expanded with parameter x at the end. For example, call
"(define add_ten (partial (+ 5 5))" defines a function "add_ten" equivalent
to "(lambda (x) (+ 5 5 x))". Or, for example, call "(define eq_ten (partial (equal? (+ 5 5))))"
defines a function "eq_ten" equivalent to "(lambda (x) (equal? (+ 5 5) x))".

Hint: It is possible to concatenate two quote expressions by using the append
function. For example, "(append (quote (+ 2 3)) (quote (4 5))" results in "(quote (+ 2 3 4 5))".

|#