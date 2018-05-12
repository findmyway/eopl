#lang eopl

(provide remove-until)
;; the `remove-first` function will turn into `remove-until` function
(define (remove-until s los)
  (if (null? los)
      '()
      (if (eqv? (car los) s)
          (cdr los)
          (remove-until s (cdr los)))))
