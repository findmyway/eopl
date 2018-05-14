#lang eopl

(provide
 zero
 is-zero?
 successor
 predecessor
 diff-tree-plus
 diff-tree-to-int)

(define (diff-tree-to-int n)
  (if (equal? n '(one))
      1
      (let ([l (diff-tree-to-int (cadr n))]
            [r (diff-tree-to-int (caddr n))])
        (- l r))))

(define zero '(diff (one) (one)))

(define (is-zero? n)
  (zero? (diff-tree-to-int n)))

(define (predecessor n)
  (list 'diff n '(one)))

(define (successor n)
  (list 'diff n '(diff (diff (one) (one)) (one))))

(define (diff-tree-plus a b)
  (if (equal? b '(one))
      (successor a)
      (let ([b-left (cadr b)]
            [b-right (caddr b)])
        (list 'diff a (list 'diff b-right b-left)))))
