#lang eopl

(define-datatype lc-exp lc-exp?
  (var-exp
   (var identifier?))
  (lambda-exp
   (bound-vars (list-of identifier?))
   (body lc-exp?))
  (app-exp
   (rator lc-exp?)
   (rands (list-of lc-exp?))))

(define (list-of pred)
  (lambda (xs)
    (or (null? xs)
        (and (pred (car xs))
             ((list-of pred) (cdr xs))))))

(define identifier?
  (lambda (x)
    (and (symbol? x) (not (eqv? 'lambda x)))))

(define (parse-lc-exp datum)
  (cond [(symbol? datum) (var-exp datum)]
        [(pair? datum)
         (if (eqv? (car datum) 'lambda)
             (lambda-exp (cadr datum)
                         (parse-lc-exp (caddr datum)))
             (app-exp (parse-lc-exp (car datum))
                      (map parse-lc-exp (cdr datum))))]
        [else (eopl:error 'parse-lc-exp "Syntax Error!")]))
