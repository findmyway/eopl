#lang racket

(require rackunit
         "30.rkt")

(test-case
    "sort/predicate"
  (check-equal? (sort/predicate < '(8 2 5 2 3)) '(2 2 3 5 8))
  (check-equal? (sort/predicate > '(8 2 5 2 3)) '(8 5 3 2 2)))
