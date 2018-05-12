#lang eopl

(provide
 ;; (sort/predicate pred loi)
 ;; sort a list of elements sorted by predicate
 sort/predicate)

(define (sort/predicate pred loi)
  (define (insert x loi)
    (if (null? loi)
        (cons x '())
        (if (pred x (car loi))
            (cons x loi)
            (cons (car loi) (insert x (cdr loi))))))
  (if (null? loi)
      loi
      (insert (car loi) (sort/predicate pred (cdr loi)))))
