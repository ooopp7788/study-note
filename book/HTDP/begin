;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Untitled) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;利润 = 票房 - 成本
(define (profile revenue costs)
  (- revenue costs))
;;票房
(define (revenue price people)
  (* price people))
;;成本
(define (costs people)
  (* 0.04 people))
;;观众数/票数
(define (ticket price)
  (+ 120 (* 15 (- 5 price))))

;;main
(define (main price)
  (- (revenue price (ticket price)) (costs (ticket price))))

(main 7.3)