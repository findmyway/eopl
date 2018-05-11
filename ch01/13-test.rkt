#lang racket

(require rackunit
         "13.rkt")

(test-case
    "check subst works as desired"
  (check-equal? (subst 'a 'b '((b c) (b () d))) '((a c) (a () d))))
