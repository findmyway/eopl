#lang racket

(require rackunit
         "lang.rkt"
         "interp.rkt"
         "data-structures.rkt")

(test-case
    "minus"
  (check-equal? (value-of-program (scan&parse "minus(-(2, 3))"))
                (num-val 1)))
