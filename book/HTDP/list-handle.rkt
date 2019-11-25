;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname list-handle) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct family-tree-node (father mother name year eye))

;; 老一代人:
(define Carl (family-tree-node empty empty 'Carl 1926 'green)) (define Bettina (make-child empty empty 'Bettina 1926 'green))
;; 中间一代人:
(define Adam (family-tree-node Carl Bettina 'Adam 1950 'yellow)) (define Dave (make-child Carl Bettina 'Dave 1955 'black)) (define Eva (make-child Carl Bettina 'Eva 1965 'blue)) (define Fred (make-child empty empty 'Fred 1966 'pink))
;; 年轻一代人:
(define Gustav (make-child Fred Eva 'Gustav 1988 'brown))
'(())