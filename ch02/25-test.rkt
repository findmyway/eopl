#lang racket

(require rackunit
         "24.rkt"
         "25.rkt")

(test-case
    "max-interior"
  (define tree-1 (interior-node 'foo (leaf-node 2) (leaf-node 3)))
  (define tree-2 (interior-node 'bar (leaf-node -1) tree-1))
  (define tree-3 (interior-node 'baz tree-2 (leaf-node 1)))
  (check-equal? (max-interior tree-1) 'foo )
  (check-equal? (max-interior tree-2) 'foo)
  (check-equal? (max-interior tree-3) 'baz))
