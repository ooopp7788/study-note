;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname sturct-quote) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct parent(children name birthday eye))

;; 年轻一代人:
(define Gustav (make-parent empty 'Gustav 1988 'brown))
(define Fred&Eva (list Gustav))
;; 中间一代人:
(define Adam (make-parent empty 'Adam 1950 'yellow))
(define Dave (make-parent empty 'Dave 1955 'black))
(define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
(define Fred (make-parent Fred&Eva 'Fred 1966 'pink))
(define Carl&Bettina (list Adam Dave Eva))
;; 老一代人:
(define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
(define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))

(define (blue-eyed-descendant? parent)
  (cond
    [(empty? parent) true]
    [(list? parent) (and (symbol=? (parent-eye (first parent)) 'blue) (blue-eyed-descendant? (rest parent)))]
    [else (and (symbol=? (parent-eye parent) 'blue) (blue-eyed-descendant? (parent-children parent)))]))

(blue-eyed-descendant? Bettina)