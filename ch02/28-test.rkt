#lang racket

(require rackunit
         "23.rkt"
         "28.rkt")

(test-case
    "unparse"
  (check-equal? (unparse-lc-exp (lambda-exp 'x (var-exp 'y)))
                "(lambda (x) y)")
  (check-equal? (unparse-lc-exp (app-exp (lambda-exp
                                          'a
                                          (app-exp (var-exp 'a)
                                                   (var-exp 'b)))
                                         (var-exp 'c)))
                "((lambda (a) (a b)) c)"))
