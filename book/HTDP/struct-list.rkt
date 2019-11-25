;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname struct-cons) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct doll (name price))

(define doll-cons
  (cons (make-doll 'doll1 18.01)
    (cons (make-doll 'car1 23.25)
      (cons (make-doll 'toy 8.55) empty))))

(define (sum-price dolls sum)
  (cond
    [(empty? dolls) sum]
    [else (sum-price (rest dolls) (+ sum (doll-price (first dolls))))]))

(sum-price doll-cons 0)
