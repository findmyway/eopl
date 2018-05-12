#lang eopl

(provide
 ;; (list-set lst n x)
 ;; return a list like lst, except that the n-th element,
 ;; using zero-based indexing, is x
 lst-set)

(define (lst-set lst n x)
  (if (null? lst)
      '()
      (if (zero? n)
          (cons x (cdr lst))
          (cons (car lst) (lst-set (cdr lst) (- n 1) x)))))
