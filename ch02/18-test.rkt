#lang racket

(require rackunit
         "18.rkt")

(test-case
    "sequence"
  (check-equal? (number->sequence 7) '(7 () ()))
  (check-equal? (current-element '(1 (2 3) (4 5))) 1)
  (check-equal? (move-to-left '(6 (5 4 3 2 1) (7 8 9)))
                '(5 (4 3 2 1) (6 7 8 9)))
  (check-exn exn:fail? (lambda () (move-to-left '(1 () (2 3)))))
  (check-equal? (move-to-right '(6 (5 4 3 2 1) (7 8 9)))
                '(7 (6 5 4 3 2 1) (8 9)))
  (check-exn exn:fail? (lambda () (move-to-right '(1 () ()))))
  (check-equal? (insert-to-left 13 '(6 (5 4 3 2 1) (7 8 9)))
                '(6 (13 5 4 3 2 1) (7 8 9)))
  (check-equal? (insert-to-right 13 '(6 (5 4 3 2 1) (7 8 9)))
                '(6 (5 4 3 2 1) (13 7 8 9))))
