;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname abstract-fun) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;(define (fold operate start-number list-of-number)
;;  (cond
;;    [(empty? list-of-number) start-number]
;;    [else (fold operate (operate start-number (first list-of-number)) (rest list-of-number))]))

;;(fold + 0 (list 1 3 5))
;;(fold * 1 (list 1.1 3 5))

;;append
(define (add-item lon item)
  (cond
    [(empty? lon) (cons item empty)]
    [else (cons (first lon) (add-item (rest lon) item))]))
(define (my-append operate lon1 lon2)
  (cond
    [(empty? lon2) lon1]
    [else (my-append operate (operate lon1 (first lon2)) (rest lon2))]))

;;(add-item (list 1 2 3) 4)
(my-append add-item (list 1 2 3) (list 4 5 6))