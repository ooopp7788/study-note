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
;; 过程参数 顺序求值
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))
;; if 表达式: (if preficate consequent alternative)
;; 先求值条件表达式
(define (eval-if exp env)
  (if (true? (eval (if-predicate exp) env))
      (eval (if-consequent exp) env)
      (eval (if-alternative exp) env)))
;; 赋值: (set! variable value)
;; 赋值和定义: 先求值,将改变 env 留给下级处理
(define (eval-assignment exp env)
  (set-variable-value! (eval (assignment-variable exp) env)
                       (eval (assignment-value exp) env)
                       env)
  'ok)
;; 定义: (define variable value)
(define (eval-definition exp env)
  (define-variable! (eval (definition-variable exp) env)
                       (eval (definition-value exp) env)
                       env)
  'ok)
;; 1. begin: (begin exp1 exp2 ...)
;; 2. labmbda
;; 3. cond 执行的 exp
;; 顺序执行,返回最后一个表达式的值
(define (eval-sequence exps env)
  (cond
    ;; 最后一个 exp 返回执行值
    ((last-exps? exps) (eval (first-exps exps) env))
    ;; 其他前面的 exp 仅执行,舍弃返回值
    (else (eval (first-exps exps))
          (eval-sequence exps env))))


;; 各种表达式类型判断
;; 数字、字符串
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))
;; 变量用 symbol 表示
(define (variable? exp) (symbol? exp))
;; 通用判断过程：判断 exp pair 的 car元素等于 tag
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))
;; 引号: 'quote symbol 表示
(define (quoted? exp) (tagged-list? exp 'quote))
;; 引号后的第一个值: cadr
(define (text-of-quotation exp) (cadr exp))
;; 复值: 'set! symbol 表示
(define (assignment? exp) (tagged-list? exp 'set!))
;; 变量: 'set! 后第一个参数, 即exp的第二个参数
(define (assignment-variable exp) (cadr exp))
;; 值: 即exp的第三个参数
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
;; 布尔
(define (true? x) (not (eq? x false)))
(define (false? x) (eq? x false))
;; 过程构造
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))
;; 复合过程判断
(define (compound-procedure? p) (tagged-list? p 'procedure))
;; 参数: 第二个
(define (procedure-parameters p) (cadr p))
;; body: 第三个
(define (procedure-body p) (caddr p))
;; env: 第四个
(define (procedure-environment p) (cadddr p))

;; frame: 由 var val 序对组成的表 (list (list var1 var2 var3...) (list val1 val2 val3...))
(define (make-frame variables values) (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
;; frame 头部添加(cons var val)
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))
;; 获取 env 中第一个 frame
(define (first-frame env) (car env))
;; 获取剩下的 env
(define (enclosing-environment env) (cdr env))
(define the-empty-environment '())
;; env 扩充: env 头部添加一个 frame
;; env 是由frame 为元素组成的表 (list frame1 frame2)
(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      ;; 头部添加一个 frame
      (cons (make-frame vars vals) base-env)
      ;; 错误处理
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))
;; 环境查询值
(define (lookup-variable-value var env0)
  ;; 递归查询 env
  (define (env-loop env)
    ;; 在 vars 表中找到参数, 返回对应的 vals 表中的值
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars)) (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame) (frame-values frame)))))
  (env-loop env0))
;; 环境变量赋值
(define (define-variable! var val env)
  (let ((frame (first-frame env)))
    (define (scan vars vals)
      (cond ((null? vars)
             (add-binding-to-frame! var val frame))
            ((eq? var (car vars)) (set-car! vals val))
            (else (scan (cdr vars) (cdr vals)))))
    (scan (frame-variables frame) (frame-values frame))))
