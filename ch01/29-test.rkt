#lang racket

(require rackunit
         "29.rkt")

(test-case
    "sort"
  (check-equal? (sort '(8 2 5 2 3)) '(2 2 3 5 8)))
