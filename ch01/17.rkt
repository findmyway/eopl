#lang eopl

(provide
 ;; (down lst) -> lst
 ;; wrap parentheses around each top-level element in lst
 down)

(define down
  (lambda (lst)
    (map (lambda (x) (cons x '())) lst)))

