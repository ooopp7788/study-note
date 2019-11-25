;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname cons-number) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define NAME 'hello)
;;(define-struct temp (name))

(define (hellos n)
  (cond
    [(zero? n) empty]
    [else (cons 'hello (hellos (- n 1)))]))

(hellos 0)
(hellos 1)
(hellos 3)
