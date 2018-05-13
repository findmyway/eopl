#lang racket

(require rackunit
         "35.rkt")

(test-case
    "number-leaves"
  (check-equal? (number-leaves
                 '(foo (bar 25 12)
                       (baz 11 (quux 117 14))))
                '(foo
                  (bar 0 1)
                  (baz
                   2
                   (quux 3 4)))))
