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
                (bool-val #t))
  (check-equal? (value-of-program (scan&parse "equal?(0,3)"))
                (bool-val #f))
  (check-equal? (value-of-program (scan&parse "less?(1,3)"))
                (bool-val #t))
  (check-equal? (value-of-program (scan&parse "less?(5,3)"))
                (bool-val #f))
  (check-equal? (value-of-program (scan&parse "greater?(3,3)"))
                (bool-val #f))
  (check-equal? (value-of-program (scan&parse "greater?(5,3)"))
                (bool-val #t)))

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
    "let multiple expression"
  (check-equal? (value-of-program
                 (scan&parse "let x = 30
                              in let x = -(x, 1)
                                     y = -(x, 2)
                                 in -(x, y)"))
                (num-val 1)))

(test-case
    "let* multiple expression"
  (check-equal? (value-of-program
                 (scan&parse "let* x = 30
                              in let* x = -(x, 1)
                                     y = -(x, 2)
                                 in -(x, y)"))
                (num-val 2)))

(test-case
    "unpack"
  (check-equal? (value-of-program
                 (scan&parse "let u = 7
                              in unpack x y = cons(u, cons(3, emptylist))
                                 in -(x, y)"))
                (num-val 4)))

(test-case
    "procedure"
  (check-equal? (value-of-program
                 (scan&parse "let x = 200
                              in let f = proc (z) -(z, x)
                                 in let x = 100
                                    in let g = proc (z) -(z, x)
                                       in -((f 1), (g 1))"))
                (num-val -100)))
(test-case
    "let procedure"
  (check-equal? (value-of-program
                 (scan&parse "let x = 200
                              in letproc f (z) =  -(z, x)
                                 in let x = 100
                                    in letproc g (z) = -(z, x)
                                       in -((f 1), (g 1))"))
                (num-val -100)))

(test-case
    "curried"
  (check-equal? (value-of-program (scan&parse "let f = proc (x) proc (y) +(x, +(y, 0)) in ((f 3) 4)"))
                (num-val 7)))
(test-case
    "multiple arguments in proc"
  (check-equal? (value-of-program (scan&parse "let f = proc (x y) +(x, +(y, 0)) in (f 3 4)"))
                (num-val 7))
  (check-equal? (value-of-program (scan&parse "let f = proc () minus(3) in (f)"))
                (num-val -3)))

;; 3.23
(test-case
    "solotion to 3.23"
  (check-equal? (value-of-program (scan&parse "let makemult = proc (maker)
                                                                  proc (x)
                                                                      if zero?(x)
                                                                        then 0
                                                                        else -(((maker maker) -(x, 1)), -4)
                                               in let times4 = proc (x) ((makemult makemult) x)
                                                  in (times4 3) "))
                (num-val 12))
  (check-equal? (value-of-program (scan&parse "let makefact = proc (maker)
                                                                  proc (x)
                                                                      if zero?(x)
                                                                        then 1
                                                                        else *(((maker maker) -(x, 1)), x)
                                               in let factorial = proc (x) ((makefact makefact) x)
                                                  in (factorial 5) "))
                (num-val 120)))
