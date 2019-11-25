;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname bst-count) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
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