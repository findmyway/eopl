#lang eopl

(require "31.rkt")

(provide
 ;; (double-tree)
 ;; all the integers in the leaves doubled
 double-tree)

(define (double-tree tree)
  (if (leaf? tree)
      (* 2 tree)
      (interior-node
       (content-of tree)
       (double-tree (lson tree))
       (double-tree (rson tree)))))
