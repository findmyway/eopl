#lang racket

(require rackunit
         "33.rkt")

(test-case
    "mark-leaves-with-red-depth"
  (check-equal? (mark-leaves-with-red-depth
                 '(red (bar 26 12)
                       (red 11
                            (quux 117 14))))
                '(red (bar 1 1)
                      (red 2
                           (quux 2 2)))))
