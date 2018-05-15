#lang eopl

(provide
 occurs-free?

 var-exp
 lambda-exp
 app-exp

 var-exp?
 lambda-exp?
 app-exp?

 var-exp->var
 lambda-exp->bound-var
 lambda-exp->body
 app-exp->rator
 app-exp->rand)

(define (var-exp var) var)

(define (lambda-exp bound-var body) (list 'lambda (list bound-var) body))

(define (app-exp exp1 exp2) (list exp1 exp2))

(define var-exp? symbol?)

(define (lambda-exp? exp)
  (and (= 3 (length exp))
       (equal? (car exp) 'lambda)
       (list? (cadr exp))
       (= 1 (length (cadr exp)))
       (var-exp? (caadr exp))
       (or (var-exp? (caddr exp))
           (lambda-exp? (caddr exp))
           (app-exp? (caddr exp)))))

(define (app-exp? exp)
  (and (= 2 (length exp))
       (or (var-exp? (car exp))
           (lambda-exp? (car exp))
           (app-exp? (car exp)))
       (or (var-exp? (cadr exp))
           (lambda-exp? (cadr exp))
           (app-exp? (cadr exp)))))

(define (var-exp->var exp) exp)

(define (lambda-exp->bound-var exp)
  (caadr exp))

(define (lambda-exp->body exp)
  (caddr exp))

(define (app-exp->rator exp)
  (car exp))

(define (app-exp->rand exp)
  (cadr exp))

(define (occurs-free? search-var exp)
  (cond
    [(var-exp? exp) (eqv? search-var (var-exp->var exp))]
    [(lambda-exp? exp) (and (not (eqv? search-var (lambda-exp->bound-var exp)))
                            (occurs-free? search-var (lambda-exp->body exp)))]
    [else (or (occurs-free? search-var (app-exp->rator exp))
              (occurs-free? search-var (app-exp->rand exp)))]))
