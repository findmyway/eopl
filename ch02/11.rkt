#lang eopl

(provide
 empty-env
 extend-env
 extend-env*
 apply-env)

(define empty-env '())

(define (extend-env var val env)
  (cons (list (list var) (list val)) env))

(define (extend-env* vars vals env)
  (cons (list vars vals) env))

(define (apply-env env search-var)
  (cond [(null? env) '()]
        [(null? (car env)) (apply-env (cdr env) search-var)]
        [(equal? (caaar env) search-var) (cadar env)]
        [else (apply-env (cons (list (cdaar env) (cddar env)) (cdr env)) search-var)]))
