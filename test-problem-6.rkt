#lang racket

#|

An array of Tribonacci numbers is defined as a0=0, a1=0, a2=1 and
ai=a(i-1)+a(i-2)+a(i-3) for all i>=3. Implement a function "calculate_Tribonacci"
which takes in a natural number n and returns nth element of the "a_n" array.
Use principle of memoization when implementing. Next, implement function
"first_N_Tribonacci which takes in natural numbers n and k. It creates and
returns a thunk using delay methods. The thunk contains a list of the first n
members of the array that are greater than k. The thunk returned by the function
should be able to evaluate to a common list using force method.

|#