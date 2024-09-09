#lang racket

#|

The "binary tree" type which consists of integers is defined with two structs:

(struct node (left num right) #:transparent)
(struct empty () #:transparent)

a) Implement function "forall" which takes in two parameters: function f and
a binary tree s. This function needs to evaluate to #f if and only if there
exists a number e in the tree s for which f(e) is evaluated to #f. If s is
an empty tree, then the function is evaluated to #t.

b) Using the function "forall", implement a function "all_in_range" which
takes in two numbers a and b and a tree s. It should evaluate to #t if all
the numbers in the tree belong in an interval [a,b].

c) Using the function "forall", implement a function "num_nodes" which takes
in a tree s and returns the number of nodes in that tree.

|#