#lang eopl

(provide
 ;; (list-index pred lst)
 ;; return the 0-based position of the first element of lst
 ;; that satisfies the predicate pred.
 ;; return #f if no one satisfies.
 list-index)

(define (list-index pred lst)
  (define (helper pred lst n)
    (if (null? lst)
        #f
        (if (pred (car lst))
            n
            (helper pred (cdr lst) (+ n 1)))))
  (helper pred lst 0))
