#lang racket

(require rackunit
         "07.rkt")
(test-case
    "return nth element"
  (test-begin
    (define lst '(-1 0 1))
    (check-equal? (nth-element-rewrite lst 0) -1)
    (check-equal? (nth-element-rewrite lst 1) 0)
    (check-equal? (nth-element-rewrite lst 2) 1)))

(test-case
    "throw error when n is greater than the list's length"
  (test-begin
    (define lst '(-1 0 1))
    (check-exn exn:fail? (lambda () (nth-element-rewrite lst -1)))
    (check-exn exn:fail? (lambda () (nth-element-rewrite lst 3)))
    (check-exn exn:fail? (lambda () (nth-element-rewrite '() 0)))))
