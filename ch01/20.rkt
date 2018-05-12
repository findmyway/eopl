#lang eopl

(provide
 ;; (count-occurrences s slist)
 ;; returns the number of occurences of s in slist
 count-occurences)

(define (count-occurences s slist)
  (define (helper-fun s slist n)
    (if (null? slist)
        n
        (if (symbol? (car slist))
            (if (equal? s (car slist))
                (helper-fun s (cdr slist) (+ n 1))
                (helper-fun s (cdr slist) n))
            (helper-fun s
                        (cdr slist)
                        (+ n (helper-fun s (car slist) 0))))))
  (helper-fun s slist 0))
