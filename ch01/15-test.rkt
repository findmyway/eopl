#lang racket

(require rackunit
         "15.rkt")

(test-case
    "duple"
  (check-equal? (duple 2 3) '(3 3))
  (check-equal? (duple 4 '(ha ha))
                '((ha ha) (ha ha) (ha ha) (ha ha)))
  (check-equal? (duple 0 '(blah)) '()))
