;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Untitled) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
;; 偶数列
(define (make-even n)
  (* 2 n))
;; 等差数列
(define (q constant n begin)
  (+ begin (* constant n)))

(define (sum n fn)
  (cond
    [(= n 0) (fn n)]
    [else (+ (fn n) (sum (- n 1) fn))]
   ))

;;(sum 5 make-even)
