#lang sicp
(define (eval exp env)
  (cond
    ;; 自求值表达式: 值
    ((self-evaluating? exp) exp)
    ;; 变量
    ((variable? exp) (lookup-variable-value exp env))
    ;; 被引用值
    ((quoted? exp) (text-of-quotation exp))
    ;; 赋值语句
    ((assignment? exp) (eval-assignment exp env))
    ;; 定义语句
    ((definition? exp) (eval-definition exp env))
    ;; if 语句
    ((if? exp) (eval-if exp env))
    ;; lambda 函数
    ((lambda? exp) (make-procedure (lambda-parameters exp) (lambda-body exp) env))
    ;; begin 语句
    ((begin? exp) (eval-sequence (begin-actions exp) env))
    ;; cond 条件语句
    ((cond? exp) (eval (cond->if exp) env))
    ;; 过程应用
    ((application? exp) (apply (eval (operator exp) env) (list-of-values (operands exp) env)))
    (else (error "Unknown expression type -- EVAL" exp))))
;; 各种表达式类型判断
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
(define (variable? exp) (symbol? exp))

;; if 表达式
;; 先求值条件表达式
(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))
;; 赋值和定义: 先求值，将改变 env 留给下级处理
;; 赋值
(define (eval-assignment exp env)
  (set-variable-value! (eval (assignment-variable exp) env)
                       (eval (assignment-value exp) env)
                       env)
  'ok)
;; 定义
(define (eval-definition exp env)
  (define-variable! (eval (definition-variable exp) env)
                       (eval (definition-value exp) env)
                       env)
  'ok)
;; begin
(define (eval-sequence exps env)
  (cond
    ;; 最后一个 exp 返回执行值
    ((last-exps? exps) (eval (first-exps exps) env))
    ;; 其他前面的 exp 仅执行，舍弃返回值
    (else (eval (first-exps exps))
          (eval-sequence exps env))))
