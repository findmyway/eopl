#lang eopl

(require "lang.rkt")
(require "environments.rkt")
(require "data-structures.rkt")

(provide value-of-program value-of)

;;;;;;;;;;;;;;;; the interpreter ;;;;;;;;;;;;;;;;

(define value-of-program
  (lambda (pgm)
    (cases program pgm
           (a-program (exp1)
                      (value-of exp1 (init-env)))
           (b-program (exp1)
                      (value-of-bool-exp exp1 (init-env))))))

(define (value-of-bool-exp exp env)
  (cases bool-expression exp
         (unary-bool-exp (op exp1)
                    (let ([val1 (value-of exp1 env)])
                      (case op
                        [("zero?")
                         (let ([num1 (expval->num val1)])
                           (if (zero? num1)
                               (bool-val #t)
                               (bool-val #f)))]
                        [("null?")
                         (bool-val (expval->emptylist? val1))]
                        [else (eopl:error 'unary-bool-exp "~s not supported" op)])))
         (binary-bool-exp (op exp1 exp2)
                          (let ([val1 (value-of exp1 env)]
                                [val2 (value-of exp2 env)])
                            (case op
                              [("equal?")
                               (let ([num1 (expval->num val1)]
                                     [num2 (expval->num val2)])
                                 (bool-val (equal? num1 num2)))]
                              [("less?")
                               (let ([num1 (expval->num val1)]
                                     [num2 (expval->num val2)])
                                 (bool-val (< num1 num2)))]
                              [("greater?")
                               (let ([num1 (expval->num val1)]
                                     [num2 (expval->num val2)])
                                 (bool-val (> num1 num2)))]
                              [else (eopl:error 'binary-bool-exp "~s not supported" op)]
                              )))))

(define value-of
  (lambda (exp env)
    (cases expression exp
           (print-exp (exp1)
                      (let ([val1 (value-of exp1 env)])
                        (display val1)
                        (newline)
                        (num-val 1)))

           (const-exp (num) (num-val num))

           (var-exp (var) (apply-env env var))

           (if-exp (exp1 exp2 exp3)
                   (let ([val1 (value-of-bool-exp exp1 env)])
                     (if (expval->bool val1)
                         (value-of exp2 env)
                         (value-of exp3 env))))

           (let-exp (vars exps body)
                    (let ([vals (map (lambda (x) (value-of x env)) exps)])
                      (value-of body
                                (list-extend-env vars vals env))))
           (let*-exp (vars exps body)
                     (define (update-env vars exps env)
                       (if (null? vars)
                           env
                           (let* ([var (car vars)]
                                  [val (value-of (car exps) env)])
                             (update-env (cdr vars)
                                         (cdr exps)
                                         (extend-env var val env)))))
                     (let ([local-env (update-env vars exps env)])
                       (value-of body local-env)))

           (cond-exp (conditions bodies)
                     (if (null? conditions)
                         (eopl:error 'cond-exp "no condition satisfy")
                         (if (expval->bool (value-of-bool-exp (car conditions) env))
                             (value-of (car bodies) env)
                             (value-of (cond-exp (cdr conditions)
                                                 (cdr bodies))
                                       env))))

           (unpack-exp (ids exp1 exp2)
                       (define (update-env ids exp env)
                         (if (null? ids)
                             env
                             (let ([var (car ids)]
                                   [val (expval->car exp)])
                               (update-env (cdr ids)
                                           (expval->cdr exp)
                                           (extend-env var val env)))))
                       (let ([new-env (update-env ids (value-of exp1 env) env)])
                         (value-of exp2 new-env)))

           (letproc-exp (id vars expression body)
                        (let ([p (proc-val (procedure vars expression env))])
                          (value-of body (extend-env id p env))))
           (proc-exp (ids expression)
                     (proc-val (procedure ids expression env)))
           (call-exp (rator rands)
                     (let ([p (expval->proc (value-of rator env))]
                           [args (map (lambda (x) (value-of x env)) rands)])
                       (cases proc p
                              (procedure (vars body saved-env)
                                         (value-of body (list-extend-env vars args saved-env))))))

           (nullary-exp (op)
                        (case op
                          [("emptylist") (emptylist-val)]
                          [else (eopl:error 'nullary-exp "~s not supported" op)]))

           (unary-exp (op exp1)
                      (let ([val1 (value-of exp1 env)])
                        (case op
                          [("minus")
                           (let ([num1 (expval->num val1)])
                             (num-val (- num1)))]
                          [("car") (expval->car val1)]
                          [("cdr") (expval->cdr val1)]
                          [else (eopl:error 'unary-exp "~s not supported" op)])))

           (binary-exp (op exp1 exp2)
                       (let ([val1 (value-of exp1 env)]
                             [val2 (value-of exp2 env)])
                         (case op
                           [("-")
                            (let ([num1 (expval->num val1)]
                                  [num2 (expval->num val2)])
                              (num-val (- num1 num2)))]
                           [("+")
                            (let ([num1 (expval->num val1)]
                                  [num2 (expval->num val2)])
                              (num-val (+ num1 num2)))]
                           [("*")
                            (let ([num1 (expval->num val1)]
                                  [num2 (expval->num val2)])
                              (num-val (* num1 num2)))]
                           [("/")
                            (let ([num1 (expval->num val1)]
                                  [num2 (expval->num val2)])
                              (num-val (quotient num1 num2)))]
                           [("cons") (cons-val val1 val2)]
                           [else (eopl:error 'binary-exp "~s not supported" op)])))

           (list-exp (op exprs)
                     (let ([vals (map (lambda (x) (value-of x env)) exprs)])
                       (case op
                         [("list") (list-val vals)]
                         [else (eopl:error 'list-exp "~s not supported" op)]))))))
