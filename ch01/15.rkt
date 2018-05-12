#lang eopl

(provide
 ;; (duple n x) -> lst
 ;; return n copies of x
 duple)

(define (duple n x)
  (if (zero? n)
      '()
      (cons x (duple (- n 1) x))))
