#lang racket

(require rackunit
         "25.rkt")

(test-case
    "exists?"
  (check-equal? (exists? number? '(9 a b c 3 e)) #t)
  (check-equal? (exists? number? '(a b c d e)) #f))
