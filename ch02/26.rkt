#lang eopl

(define-datatype red-blue-tree red-blue-tree?
  (red-node (a red-blue-tree?)
            (b red-blue-tree?))
  (blue-node (tree-lst (list-of red-blue-tree?)))
  (leaf-node (n integer?)))

(define (list-of pred)
  (lambda (xs)
    (or (null? xs)
        (and (pred (car xs))
             ((list-of pred) (cdr xs))))))

(define (mark-leaves-help t c)
  (cases red-blue-tree t
         (red-node (a b)
                   (red-node (mark-leaves-help a (+ 1 c))
                             (mark-leaves-help b (+ 1 c))))
         (blue-node (tree-lst)
                    (if (null? tree-lst)
                        '()
                        (cons (mark-leaves-help (car tree-lst) c)
                              (mark-leaves-help (blue-node (cdr tree-lst)) c))))
         (leaf-node (n) (leaf-node c))))
