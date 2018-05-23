#lang eopl

(provide (all-defined-out))

(define the-lexical-spec
  '((whitespace (whitespace) skip)
    (comment ("%" (arbno (not #\newline))) skip)

    (nullary-op ("emptylist") string)
    (unary-op ((or "zero?" "minus" "car" "cdr" "null?")) string)
    (binary-op ((or "+" "-" "*" "/" "equal?" "less?" "greater?" "cons")) string)
    (n-arg-op ("list") string)

    (number ("-" digit (arbno digit)) number)
    (identifier (letter (arbno (or letter digit "_" "-" "?"))) symbol)
    (number (digit (arbno digit)) number)))

(define the-grammar
  '((program (expression) a-program)

    (expression (nullary-op) nullary-exp)
    (expression (unary-op "(" expression ")") unary-exp)
    (expression (binary-op "(" expression "," expression ")") binary-exp)
    (expression (n-arg-op "(" (separated-list expression ",") ")") list-exp)

    (expression (number) const-exp)
    (expression ("if" expression "then" expression "else" expression) if-exp)
    (expression (identifier) var-exp)
    (expression ("let" identifier "=" expression "in" expression) let-exp)
    (expression ("cond" (arbno expression "==>" expression) "end") cond-exp)))

;;;;;;;;;;;;;;;; sllgen boilerplate ;;;;;;;;;;;;;;;;

(sllgen:make-define-datatypes the-lexical-spec the-grammar)

(define show-the-datatypes
  (lambda () (sllgen:list-define-datatypes the-lexical-spec the-grammar)))

(define scan&parse
  (sllgen:make-string-parser the-lexical-spec the-grammar))

(define just-scan
  (sllgen:make-string-scanner the-lexical-spec the-grammar))
