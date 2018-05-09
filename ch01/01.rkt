#lang eopl


;; {3n + 2 | n \in N}
;;
;; Top-down
;;
;; A natural number n is in S if and only if
;; 1. n = 2, or
;; 2. n - 3 \in S
;;
;; Bottom-up
;; 1. 2 \in S
;; 2. if n \in S, then (n + 3) \in S
;;
;; Rules of inference
;;
;; ------------------
;;       2 \in S
;;
;;       n \in S
;; ------------------
;;   (n + 3) \in S


;; {2n + 3m + 1|n, m \in N}
;; 
