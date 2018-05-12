#lang racket

(require rackunit
         "24.rkt")

(test-case
    "every?"
  (check-equal? (every? number? '(a b c 3 e)) #f)
  (check-equal? (every? number? '(1 2 3 5 4)) #t))
