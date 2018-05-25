#lang eopl

(require "data-structures.rkt")

(provide init-env empty-env extend-env apply-env list-extend-env)

;;;;;;;;;;;;;;;; initial environment ;;;;;;;;;;;;;;;;
(define init-env
  (lambda ()
    (extend-env
     'i (num-val 1)
     (extend-env
      'v (num-val 5)
      (extend-env
       'x (num-val 10)
       (empty-env))))))

;;;;;;;;;;;;;;;; environment constructors and observers ;;;;;;;;;;;;;;;;

(define empty-env
  (lambda ()
    (empty-env-record)))

(define empty-env?
  (lambda (x)
    (empty-env-record? x)))

(define extend-env
  (lambda (sym val old-env)
    (extended-env-record sym val old-env)))

(define (list-extend-env syms vals old-env)
  (if (null? syms)
      old-env
      (list-extend-env (cdr syms)
                       (cdr vals)
                       (extend-env (car syms)
                                   (car vals)
                                   old-env))))

(define apply-env
  (lambda (env search-sym)
    (if (empty-env? env)
        (eopl:error 'apply-env "No binding for ~s" search-sym)
        (let ((sym (extended-env-record->sym env))
              (val (extended-env-record->val env))
              (old-env (extended-env-record->old-env env)))
          (if (eqv? search-sym sym)
              val
              (apply-env old-env search-sym))))))
