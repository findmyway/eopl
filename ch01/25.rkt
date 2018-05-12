#lang eopl

(provide
 ;; (exists? pred lst)
 ;; returns #t if any element of lst satisfies pred
 ;; return #f otherwise
 exists?)

(define (exists? pred lst)
  (if (null? lst)
      #f
      (if (pred (car lst))
          #t
          (exists? pred (cdr lst)))))
