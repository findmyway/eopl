#lang eopl

(provide
 number->bintree
 insert-to-left
 insert-to-right
 current-element
 at-leaf?
 move-to-left
 move-to-right)


(define (number->bintree n)
  (list n '() '()))

(define (current-element t) (car t))
(define (move-to-left t) (cadr t))
(define (move-to-right t) (caddr t))
(define at-leaf? null?)

(define (insert-to-left n t)
  (let* ([cur (current-element t)]
         [left (move-to-left t)]
         [right (move-to-right t)]
         [left-new (list n left '())])
    (list cur left-new right)))

(define (insert-to-right n t)
  (let* ([cur (current-element t)]
         [left (move-to-left t)]
         [right (move-to-right t)]
         [right-new (list n '() right)])
    (list cur left right-new)))
