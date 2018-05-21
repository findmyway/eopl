#lang racket

(require rackunit
         "24.rkt")

(test-case
    "bintree-to-list"
  (check-equal? (bintree-to-list
                 (interior-node 'a
                                (leaf-node 3)
                                (leaf-node 4)))
                '(interior-node
                  a
                  (leaf-node 3)
                  (leaf-node 4))))
