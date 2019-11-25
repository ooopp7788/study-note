;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname cons-transfer) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (hours-to-wages hours)
  (cond
    [(empty? hours) empty]
    [else (cons (* (first hours) 12) (hours-to-wages (rest hours)))]))

(hours-to-wages (cons 5 (cons 8 (cons 12 (cons 22 empty)))))
;;(define hour-cons (cons 5 empty))
(hours-to-wages (cons 5 empty))