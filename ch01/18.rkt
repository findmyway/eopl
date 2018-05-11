#lang eopl

(provide
 ;; (swapper s1 s2 slist) -> slist
 ;; swap s1 in slist into s2 and swap s2 in slist into s1
 swapper)

(define swapper
  (lambda (s1 s2 slist)
    (map (lambda (s)
           (if (symbol? s)
               (cond
                 [(equal? s s1) s2]
                 [(equal? s s2) s1]
                 [else s])
               (swapper s1 s2 s)))
         slist)))
