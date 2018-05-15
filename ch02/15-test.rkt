#lang racket

(require rackunit
         "15.rkt")

(test-case
    "test interfaces"
  (check-equal? (var-exp 'a) 'a)

  (check-equal? (lambda-exp 'x 'y) '(lambda (x) y))
  (check-equal? (lambda-exp 'x '(x y)) '(lambda (x) (x y)))

  (check-equal? (app-exp 'plus 'x) '(plus x))
  (check-equal? (app-exp '(lambda (x) (z x)) 'y) '((lambda (x) (z x)) y))

  (check-equal? (var-exp? 'x) #t)
  (check-equal? (var-exp? 3) #f)
  (check-equal? (var-exp? '(lambda (x) (y))) #f)

  (check-true (lambda-exp? '(lambda (x) y)))
  (check-true (lambda-exp? '(lambda (x) (y z))))
  (check-false (lambda-exp? '(lambda x (y))))
  (check-true (lambda-exp? '(lambda (x) ((lambda (a) (b c)) d))))

  (check-true (app-exp? '(a b)))
  (check-true (app-exp? '(a (lambda (x) (y z)))))
  (check-true (lambda-exp? '(lambda (a) (lambda (z) (x (y z))))))

  (check-equal? (var-exp->var (var-exp 'a)) 'a)

  (check-equal? (lambda-exp->bound-var '(lambda (x) (y z))) 'x)

  (check-equal? (lambda-exp->body '(lambda (x) (y z))) '(y z))

  (check-equal? (app-exp->rator '(a b)) 'a)

  (check-equal? (app-exp->rand '(a b)) 'b)
  )


(test-case
    "occurs-free?"
  (check-true (occurs-free? 'x 'x))
  (check-false (occurs-free? 'x 'y))
  (check-false (occurs-free? 'x '(lambda (x) (x y))))
  (check-true (occurs-free? 'x '(lambda (y) (x y))))
  (check-true (occurs-free? 'x '((lambda (x) x) (x y))))
  (check-true (occurs-free? 'x '(lambda (a) (lambda (z) (x (y z)))))))
