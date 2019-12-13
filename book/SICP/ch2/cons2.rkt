#lang sicp
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (x y) x)))

(define (cdr z)
  (z (lambda (x y) y)))

(define c1 (cons 'first 'second))

(car c1)

(cdr c1)