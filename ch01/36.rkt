#lang eopl

(provide number-elements)

(define (g pair0 pairs)
  (define (inc-index pairs)
    (if (null? pairs)
        '()
        (cons (cons (+ 1 (caar pairs)) (cdar pairs)) (inc-index (cdr pairs)))))
  (cons pair0 (inc-index pairs)))

(define (number-elements lst)
  (if (null? lst)
      '()
      (g (list 0 (car lst)) (number-elements (cdr lst)))))
