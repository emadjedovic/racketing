#lang racket

#|

We define stream as a thunk, which when called returns a pair where the cdr
of that pair is again a stream, and car of that pair is some value we generate.

a) Implement a stream which generates numbers of this form:
(-1)^k * (4k+1) for all k=1,2,3... .

b) Implement a function "enumerate" which takes in a stream s whose elements
are arbitrary, and returns a new stream v. If the stream produced an element
e on the position "i", then stream v should produce a pair (i, e) on the same
position "i". Test the function with stream from part a). Indexing starts at i=0.

c) Implement a function "greater_than_previous" which takes in stream s and
returns a stream v which consists of all the elements from s that are greater
than all the previous elements from stream s. Test the function with a stream from part a).

|#