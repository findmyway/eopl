#lang eopl

(define-datatype prefix-exp prefix-exp?
  (const-exp
   (num integer?))
  (diff-exp
   (operand1 prefix-exp?)
   (operand2 prefix-exp?)))

(define (make-prefix-exp lst)
  (if (null? lst)
      '()
      (if (number? (car lst))
          (cons (const-exp (car lst))
                (cdr lst))
          (if (eqv? (car lst) '-)
              (if (null? (cdr lst))
                  (eopl:error 'make-prefix-exp "need operand")
                  (let* ([next (make-prefix-exp (cdr lst))]
                         [op1 (car next)]
                         [next (make-prefix-exp (cdr next))]
                         [op2 (car next)]
                         [rest (cdr next)])
                    (cons (diff-exp op1 op2)
                          rest)))
              (eopl:error 'make-prefix-exp "Syntax error")))))
