#lang eopl

(provide
 ;; (filter-in pred lst)
 ;; returns the list of those elements in lst that satisfy the predicate pred
 filter-in)

(define (filter-in pred lst)
  (if (null? lst)
      '()
      (if (pred (car lst))
          (cons (car lst) (filter-in pred (cdr lst)))
          (filter-in pred (cdr lst)))))
