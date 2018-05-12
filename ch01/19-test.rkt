#lang racket

(require rackunit
         "19.rkt")

(test-case
    "lst-set"
  (check-equal? (lst-set '(a b c d) 2 '(1 2))
                '(a b (1 2) d))
  (check-equal? (lst-set '(a b c d) 3 '(1 5 10))
                '(a b c (1 5 10))))
