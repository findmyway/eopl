#lang eopl

(require "23.rkt")

(provide unparse-lc-exp)


(define (unparse-lc-exp exp)
  (cases lc-exp exp
         (var-exp (var) (symbol->string var))
         (lambda-exp (bound-var body)
                     (string-append "(lambda ("
                                    (symbol->string bound-var)
                                    ") "
                                    (unparse-lc-exp body) ")"))
         (app-exp (rator rand)
                  (string-append "("
                                 (unparse-lc-exp rator)
                                 " "
                                 (unparse-lc-exp rand)
                                 ")"))))
