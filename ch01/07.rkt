#lang eopl

(provide
 nth-element-rewrite)

(define (report-list-too-short n)
  (eopl:error 'nth-element
              "List too short by ~s elements.~%"
              (+ n 1)))

(define (nth-element lst n)
  (if (null? lst)
      (report-list-too-short n)
      (if (zero? n)
          (car lst)
          (nth-element (cdr lst) (- n 1)))))

(define nth-element-rewrite
  (letrec ([nth-element (lambda (lst n)
                          (if (null? lst)
                              #f
                              (if (zero? n)
                                  (car lst)
                                  (nth-element (cdr lst) (- n 1)))))]
           [report-list-too-short (lambda (lst n)
                                    (eopl:error 'nth-element-rewrite
                                                "~s doesn't have ~s elements.~%"
                                                lst n))])
    (lambda (lst n)
      (let ([res (nth-element lst n)])
        (if res
            res
            (report-list-too-short lst n))))))

