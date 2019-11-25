;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname polygon) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
;;画布
(start 300 300)
(define PLOYGON-POSN (cons (make-posn 50 50) (cons (make-posn 50 70) (cons (make-posn 70 40) empty))))
;;获取posn-list的最后一个元素posn
(define (last posn-list)
  (cond
    [(empty? (rest posn-list)) (first posn-list)]
    [else (last (rest posn-list))]))
;;(last PLOYGON-POSN)

;;连线
(define (connect-dot posn-list)
  (cond
    [(empty? (rest posn-list)) true]
    [else (and (draw-solid-line (first posn-list) (second posn-list) 'RED)
               (connect-dot (rest posn-list)))]))
;;(connect-dot PLOYGON-POSN)

;;绘制多边形
(define (draw-polygon posn-list)
  (connect-dot (cons (last posn-list) posn-list)))

(draw-polygon PLOYGON-POSN)