#lang sicp
;; cons, car, cdr 的一种实现
(define (cons x y)
  (define (dispatch n)
    (cond ((= n 0) x)
          ((= n 1) y)))
  dispatch)

(define (car m) (m 0))
(define (cdr m) (m 1))

(define c1 (cons 'first 'second))
(display c1) ;; cons 返回一个过程 procedure
(newline)
(car c1)
(cdr c1)

