#lang eopl

(provide
 ;; (product sos1 sos2)
 ;; Cartesian product of sos1 and sos2
 product)


(define (product sos1 sos2)
  (define (product-1 s sos)
    (if (null? sos)
        '()
        (cons (cons s (cons (car sos) '()))
              (product-1 s (cdr sos)))))
  (if (null? sos1)
      '()
      (append (product-1 (car sos1) sos2)
              (product (cdr sos1) sos2))))
