#lang racket

(require rackunit
         "27.rkt")

(test-case
    "flatten"
  (check-equal? (flatten '(a b c)) '(a b c))
  (check-equal? (flatten '((a) () (b ()) () (c))) '(a b c))
  (check-equal? (flatten '((a b) c (((d)) e))) '(a b c d e))
  (check-equal? (flatten '(a b (() (c)))) '(a b c)))
