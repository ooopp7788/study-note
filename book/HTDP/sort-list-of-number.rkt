;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname sort-list-of-number) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;数字插入有序列表
(define (insert num order-list)
  (cond
    [(empty? order-list) (cons num empty)]
    [(>= num (first order-list)) (cons num order-list)]
    [else (cons (first order-list) (insert num (rest order-list)))]))
;;(insert 5 (cons 8 (cons 5 (cons 3 empty))))

;;排序
(define (sort-number number-list)
  (cond
    [(empty? number-list) empty]
    [else (insert (first number-list) (sort-number (rest number-list)))]))

(sort-number (cons 1.33 (cons 8 (cons 3.24 (cons -1.5 (cons 1.2 (cons -1.1 empty)))))))

