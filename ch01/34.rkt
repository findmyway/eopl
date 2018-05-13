#lang eopl

(require "31.rkt")

(provide
 ;; (path n bst)
 ;; provide actions to show how to find n in the bst
 path)

(define (path n bst)
  ;; assume n is in bst's nodes
  (cond
    [(equal? n (car bst)) '()]
    [(< n (car bst)) (cons 'left (path n (lson bst)))]
    [else (cons 'right (path n (rson bst)))]))
