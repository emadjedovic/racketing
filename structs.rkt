#lang racket

(define-struct card (type value))
(define demo (make-card 'hearts 7))

; procedures
card-type
card-value

demo
(card-type demo)
(card-value demo)

(define (create-card type value)
  (make-card type value))

(equal? (create-card 'hearts 7) demo) ; #f
(equal? (card-type demo) (card-type (create-card 'hearts 7))) ; #t
(equal? (card-value demo) (card-value (create-card 'hearts 7))) ; #t

; by default, structs are immutable

(struct song (title album artist))
(define my-song (song "Do I Wanna Know?" "AM" "Arctic Monkeys"))
(song-title my-song)
(song-album my-song)
(song-artist my-song)

; explicitly declare a struct to be mutable

(struct rgb-color (red green blue) #:mutable)
(define my-color (rgb-color 144 0 32))
(rgb-color-red my-color)

#|
the Racket system writes getter and setter methods to access and change structure attribute values
also generates a constructor function with the structure name
if we don’t add #:mutable to a struct definition, then no set-NAME-ATTRIBUTE! methods are generated
|#

(struct person (name age email) #:mutable)
(define dino (person "Dino" 26 "dino@gmail.com"))
(displayln "Dino age...")
(person-age dino)
(set-person-age! dino 27)
(displayln "Dino age...")
(person-age dino)

; classes and objects

(define fish%
  (class object%
    (init size)
    (super-new)
    ; attribute
    (define current-size size)
    ; public methods
    (define/public (get-size)
      current-size)
    (define/public (grow-by x)
      (set! current-size (+ x current-size)))
    (define/public (eat other-fish)
      (grow-by (send other-fish get-size))))) ; send for calling methods

(define john
  (new fish% [size 10]))
    
(send john get-size)
(send john grow-by 6)
(send john get-size)

; another class

(define (add-color c%)
  (class c%
    (init color)
    (super-new)
    ; attribute
    (define my-color color)
    ; method
    (define/public (get-color) my-color)))

(define colored-fish% (add-color fish%))
(define john2 (new colored-fish% [size 10] [color 'orange]))
(send john2 get-color)


