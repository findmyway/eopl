#lang racket

(require rackunit
         "20.rkt")

(test-case
    "count-occurences"
  (check-equal? (count-occurences 'x '((f x) y (((x z) x)))) 3)
  (check-equal? (count-occurences 'x '((f x) y (((x z) () x)))) 3)
  (check-equal? (count-occurences 'w '((f x) y (((x z) x)))) 0))
