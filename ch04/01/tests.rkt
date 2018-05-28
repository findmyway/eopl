#lang racket

(require rackunit
         "lang.rkt"
         "data-structures.rkt"
         "interp.rkt")

(define (run s)
  (value-of-program (scan&parse s)))


(test-case
    "simple arithmetic"
  (check-equal? (run "11") (num-val 11))
  (check-equal? (run "-33") (num-val -33))
  (check-equal? (run "-(44,33)") (num-val 11)))

(test-case
    "nested arithmetic"
  (check-equal? (run "-(-(44,33),22)") (num-val -11))
  (check-equal? (run "-(55, -(22,11))") (num-val 44)))

(test-case "simple variables"
  (check-equal? (run "x") (num-val 10))
  (check-equal? (run "-(x,1)") (num-val 9))
  (check-equal? (run "-(1,x)") (num-val -9)))

(test-case "simple unbound variables"
  (check-exn exn:fail? (lambda () (run "foo")))
  (check-exn exn:fail? (lambda () (run "-(x,foo)"))))

(test-case "simple conditionals"
  (check-equal? (run "if zero?(0) then 3 else 4") (num-val 3))
  (check-equal? (run "if zero?(1) then 3 else 4") (num-val 4)))

(test-case "test dynamic typechecking"
  (check-exn exn:fail? (lambda () (run "-(zero?(0),1)")))
  (check-exn exn:fail? (lambda () (run "-(1,zero?(0))")))
  (check-exn exn:fail? (lambda () (run "if 1 then 2 else 3"))))

(test-case "make sure that the test and both arms get evaluated properly."
  (check-equal? (run "if zero?(-(11,11)) then 3 else 4") (num-val 3))
  (check-equal? (run "if zero?(-(11, 12)) then 3 else 4") (num-val 4)))

(test-case "and make sure the other arm doesn't get evaluated."
  (check-equal? (run "if zero?(-(11, 11)) then 3 else foo") (num-val 3))
  (check-equal? (run "if zero?(-(11,12)) then foo else 4") (num-val 4)))

(test-case "simple let"
  (check-equal? (run "let x = 3 in x") (num-val 3)))

(test-case "make sure the body and rhs get evaluated"
  (check-equal? (run "let x = 3 in -(x,1)") (num-val 2))
  (check-equal? (run "let x = -(4,1) in -(x,1)") (num-val 2)))

(test-case "check nested let and shadowing"
  (check-equal? (run "let x = 3 in let y = 4 in -(x,y)") (num-val -1))
  (check-equal? (run "let x = 3 in let x = 4 in x") (num-val 4))
  (check-equal? (run "let x = 3 in let x = -(x,1) in x") (num-val 2)))

(test-case "simple applications"
  (check-equal? (run "(proc(x) -(x,1)  30)") (num-val 29))
  (check-equal? (run "let f = proc (x) -(x,1) in (f 30)") (num-val 29))
  (check-equal? (run "(proc(f)(f 30)  proc(x)-(x,1))") (num-val 29))

  (check-equal? (run "((proc (x) proc (y) -(x,y)  5) 6)") (num-val -1))
  (check-equal? (run "let f = proc(x) proc (y) -(x,y) in ((f -(10,5)) 6)") (num-val -1))

  (check-equal?
   (run " let fix =  proc (f)
                          let d = proc (x) proc (z) ((f (x x)) z)
                          in proc (n) ((f (d d)) n)
              in let t4m = proc (f) proc(x) if zero?(x) then 0 else -((f -(x,1)),-4)
                 in let times4 = (fix t4m)
                    in (times4 3)")
   (num-val 12)))

(test-case "simple letrecs"
  (check-equal? (run "letrec f(x) = -(x,1) in (f 33)") (num-val 32))
  (check-equal?
   (run "letrec f(x) = if zero?(x)  then 0 else -((f -(x,1)), -2) in (f 4)")
   (num-val 8))

  (check-equal?
   (run
    "let m = -5
      in letrec f(x) = if zero?(x)
                       then 0
                       else -((f -(x,1)), m)
          in (f 4)")
   (num-val 20))

  (check-equal?
   (run
    "letrec even(odd)  = proc(x) if zero?(x) then 1 else (odd -(x,1))
      in letrec  odd(x)  = if zero?(x) then 0 else ((even odd) -(x,1))
      in (odd 13)")
   (num-val 1))

  (test-case
      "begin expressions"
    (check-equal? (run "begin 1; 2; 3 end") (num-val 3))))

(test-case
    "references"
  (check-equal?
   (run
    "let g = let counter = newref(0)
            in proc (dummy) let d = setref(counter, -(deref(counter),-1))
                        in deref(counter)
     in -((g 11),(g 22))")
   (num-val -1))

  (check-equal? (run "let x = newref(17) in deref(x)") (num-val 17))

  (check-equal? (run "let x = newref(17)
                          in begin setref(x,27); deref(x) end")
                (num-val 27))

  (check-equal?
   (run "let g = let counter = newref(0)
                  in proc (dummy) begin
                                    setref(counter, -(deref(counter),-1));
                                    deref(counter)
                                  end
         in -((g 11),(g 22))")
   (num-val -1))

  (check-equal?
   (run "let x = newref(0)
        in letrec even(d) = if zero?(deref(x))
                          then 1
                          else let d = setref(x, -(deref(x),1))
                                in (odd d)
                  odd(d)  = if zero?(deref(x))
                          then 0
                          else let d = setref(x, -(deref(x),1))
                                in (even d)
          in let d = setref(x,13) in (odd -100)")
   (num-val 1))

  (check-equal?
   (run "let x = newref(0)
        in letrec even(d) = if zero?(deref(x))
                          then 1
                          else let d = setref(x, -(deref(x),1))
                                in (odd d)
                  odd(d)  = if zero?(deref(x))
                          then 0
                          else let d = setref(x, -(deref(x),1))
                                in (even d)
          in let d = setref(x,13) in (odd -100)")
   (num-val 1))

  (check-equal?
   (run "let x = newref(22)
        in let f = proc (z)
                        let zz = newref(-(z,deref(x)))
                        in deref(zz)
            in -((f 66), (f 55))")
   (num-val 11))

  (check-equal?
   (run "let x = newref(newref(0))
                      in begin
                          setref(deref(x), 11);
                          deref(deref(x))
                        end")
   (num-val 11)))


(test-case
    "example of exercise 4.1"
  (check-equal?
   (run "let x = newref(newref(0))
         in begin
              setref(deref(x), 11);
              deref(deref(x))
            end")
   (num-val 11)))
