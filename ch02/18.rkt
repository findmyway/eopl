#lang eopl

(provide
 number->sequence
 current-element
 move-to-left
 move-to-right
 insert-to-left
 insert-to-right)


(define (number->sequence n)
  (list n '() '()))

(define (current-element s)
  (car s))

(define (get-left s)
  (cadr s))

(define (get-right s)
  (caddr s))

(define (move-to-left s)
  (if (null? (get-left s))
      (eopl:error 'move-to-left "left is empty")
      (list (car (get-left s))
            (cdr (get-left s))
            (cons (current-element s) (get-right s)))))

(define (move-to-right s)
  (if (null? (get-right s))
      (eopl:error 'move-to-right "right is empty")
      (list (car (get-right s))
            (cons (current-element s) (get-left s))
            (cdr (get-right s)))))

(define (insert-to-left n s)
  (list (current-element s)
        (cons n (get-left s))
        (get-right s)))

(define (insert-to-right n s)
  (list (current-element s)
        (get-left s)
        (cons n (get-right s))))
