#lang sicp
(define (cons-stream a b)
  ;; delay cdr 部分
  ;; 在真正 stream-cdr 调用时, 使用 force 方法取值
  (cons a (delay b)))
;; delay实现: 包裹一层函数, 实现延迟
(define (delay b)
  (lambda ()
    (b)))
;; force实现: 调用一次 delay 返回的lambda函数
(define (force f)
  (f))

(define (stream-car))

(define (stream-cdr))

(define the-empty-stream)

(define (stream-null?))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s (- n 1)))))

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s)) (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s) (stream-for-each display-line s))
(define (display-line x) (newline) (display x))

;; eg:
(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      ;; cdr 部分 延迟求值
      (cons-stream low (stream-enumerate-interval (+ low 1) high))))