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

           (diff-exp (exp1 exp2)
                     (let ([val1 (value-of exp1 env)]
                           [val2 (value-of exp2 env)])
                       (let ([num1 (expval->num val1)]
                             [num2 (expval->num val2)])
                         (num-val
                          (- num1 num2)))))

           (zero?-exp (exp1)
                      (let ([val1 (value-of exp1 env)])
                        (let ([num1 (expval->num val1)])
                          (if (zero? num1)
                              (bool-val #t)
                              (bool-val #f)))))

           (if-exp (exp1 exp2 exp3)
                   (let ([val1 (value-of exp1 env)])
                     (if (expval->bool val1)
                         (value-of exp2 env)
                         (value-of exp3 env))))

           (let-exp (var exp1 body)
                    (let ([val1 (value-of exp1 env)])
                      (value-of body
                                (extend-env var val1 env))))
           (minus-exp (exp1)
                      (let ([val (expval->num (value-of exp1 env))])
                        (num-val (- val))))

           (plus-exp (exp1 exp2)
                     (let ([n1 (expval->num (value-of exp1 env))]
                           [n2 (expval->num (value-of exp2 env))])
                       (num-val (+ n1 n2))))
           (mul-exp (exp1 exp2)
                    (let ([n1 (expval->num (value-of exp1 env))]
                          [n2 (expval->num (value-of exp2 env))])
                      (num-val (* n1 n2))))
           (div-exp (exp1 exp2)
                    (let ([n1 (expval->num (value-of exp1 env))]
                          [n2 (expval->num (value-of exp2 env))])
                      (num-val (quotient n1 n2))))
           (eq-exp (exp1 exp2)
                   (let ([n1 (expval->num (value-of exp1 env))]
                         [n2 (expval->num (value-of exp2 env))])
                     (bool-val (equal? n1 n2))))
           (lt-exp (exp1 exp2)
                   (let ([n1 (expval->num (value-of exp1 env))]
                         [n2 (expval->num (value-of exp2 env))])
                     (bool-val (< n1 n2))))
           (gt-exp (exp1 exp2)
                   (let ([n1 (expval->num (value-of exp1 env))]
                         [n2 (expval->num (value-of exp2 env))])
                     (bool-val (> n1 n2))))
           (emptylist-exp ()
                          (emptylist-val))
           (null?-exp (exp1)
                      (let ([is-null (expval->emptylist? (value-of exp1 env))])
                        (bool-val is-null)))
           (cons-exp (exp1 exp2)
                     (let ([val1 (value-of exp1 env)]
                           [val2 (value-of exp2 env)])
                       (cons-val val1 val2)))
           (car-exp (exp1)
                    (expval->car (value-of exp1 env)))
           (cdr-exp (exp1)
                    (expval->cdr (value-of exp1 env))))))
