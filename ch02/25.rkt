#lang eopl

(require "24.rkt")

(provide max-interior)

(define (try-get-leaf t)
  (cases bintree t
         (leaf-node (num) num)
         (interior-node (k l r) #f)))

(define (node-sum t)
  (cases bintree t
         (leaf-node (num) (eopl:error "At least has one interior node"))
         (interior-node (key left right)
                        (let ([l (try-get-leaf left)]
                              [r (try-get-leaf right)])
                          (cond [(and l r)
                                 (list (list key (+ l r)))]
                                [l
                                 (let ([right-sum (node-sum right)])
                                   (cons (list key (+ l (cadar right-sum))) right-sum))]
                                [r
                                 (let ([left-sum (node-sum left)])
                                   (cons (list key (+ (cadar left-sum) r)) left-sum))])))))

(define (find-max-pair lst-of-pair pair)
  (if (null? lst-of-pair)
      pair
      (let* ([v (cadr pair)]
             [new-pair (car lst-of-pair)]
             [new-v (cadr new-pair)])
        (if (> new-v v)
            (find-max-pair (cdr lst-of-pair) new-pair)
            (find-max-pair (cdr lst-of-pair) pair)))))

(define (max-interior t)
  (let* ([node-sums (node-sum t)]
         [max-pair (find-max-pair (cdr node-sums) (car node-sums))])
    (car max-pair)))
