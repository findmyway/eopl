#lang racket

(require rackunit
         "36.rkt")

(test-case
    "number-elements"
  (check-equal? (number-elements '(a b c d e))
                '((0 a) (1 b) (2 c) (3 d) (4 e))))
