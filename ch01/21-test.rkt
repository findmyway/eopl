#lang racket

(require rackunit
         "21.rkt")

(test-case
    "product"
  (check-equal? (product '(a b c) '(x y))
                '((a x) (a y) (b x) (b y) (c x) (c y))))
