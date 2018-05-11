#lang racket

(require rackunit
         "08.rkt")

(test-case
    "remove until first occurance(without)"
  (check-equal? (remove-until 0 '(1 2 0)) '())
  (check-equal? (remove-until 3 '(1 2 3 4)) '(4))
  (check-equal? (remove-until -1 '(0 1 2 3)) '()))
