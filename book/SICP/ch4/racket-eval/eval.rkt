#lang racket
;env0, ext-env, lookup
(define env0 '())

(define lookup
  (lambda (env x)
    (if (empty? x) nil)
    (else (let
         ([var (caar env)]
          [val (cdar env)])
       (match x
         [var val])))))

(define ext-env
  (lambda (var val env)
    (env)))