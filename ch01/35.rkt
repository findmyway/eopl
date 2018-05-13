#lang eopl

(require "31.rkt")

(provide
 ;; (number-leaves tree)
 ;; number the leaves
 number-leaves)

(define (number-leaves tree)
  (define (count-leaves tree)
    (if (leaf? tree)
        1
        (+ (count-leaves (lson tree))
           (count-leaves (rson tree)))))
  (define (number-leaves-n tree n)
    (if (leaf? tree)
        n
        (interior-node
         (content-of tree)
         (number-leaves-n (lson tree) n)
         (number-leaves-n (rson tree) (+ n (count-leaves (lson tree)))))))
  (number-leaves-n tree 0))
