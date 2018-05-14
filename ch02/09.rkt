#lang eopl

(define (has-binding? env s)
  (if (null? env)
      #f
      (if (equal? (caar env) s)
          #t
          (has-binding? (cdr env) s))))
