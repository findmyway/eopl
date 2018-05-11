#lang racket

(require rackunit
         "18.rkt")

(test-case
    "swapper"
  (check-equal? (swapper 'a 'd '(a b c d))
                '(d b c a))
  (check-equal? (swapper 'a 'd '(a d () c d))
                '(d a () c a))
  (check-equal? (swapper 'x 'y '((x) y (z (x))))
                '((y) x (z (y)))))

