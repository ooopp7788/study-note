#lang sicp
;; wire 导线数据结构 构造方法
(define (make-wire)
  ())
(define (get-signal wire)
  ())
(define (set-signal! wire)
  ())
;; 会在wire改变时执行指定过程(proc), 注册观察者
(define (add-action wire proc)
  ())
;; 执行过程
(define (after-delay proc argv)
  (proc argv))


;; 门电路
(define (or-gate in1 in2 out)
  ())

(define (and-gate in1 in2 out)
  ())

(define (inverter in out)
  (define (inverter-input)
    (let ((new-value (logic-not (get-signal input))))
      (after-delay inverter-input new-value))))

(define a (make-wire))
(define b (make-wire))
(define c (make-wire))
(define s (make-wire))

(define (half-adder a b s c) ;; 建立过程抽象(实现功能块抽象)
  (let ((d (make-wire)) (e (make-wire))) ;; 内部连线
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
'ok))