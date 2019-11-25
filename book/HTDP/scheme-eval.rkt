;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname scheme-eval) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "draw.rkt" "teachpack" "htdp")) #f)))
(define-struct add (left right))
(define-struct mul (left right))

;;(+ (* 3.14 (* o o)) (* 3.14 (* 1 1)))
;;(+ (* 3.14 (* 5 5)) (* 3.14 (* 1 1)))
(define SCHEME1 (make-add (make-mul 3.14 (make-mul 'o 'o)) (make-mul 3.14 (make-mul 1 1))))
(define SCHEME2 (make-add (make-mul 3.14 (make-mul 5 5)) (make-mul 3.14 (make-mul 1 1))))

;;是否是数字
(define (numeric? scheme)
  (cond
    [(number? scheme) true]
    [(add? scheme) (and (numeric? (add-left scheme)) (numeric? (add-right scheme)))]
    [(mul? scheme) (and (numeric? (mul-left scheme)) (numeric? (mul-right scheme)))]
    [else false]))
;;(numeric? SCHEME1)
;;(numeric? SCHEME2)

;;eval expression
(define (evaluate-expression scheme)
  (cond
    [(numeric? scheme)
     (cond
       [(add? scheme) (+ (evaluate-expression (add-left scheme)) (evaluate-expression (add-right scheme)))]
       [(mul? scheme) (* (evaluate-expression (mul-left scheme)) (evaluate-expression (mul-right scheme)))]
       [else scheme])]
    [else 'ERROR]))
;;(evaluate-expression SCHEME1)
;;(evaluate-expression SCHEME2)
;;(* 3.14 26)

;;eval function
;;symbol: var, number: num, scheme-expression: scheme
(define (subst var num scheme)
  (cond
    [(and (symbol? scheme) (symbol=? var scheme)) num]
    [(add? scheme) (+ (subst var num (add-left scheme)) (subst var num (add-right scheme)))]
    [(mul? scheme) (* (subst var num (mul-left scheme)) (subst var num (mul-right scheme)))]
    [else scheme]))
(subst 'o 5 SCHEME1)
(* 3.14 26)



