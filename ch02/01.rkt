#lang eopl

(provide
 int2bigits
 zero
 is-zero?
 successor
 predecessor
 plus
 multiply
 factorial
 )

(define N 16)

(define (int2bigits n)
  (let ([q (quotient n N)]
        [r (remainder n N)])
    (if (> q 0)
        (cons r (int2bigits q))
        (list r))))

(define zero '(0))

(define (is-zero? n) (equal? n zero))

(define (successor n)
  (cond [(null? n) '(1)]
        [(equal? (car n) (- N 1)) (cons 0 (successor (cdr n)))]
        [else (cons (+ (car n) 1) (cdr n))]))

(define (predecessor n)
  (define (del-0 n)
    (cond [(null? (cdr n)) n]
          [(zero? (car n)) (del-0 (cdr n))]
          [else n]))
  (let ([pre-n (cond [(zero? (car n))
                      (cons (- N 1)
                            (predecessor (cdr n)))]
                     [else (cons (- (car n) 1) (cdr n))])])
    (reverse (del-0 (reverse pre-n)))))

(define (plus a b)
  ;; make sure a is greater than b to speed up
  (cond [(is-zero? b) a]
        [else (plus (successor a) (predecessor b))]))

(define (multiply a b)
  ;; make sure a is greater than b to speed up
  (cond [(or (is-zero? a) (is-zero? b)) zero]
        [else (plus (multiply a (predecessor b)) a)]))

(define (factorial n)
  (cond [(is-zero? n) (successor zero)]
        [else (multiply (factorial (predecessor n)) n)]))

;; 01.rkt﻿> (define N 16)
;; 01.rkt﻿> (for-each (lambda (x) (time (factorial x))) '((5) (6) (7) (8) (9) (10)))
;; cpu time: 0 real time: 0 gc time: 0
;; cpu time: 0 real time: 0 gc time: 0
;; cpu time: 0 real time: 1 gc time: 0
;; cpu time: 16 real time: 7 gc time: 0
;; cpu time: 63 real time: 67 gc time: 0
;; cpu time: 765 real time: 755 gc time: 63
;; 01.rkt﻿> (define N 32)
;; 01.rkt﻿> (for-each (lambda (x) (time (factorial x))) '((5) (6) (7) (8) (9) (10)))
;; cpu time: 0 real time: 0 gc time: 0
;; cpu time: 0 real time: 0 gc time: 0
;; cpu time: 0 real time: 1 gc time: 0
;; cpu time: 16 real time: 8 gc time: 0
;; cpu time: 62 real time: 59 gc time: 0
;; cpu time: 610 real time: 617 gc time: 0
;; 01.rkt﻿> (define N 64)
;; 01.rkt﻿> (for-each (lambda (x) (time (factorial x))) '((5) (6) (7) (8) (9) (10)))
;; cpu time: 0 real time: 0 gc time: 0
;; cpu time: 0 real time: 0 gc time: 0
;; cpu time: 0 real time: 1 gc time: 0
;; cpu time: 15 real time: 7 gc time: 0
;; cpu time: 63 real time: 60 gc time: 15
;; cpu time: 640 real time: 640 gc time: 47
