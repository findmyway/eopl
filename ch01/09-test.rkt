#lang racket

(require rackunit
         "09.rkt")

(test-case
    "remove all occurences"
  (check-equal? (remove-all-occurences 1 '(1 2 1 3 1 4)) '(2 3 4))
  (check-equal? (remove-all-occurences 1 '()) '()))
