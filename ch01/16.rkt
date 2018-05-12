#lang eopl

(provide
 ;; (invert lst) -> lst
 ;; return lst with each of the inner 2-list reversed
 invert)

(define (invert lst)
  (map (lambda (item)
         (cons (cadr item)
               (cons (car item)
                     '())))
       lst))

