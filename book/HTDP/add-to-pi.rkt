;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname add-to-pi) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;不使用+运算
(define PI 3.14)
(define (add-to-pi n)
  (cond
    [(zero? n) PI]
    [else (add1 (add-to-pi (sub1 n)))]))

(add-to-pi 5)