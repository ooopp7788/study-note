#lang sicp
;; church 计数: 用过程表示数
(define zero (lambda (f) (lambda (x) x)))
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
;; 定义 one two 提示 带入计算(add-1 zero)
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
;; 定义 + 法, 不要通过反复应用 add-1 实现
(define (+ a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))


;; Y组合子
(define Y (lambda (y) ((lambda (x) (y (x x)))
                       (lambda (x) (y (x x))))))
;; (Y Y) = (Y (Y Y))
;; (Y Y)
((lambda (x) (Y (x x))) (lambda (z) (Y (z z))))
;; β规约: lambda (z) (Y (z z)) 带入 (lambda (x) (Y (x x))) 中的x
;; 得 (Y (Y Y)) = (Y Y)
(Y ((lambda (z) (Y (z z))) (lambda (z) (Y (z z))))) ;; (Y (Y Y))
