#lang eopl

(provide
 stack?
 empty-stack
 push
 pop
 top
 empty-stack?)

(define-datatype stack stack?
  (empty-stack)
  (push
   (_var var?)
   (_stack stack?)))

(define (var? x) #t)

(define (pop s)
  (cases stack s
         (empty-stack ()
                      (eopl:error 'pop "stack is empty"))
         (push (_v _s)
               _s)))

(define (top s)
  (cases stack s
         (empty-stack ()
                      (eopl:error 'top "stack is empty"))
         (push (_v _s)
               _v)))

(define (empty-stack? s)
  (equal? s (empty-stack)))
