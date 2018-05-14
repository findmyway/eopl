#lang racket

(require rackunit
         "01.rkt")

(test-case
    "factorial"
  (check-equal? (factorial (int2bigits 10)) '(0 0 15 5 7 3)))

(test-case
    "multiply"
  (check-equal? (multiply (int2bigits 100) (int2bigits 100))
                (int2bigits 10000))
  (check-equal? (multiply zero (int2bigits 100))
                zero))

