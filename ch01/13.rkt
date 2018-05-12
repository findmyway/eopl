#lang eopl

(provide subst)

(define (subst new old slist)
  (map (lambda (sexp)
         (if (symbol? sexp)
             (if (eqv? sexp old) new sexp)
             (subst new old sexp)))
       slist))
