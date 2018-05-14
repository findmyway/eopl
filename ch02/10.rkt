#lang eopl

(define (extend-env* vars vals env)
  (if (null? vars)
      env
      (extend-env* (cdr vars) (cdr vals) (cons (list (car vars) (car vals)) env))))
