#lang eopl

(provide
 leaf interior-node leaf? lson rson content-of)

(define (leaf x) x)

(define (interior-node val lnode rnode)
  (list val lnode rnode))

(define (leaf? x) (not (pair? x)))

(define lson cadr)

(define rson caddr)

(define (content-of x)
  (if (leaf? x)
      x
      (car x)))
