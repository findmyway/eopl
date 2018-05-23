#lang eopl

(provide (all-defined-out))

(define the-lexical-spec
  '((whitespace (whitespace) skip)
    (comment ("%" (arbno (not #\newline))) skip)

    (nullary-op ("emptylist") string)
    (unary-op ((or "minus" "car" "cdr")) string)
    (binary-op ((or "+" "-" "*" "/" "cons")) string)
    (n-arg-op ("list") string)

    (unary-bool-op ((or "zero?" "null?")) string)
    (binary-bool-op ((or "equal?" "less?" "greater?")) string)

    (number ("-" digit (arbno digit)) number)
    (identifier (letter (arbno (or letter digit "_" "-" "?"))) symbol)
    (number (digit (arbno digit)) number)))

(define the-grammar
  '((program (expression) a-program)
    (program (bool-expression) b-program)

    (bool-expression (unary-bool-op "(" expression ")") unary-bool-exp)
    (bool-expression (binary-bool-op "(" expression ","  expression ")") binary-bool-exp)

    (expression ("print" "(" expression ")") print-exp)

    (expression (nullary-op) nullary-exp)
    (expression (unary-op "(" expression ")") unary-exp)
    (expression (binary-op "(" expression "," expression ")") binary-exp)
    (expression (n-arg-op "(" (separated-list expression ",") ")") list-exp)

    (expression (number) const-exp)
    (expression ("if" bool-expression "then" expression "else" expression) if-exp)
    (expression (identifier) var-exp)
    (expression ("let" (arbno identifier "=" expression) "in" expression) let-exp)
    (expression ("let*" (arbno identifier "=" expression) "in" expression) let*-exp)
    (expression ("cond" (arbno bool-expression "==>" expression) "end") cond-exp)))

;;;;;;;;;;;;;;;; sllgen boilerplate ;;;;;;;;;;;;;;;;

(sllgen:make-define-datatypes the-lexical-spec the-grammar)

(define show-the-datatypes
  (lambda () (sllgen:list-define-datatypes the-lexical-spec the-grammar)))

(define scan&parse
  (sllgen:make-string-parser the-lexical-spec the-grammar))

(define just-scan
  (sllgen:make-string-scanner the-lexical-spec the-grammar))
