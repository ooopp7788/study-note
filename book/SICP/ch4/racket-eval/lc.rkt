#lang sicp
;; 一个递归
(define length
  (lambda (l)
    (cond ((null? l) 0)
          (else (+ 1 (length (cdr l)))))))

;; 抽象 length 作为参数传入
(define length1
  (lambda (g)
    (lambda (l)
      (cond ((null? l) 0)
            (else (+ 1 ((g g) (cdr l))))))))
; ((length1 length1) '(a))

;; 自调用(g g)抽象
(define length2
  (lambda (g)
    ;;; 为了抽离出 length 函数的本质, 将依赖的 f 抽离
    ;;; 得到 (lambda (q) (...)) 的抽象
    (lambda (x)
      (((lambda (q)
         (lambda (l)
           (cond ((null? l) 0)
              (else (+ 1 (q (cdr l)))))))
       (g g))
       x))))
; ((length2 length2) '(a b c))

;; (lambda (q) (...)) 抽象 为 f
(define Y
  (lambda (f)
    ((lambda (h) (h h))
     (lambda (g)
       (lambda (x)
         ((f (g g)) x))))
    ))
((Y (lambda (q)
             (lambda (l)
               (cond ((null? l) 0)
                     (else (+ 1 (q (cdr l)))))))) '(1 2 3 4))



