;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname bt-contain) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct node(number name left right))

(define TREE1 (make-node
              15
              'name
              false
              (make-node 26 't false false)))

(define TREE2 (make-node
              15
              'name
              (make-node 88 'h false false)
              false))
;;是否包含一个数
(define (contain-bt tree number)
  (cond
  [(false? tree) false]
  [(= number (node-number tree)) true]
  [else (or (contain-bt (node-left tree) number) (contain-bt (node-right tree) number))]))
;;(contain-bt TREE1 15)
;;(contain-bt TREE1 26)
;;(contain-bt TREE1 88)
;;(contain-bt TREE2 15)
;;(contain-bt TREE2 26)
;;(contain-bt TREE2 88)

;;找到包含数的node
(define (search-bt tree number)
  (cond
  [(false? tree) false]
  [(= number (node-number tree)) tree]
  [(node? (search-bt (node-left tree) number)) (search-bt (node-left tree) number)]
  [(node? (search-bt (node-right tree) number)) (search-bt (node-right tree) number)]
  [else false]))
(search-bt TREE2 88)
