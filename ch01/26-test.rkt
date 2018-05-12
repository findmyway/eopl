#lang racket

(require rackunit
         "26.rkt")

(test-case
    "up"
  (check-equal? (up '((1 2) (3 4)))
                '(1 2 3 4))
  (check-equal? (up '((x (y)) z))
                '(x (y) z)))
