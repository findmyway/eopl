#lang eopl

(require "31.rkt")

(provide
 mark-leaves-with-red-depth)

(define (mark-leaves-with-red-depth tree)
  (define (mark-leaves-with-depth tree depth)
    (if (leaf? tree)
        depth
        (if (equal? 'red (content-of tree))
            (interior-node
             'red
             (mark-leaves-with-depth (lson tree) (+ depth 1))
             (mark-leaves-with-depth (rson tree) (+ depth 1)))
            (interior-node
             (content-of tree)
             (mark-leaves-with-depth (lson tree) depth)
             (mark-leaves-with-depth (rson tree) depth)))))
  (mark-leaves-with-depth tree 0))
