#lang sicp
;; 表达式求值
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
;; apply 过程应用
(define (apply procedure arguments)
  (cond ((primitive-procedure? procedure)
         ;; 基本过程，直接调用
         (apply-primitive-procedure procedure arguments))
        ;; 复合过程，建立新环境，在新环境求值
        ((compound-procedure? procedure)
         (eval-sequence
          (procedure-body procedure)
          (extend-environment
           ;; 新环境，包括 复合过程参数、当前参数、复合过程环境
           (procedure-parameters procedure)
           arguments
           (procedure-environment procedure))))
        (else
         (error "Unknown procedure type -- APPLY" procedure))))
;; exps 顺序求值
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))

;; 各种表达式类型判断
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
(define (variable? exp) (symbol? exp))
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))
(define (assignment? exp) (tagged-list? exp 'set!))
(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))
;; 2种定义表达式
;; 1、(define <var> <value>) 和
;; 2、(define (<var> <parameter1> ... <parametern>) <body>)
(define (definition? exp) (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      ;; 形式1，第二个元素为 <var> 定义
      (cadr exp)
      ;; 形式2，第二个元素是一个list，其中第一个元素为 <var>
      (caadr exp)))
(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp) ; formal parameters
                   (cddr exp)))) ; body
;; lambda
(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters exp) (cadr exp))
(define (lambda-body exp) (cddr exp))
;; 构造 labmda exp
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))
;; if
(define (if? exp) (tagged-list? exp 'if))
(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))
;; 构造 if，cond 时用
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))
;; begin
(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions exp) (cdr exp))
(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
;; 构造 begin
(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))
(define (make-begin seq) (cons 'begin seq))
;; 其他
(define (application? exp) (pair? exp))
;; 操作符
(define (operator exp) (car exp))
;; 操作数
(define (operands exp) (cdr exp))
;; 空
(define (no-operands? ops) (null? ops))
;; 第一个操作
(define (first-operand ops) (car ops))
;; rest操作
(define (rest-operands ops) (cdr ops))
;; cond: 使用嵌套 if 实现
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause) (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))
(define (cond->if exp) (expand-clauses (cond-clauses exp)))
(define (expand-clauses clauses)
  (if (null? clauses)
      'false ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))


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
