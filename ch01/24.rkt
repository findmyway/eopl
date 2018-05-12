#lang eopl

(provide
 ;; (every? pred lst)
 ;; returns #f if any element of lst fails to satisfy pred
 ;; return #t otherwise
 every?)

(define (every? pred lst)
  (if (null? lst)
      #t
      (if (pred (car lst))
          (every? pred (cdr lst))
          #f)))
