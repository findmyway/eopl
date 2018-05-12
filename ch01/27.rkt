#lang eopl

(require "26.rkt")

(provide
 ;; (flatten slist)
 ;; removes all the inner parentheses from slist
 flatten)

(define (flatten slist)
  (up (map (lambda (x) (if (symbol? x)
                           x
                           (flatten x)))
           slist)))
