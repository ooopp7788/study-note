;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname circle-animate) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define a 100)
(define-struct circle (x y r))

(define (draw-a-circle circle)
  (draw-circle (make-posn (circle-x circle) (circle-y circle)) (circle-r circle)))

(define (clear-a-circle circle)
  (draw-circle (make-posn (circle-x circle) (circle-y circle)) (circle-r circle) 'white))

(define (transfer-circle circle delta-x)
  (make-circle (+ (circle-x circle) delta-x) (circle-y circle) (circle-r circle)))

(define (move-circle circle delta-x)
  (cond
    [(clear-a-circle circle) (draw-a-circle (transfer-circle circle delta-x))]))

(define (move-circle-from-start-to-destination circle-start circle-destination)  
  (cond
    [(>= (+ (circle-x circle-start) 5) (circle-x circle-destination)) (move-circle circle-start 5)]
    [else false])
  )

(start 300 300)
;;(draw-a-circle (make-circle 20 20 10))
;;(clear-a-circle (make-circle 20 20 10))
(move-circle-from-start-to-destination (make-circle 20 20 10) (make-circle 280 280 10))
