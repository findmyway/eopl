#lang racket

(require rackunit
         "21.rkt")

(test-case
    "test env"
  (check-false (has-binding? (empty-env) 'x))
  (check-true (has-binding? (extend-env 'x 0 (empty-env)) 'x))
  (check-equal? (apply-env (extend-env 'x 0 (empty-env)) 'x) 0))
