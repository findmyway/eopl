#lang racket

(require rackunit
         "22.rkt")

(test-case
    "stack"
  (check-true (empty-stack? (empty-stack)))
  (check-false (stack? '()))
  (define s (push 0 (push 1 (push 2 (empty-stack)))))
  (check-equal? (top (push 3 s)) 3)
  (check-equal? (pop (push 3 s)) s)
  (check-exn exn:fail? (lambda () (pop (empty-stack))))
  (check-exn exn:fail? (lambda () (top (empty-stack)))))
