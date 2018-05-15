#lang eopl

(provide
 empty-env
 extend-env
 apply-env)

(define empty-env '())

(define (extend-env var val env)
  (cons (list var val) env))

(define (apply-env env search-var)
  (if (equal? env '())
      '()
      (if (equal? (caar env) search-var)
          (cadar env)
          (apply-env (cdr env) search-var))))
