#lang eopl

(provide
 bintree
 leaf-node
 interior-node
 bintree-to-list)

(define-datatype bintree bintree?
  (leaf-node
   (num integer?))
  (interior-node
   (key symbol?)
   (left bintree?)
   (right bintree?)))

(define (bintree-to-list t)
  (cases bintree t
         (leaf-node (num)
                    (list 'leaf-node num))
         (interior-node (key left right)
                        (list 'interior-node
                              key
                              (bintree-to-list left)
                              (bintree-to-list right)))))
