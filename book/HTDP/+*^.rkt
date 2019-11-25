;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname +*^) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;不使用+运算的求和
(define (sum n m)
  (cond
    [(zero? n) m]
    [else (add1 (sum (sub1 n) m))]))

;;(sum 53 35)

;;不使用*运算的乘积
(define (times n m)
  (cond
    [(zero? n) 0]
    [else (sum m (times (sub1 n) m))]))
;;(times 2 8)

;;乘方运算
(define (sqrts n m)
  (cond
    [(zero? m) 1]
    [else (times n (sqrts n (sub1 m)))]))

(sqrts 2 10)