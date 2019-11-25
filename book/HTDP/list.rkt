;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname cons) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define (contain-doll a-cons doll)
  (cond
   [(symbol=? (first a-cons) doll) true]
   [(empty? (rest a-cons)) false]
   [else (rest a-cons)]))

(define (if-contains-doll a-cons doll)
  (cond
   [(boolean? (contain-doll a-cons doll)) (contain-doll a-cons doll)]
   [else (if-contains-doll (contain-doll a-cons doll) doll)]))

(define a-cons (cons 'toys (cons 'car (cons 'robot (cons 'game empty)))))

(if-contains-doll a-cons 'robot1)
