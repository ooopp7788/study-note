;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname web-page) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define WEB '(ROOT0
              ROOT1
              (R1-1 R1-2)
              ROOT2
              (R2-1 R2-2)))
(define (size web-page)
  (cond
    [(empty? web-page) 0]
    [(symbol? (first web-page)) (+ 1 (size (rest web-page)))]
    [else (+ (size (first web-page)) (size (rest web-page)))]))

WEB
(size WEB)