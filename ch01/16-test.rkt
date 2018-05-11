#lang racket

(require rackunit
         "16.rkt")

(test-case
    "invert"
  (check-equal? (invert '((a 1) (a 2) (1 b) (2 b)))
                '((1 a) (2 a) (b 1) (b 2))))

