#lang eopl

(provide up)

(define (up lst)
  (if (null? lst)
      '()
      (if (symbol? (car lst))
          (cons (car lst) (up (cdr lst)))
          (if (null? (car lst))
              (up (cdr lst))
              (cons (caar lst) (up (cons (cdar lst) (cdr lst))))))))
