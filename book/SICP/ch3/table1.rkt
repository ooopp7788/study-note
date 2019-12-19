#lang sicp
(define TABLE (list '*table* (list 'a 1) (list 'b 2) (list 'c 3)))

(define (look key table)
  (let ((record (assoc key (cdr table))))
  (if record (cdr record) false)))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

;; (look 'c TABLE)

(define (insert! key value table)
  (let ((record (look key table)))
  (if record
      (set-cdr! table value)
      (set-cdr! table (cons (cons key value) (cdr table))))))

(insert! 'd 4 TABLE)