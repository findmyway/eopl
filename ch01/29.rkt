#lang eopl

(provide
 ;; (sort loi)
 ;; returns a list of the elements of loi in ascending order
 sort)

(define (sort loi)
  (define (insert x loi)
    (if (null? loi)
        (cons x '())
        (if (< x (car loi))
            (cons x loi)
            (cons (car loi) (insert x (cdr loi))))))
  (if (null? loi)
      loi
      (insert (car loi) (sort (cdr loi)))))
