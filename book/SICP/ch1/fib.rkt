#lang sicp
(define (fib n)
  (define (fib-iter a b counter)
    (cond ((= counter 0) a)
          (else (fib-iter b (+ a b) (- counter 1)))))
  (fib-iter 0 1 n))

(fib 5)

