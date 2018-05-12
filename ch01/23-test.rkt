#lang racket

(require rackunit
         "23.rkt")

(test-case
    "list-index"
  (check-equal? (list-index number? '(a 2 (1 3) b 7)) 1)
  (check-equal? (list-index symbol? '(a (b c) 17 foo)) 0)
  (check-equal? (list-index symbol? '(1 2 (a b) 3)) #f))
