#lang racket

(require rackunit
         "lang.rkt"
         "interp.rkt"
         "data-structures.rkt")

(test-case
    "plus"
  (check-equal? (value-of-program (scan&parse "+(1,2)"))
                (num-val 3))
  (check-equal? (value-of-program (scan&parse "minus(+(1,2))"))
                (num-val -3))
  (check-equal? (value-of-program (scan&parse "+(1,+(2, 3))"))
                (num-val 6)))

(test-case
    "multiply"
  (check-equal? (value-of-program (scan&parse "*(minus(2), 3)"))
                (num-val -6))
  (check-equal? (value-of-program (scan&parse "*(2, *(3,4))"))
                (num-val 24)))

(test-case
    "integer quotient"
  (check-equal? (value-of-program (scan&parse "/(5, 2)"))
                (num-val 2)))

(test-case
    "numeric compare"
  (check-equal? (value-of-program (scan&parse "equal?(3,3)"))
                (num-val 1))
  (check-equal? (value-of-program (scan&parse "equal?(0,3)"))
                (num-val 0))
  (check-equal? (value-of-program (scan&parse "less?(1,3)"))
                (num-val 1))
  (check-equal? (value-of-program (scan&parse "less?(5,3)"))
                (num-val 0))
  (check-equal? (value-of-program (scan&parse "greater?(3,3)"))
                (num-val 0))
  (check-equal? (value-of-program (scan&parse "greater?(5,3)"))
                (num-val 1)))

(test-case
    "list operations"
  (check-equal? (value-of-program
                 (scan&parse "let x = 4
                              in cons(x,
                                        cons(cons(-(x,1),
                                                  emptylist),
                                             emptylist))"))
                (cons-val (num-val 4) (cons-val (cons-val (num-val 3) (emptylist-val))
                                      (emptylist-val)))))

(test-case
    "list"
  (check-equal? (value-of-program
                 (scan&parse "let x = 4
                              in list(x, -(x, 1), -(x, 3))"))
                (cons-val (num-val 4)
                          (cons-val (num-val 3)
                                    (cons-val (num-val 1)
                                              (emptylist-val))))))

(test-case
    "cond"
  (check-equal? (value-of-program
                 (scan&parse "cond zero?(0) ==> 3 end"))
                (num-val 3))
  (check-equal? (value-of-program
                 (scan&parse "cond
                                  zero?(1) ==> 3
                                  null?(list()) ==> +(1,1)
                              end"))
                (num-val 2))
  (check-exn exn:fail? (lambda () (value-of-program (scan&parse "cond zero?(1) ==> 3 end")))))

(test-case
    "test if number"
  (check-equal? (value-of-program
                 (scan&parse "if 3 then 2 else 1"))
                (num-val 2))
  (check-equal? (value-of-program
                 (scan&parse "if 0 then 2 else 1"))
                (num-val 1)))
