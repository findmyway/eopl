#lang eopl

(provide remove-all-occurences)

(define (remove-all-occurences s los)
  (if (null? los)
      '()
      (if (eqv? (car los) s)
          (remove-all-occurences s (cdr los))
          (cons (car los) (remove-all-occurences s (cdr los))))))
