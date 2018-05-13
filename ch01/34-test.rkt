#lang racket

(require rackunit
         "34.rkt")

(test-case
    "path"
  (check-equal? (path 17 '(14 (7 () (12 () ()))
                              (26 (20 (17 () ()))
                                  (31 () ()))))
                '(right left left)))
