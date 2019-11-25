;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname GUI) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp") (lib "gui.rkt" "teachpack" "htdp")) #f)))
(define a-text-field
  (make-text "Enter Text:"))
(define a-message
  (make-message "`Hello World' is a silly program."))

(define (echo-message e)
  (draw-message a-message (text-contents a-text-field)))

(create-window
 (list (list a-text-field a-message)
       (list (make-button "Copy Now" echo-message))))