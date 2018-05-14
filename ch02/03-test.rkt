#lang racket

(require rackunit
         "03.rkt")

(test-case
    "diff-tree-to-int"
  (check-equal? (diff-tree-to-int '(one)) 1)
  (check-equal? (diff-tree-to-int '(diff (one) (one))) 0)
  (check-equal? (diff-tree-to-int '(diff (diff (one) (one)) (one))) -1)
  (check-equal? (diff-tree-to-int '(diff (one) (diff (one) (one)))) 1))

(test-case
    "zero"
  (check-equal? (diff-tree-to-int zero) 0))

(test-case
    "successor"
  (check-equal? (diff-tree-to-int (successor zero)) 1)
  (check-equal? (diff-tree-to-int (successor (successor zero))) 2)
  (check-equal? (diff-tree-to-int (successor (successor (successor zero)))) 3))

(test-case
    "predecessor"
  (check-equal? (diff-tree-to-int (predecessor zero)) -1)
  (check-equal? (diff-tree-to-int (predecessor (predecessor zero))) -2)
  (check-equal? (diff-tree-to-int (successor (predecessor zero))) 0)
  (check-equal? (diff-tree-to-int (predecessor (successor zero))) 0))

(test-case
    "diff-tree-plu"
  (check-equal? (diff-tree-to-int (diff-tree-plus zero '(one))) 1)
  (check-equal? (diff-tree-to-int (diff-tree-plus (successor (successor zero))
                                                  (successor (successor zero)))) 4)
  (check-equal? (diff-tree-to-int (diff-tree-plus (predecessor (predecessor zero))
                                                  (predecessor (predecessor zero)))) -4))

