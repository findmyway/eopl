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
                      (value-of exp1 (init-env))))))

(define value-of
  (lambda (exp env)
    (cases expression exp

           (const-exp (num) (num-val num))

           (var-exp (var) (apply-env env var))

           (if-exp (exp1 exp2 exp3)
                   (let ([val1 (value-of exp1 env)])
                     (if (expval->bool val1)
                         (value-of exp2 env)
                         (value-of exp3 env))))

           (let-exp (var exp1 body)
                    (let ([val1 (value-of exp1 env)])
                      (value-of body
                                (extend-env var val1 env))))

           (nullary-exp (op)
                        (case op
                          [("emptylist") (emptylist-val)]
                          [else (eopl:error 'nullary-exp "~s not supported" op)]))

           (unary-exp (op exp1)
                      (let ([val1 (value-of exp1 env)])
                        (case op
                          [("zero"?)
                           (let ([num1 (expval->num val1)])
                             (if (zero? val1)
                                 (bool-val #t)
                                 (bool-val #f)))]
                          [("minus")
                           (let ([num1 (expval->num val1)])
                             (num-val (- num1)))]
                          [("null"?)
                           (bool-val (expval->emptylist? val1))]
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
                           [("cons") (cons-val val1 val2)]
                           [else (eopl:error 'binary-exp "~s not supported" op)])))

           (list-exp (op exprs)
                     (let ([vals (map (lambda (x) (value-of x env)) exprs)])
                       (case op
                         [("list") (list-val vals)]
                         [else (eopl:error 'list-exp "~s not supported" op)]))))))
