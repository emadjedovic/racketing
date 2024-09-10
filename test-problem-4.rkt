#lang racket

#|

The "binary tree" type which consists of integers is defined with two structs:

(struct node (left num right) #:transparent)
(struct empty () #:transparent)

a) Implement function "forall" which takes in two parameters: function f and
a binary tree t. This function needs to evaluate to #f if and only if there
exists a number e in the tree t for which f(e) is evaluated to #f. If s is
an empty tree, then the function is evaluated to #t.

b) Using the function "forall", implement a function "all_in_range" which
takes in two numbers a and b and a tree t. It should evaluate to #t if all
the numbers in the tree belong in an interval [a,b].

c) Using the function "forall", implement a function "num_nodes" which takes
in a tree t and returns the number of nodes in that tree.

|#

(struct node (left num right) #:transparent)
(struct empty () #:transparent)

(define (forall f t)
  (cond [(empty? t) #t]
        [(node? t)
         ; recursively check the left subtree
         ; apply function to the middle num
         ; recursively check the right subtree
         ; all three must be #t
         (and (forall f (node-left t)) (f(node-num t)) (forall f (node-right t)))
         ]
        ))

(define (all_in_range a b t)
  (forall (lambda (num) (and (>= num a) (<= num b))) t))

(define (num_nodes t)
  ; input a function into forall that returns true for all nodes
  ; count recursive calls
  (let ([counter (box 0)]) ; using a mutable box to store the count (mutation of regular variables)
    (forall (lambda (_) 
              (set-box! counter (+ 1 (unbox counter))) ; increment the counter for each node
              #t) ; always return true for forall
            t)
    (unbox counter)))

(displayln "TESTING...")

(define empty-tree (empty))
(define node-2 (node (empty) 2 (empty)))
(define node-7 (node (empty) 7 (empty)))
(define testing-tree
  (node node-2 5 node-7))

(displayln "FOR ALL...")

(forall (lambda (node) (> node 0)) empty-tree)
(forall (lambda (node) (> node 0)) node-2)
(forall (lambda (node) (> node 7)) node-7)
(forall (lambda (node) (> node 8)) testing-tree)

(displayln "ALL IN RANGE...")

(all_in_range 1 10 empty-tree)
(all_in_range 1 10 node-2)
(all_in_range 1 10 node-7)
(all_in_range 1 6 testing-tree)

(displayln "NUM NODES...")

(num_nodes empty-tree)                          
(num_nodes node-2)
(num_nodes node-7)
(num_nodes testing-tree)