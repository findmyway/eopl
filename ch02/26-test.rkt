#lang racket

(require rackunit
         "26.rkt")

(test-case
    "mark-leaves"
  (check-equal? (mark-leaves
                 (red-node (leaf-node 0)
                           (blue-node (list (leaf-node 0)
                                            (blue-node '())
                                            (red-node (leaf-node 0) (leaf-node 0))
                                            (leaf-node 0)))))
                (red-node (leaf-node 1)
                          (blue-node (list (leaf-node 1)
                                           (blue-node '())
                                           (red-node (leaf-node 2) (leaf-node 2))
                                           (leaf-node 1))))))
