;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname file-directory) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct file(name size))

;;子文件
(define part1 (make-file 'part1 99))
(define part2 (make-file 'part2 52))
(define part3 (make-file 'part3 17))
(define hangs (make-file 'hang8 8))
(define draws (make-file 'draw 2))
(define read1 (make-file 'read1 19))
(define read2 (make-file 'read2 10))
;;子目录
(define Code (list hangs draws))
(define Docs (list read1))
(define Libs (list Code Docs))
(define Text (list part1 part2 part3))
;;根目录
(define TS (list read2 Text Libs))

(define (how-many dir)
  (cond
    [(empty? dir) 0]
    [(file? dir) (file-size dir)]
    [else (+ (how-many (first dir)) (how-many (rest dir)))]))

(how-many TS)
(+ 99 52 17 8 2 19 10)