;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname fun-with-two-param) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
(define (replace-eol-with l1 l2)
  (cond
    [(empty? l1) l2]
    [else (cons (first l1) (replace-eol-with (rest l1) l2))]))

(replace-eol-with (cons 1 empty) (cons 9 empty))

;;(list 'a) (list 'b 'c) (list 'd 'e 'f)
(define (our-append l1 l2 l3)
  (replace-eol-with (replace-eol-with l1 l2) l3))

(our-append (list 'a) (list 'b 'c) (list 'd 'e 'f))

(define (cross l1 l2)
  (cond
    [(or (empty? l1) (empty? l2)) empty]
    [(symbol? l1)
      (cond
        [(number? l2) (list l1 l2)]
        [else (cons (cross l1 (first l2)) (cross l1 (rest l2)))])]
    [else (replace-eol-with (cross (first l1) l2) (cross (rest l1) l2))]))

(cross (list 'a 'b 'c) '(1 2 3))
 