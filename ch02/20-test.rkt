#lang racket

(require rackunit
         "20.rkt")

(test-case
    "tree"
  (check-equal? (number->bintree 13) '((13 () ())
                                       ()))

  (define t1 (insert-to-right 14 (insert-to-left 12 (number->bintree 13))))
  (check-equal? t1 '((13 (12 () ())
                         (14 () ()))
                     ()))
  (check-equal? (move-to-left t1) '((12 () ())
                                    ((13 #f (14 () ())))))
  (check-equal? (current-element (move-to-left t1)) 12)
  (check-true (at-leaf? (move-to-right (move-to-left t1))))
  (check-equal? (insert-to-left 15 t1)
                '((13 (15
                       (12 () ())
                       ())
                      (14 () ()))
                  ()))
  (check-true (at-root? t1))
  (check-equal? (move-up (move-to-left t1)) t1)
  (check-exn exn:fail? (lambda () (move-up t1))))
