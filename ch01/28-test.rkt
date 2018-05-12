#lang racket

(require rackunit
         "28.rkt")

(test-case
    "merge"
  (check-equal? (merge '(1 4) '(1 2 8)) '(1 1 2 4 8))
  (check-equal? (merge '(35 62 81 90 91) '(3 83 85 90))
                '(3 35 62 81 83 85 90 90 91)))
