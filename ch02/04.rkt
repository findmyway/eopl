#lang eopl

(provide
 empty-stack
 empty-stack?
 push
 pop
 top)

(define empty-stack '())
(define empty-stack? null?)
(define (push x stack)
  (cons x stack))
(define (pop stack)
  (cdr stack))
(define (top stack)
  (car stack))
