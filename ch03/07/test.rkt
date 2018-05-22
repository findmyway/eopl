#lang racket

(require rackunit
         "lang.rkt"
         "interp.rkt"
         "data-structures.rkt")

(test-case
    "plus"
  (check-equal? (value-of-program (scan&parse "+(1,2)"))
                (num-val 3))
  (check-equal? (value-of-program (scan&parse "minus(+(1,2))"))
                (num-val -3))
  (check-equal? (value-of-program (scan&parse "+(1,+(2, 3))"))
                (num-val 6)))

(test-case
    "multiply"
  (check-equal? (value-of-program (scan&parse "*(minus(2), 3)"))
                (num-val -6))
  (check-equal? (value-of-program (scan&parse "*(2, *(3,4))"))
                (num-val 24)))

(test-case
    "integer quotient"
  (check-equal? (value-of-program (scan&parse "/(5, 2)"))
                (num-val 2)))
