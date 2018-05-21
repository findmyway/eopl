#lang eopl

(provide
 number->bintree
 insert-to-left
 insert-to-right
 current-element
 move-to-left
 move-to-right
 move-up
 at-leaf?
 at-root?)

(define (number->bintree n)
  (list (list n '() '())
        '()))

(define (current-element t)
  (caar t))

(define (move-to-left t)
  (let* ([tree (car t)]
         [ctx (cadr t)]
         [cur (current-element t)]
         [left (cadr tree)]
         [right (caddr tree)]
         [new-ctx (cons (list cur #f right) ctx)])
    (list left new-ctx)))

(define (move-to-right t)
  (let* ([tree (car t)]
         [ctx (cadr t)]
         [cur (current-element t)]
         [left (cadr tree)]
         [right (caddr tree)]
         [new-ctx (cons (list cur left #f) ctx)])
    (list right new-ctx)))

(define (insert-to-left n t)
  (let* ([tree (car t)]
         [ctx (cadr t)]
         [cur (current-element t)]
         [left (cadr tree)]
         [right (caddr tree)]
         [new-left (list n left '())]
         [new-tree (list cur new-left right)])
    (list new-tree ctx)))

(define (insert-to-right n t)
  (let* ([tree (car t)]
         [ctx (cadr t)]
         [cur (current-element t)]
         [left (cadr tree)]
         [right (caddr tree)]
         [new-right (list n '() right)]
         [new-tree (list cur left new-right)])
    (list new-tree ctx)))

(define (at-leaf? t)
  (null? (car t)))

(define (at-root? t)
  (null? (cadr t)))

(define (move-up t)
  (if (at-root? t)
      (eopl:error 'move-up "Already at root")
      (let* ([tree (car t)]
             [ctx (cadr t)]
             [par (car ctx)])
        (cond
          [(equal? (cadr par) #f)
           (list (list (car par)
                       tree
                       (caddr par))
                 (cdr ctx))]
          [(equal? (caddr par) #f)
           (list (list (car par)
                       (cadr par)
                       tree)
                 (cdr ctx))]))))

