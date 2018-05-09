#lang eopl

;; 1.1
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; {3n + 2 | n \in N}
;;
;; Top-down
;;
;; A natural number n is in S if and only if
;; 1. n = 2, or
;; 2. n - 3 \in S
;;
;; Bottom-up
;;
;; Define the set S to be the smallest set contained in N
;; and satisfying the following two property:
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

;; 1.2
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; {2n + 3m + 1|n, m \in N}
;;
;; Top-down
;;
;; A natural number n is in S if and only if
;; 1. n = 1, or
;; 2. n - 2 \in S, or
;; 3. n - 3 \in S
;;
;; Bottom-up
;;
;; Define the set S to be the smallest set contained in N
;; and satisfying the following two property:
;; 1. 1 \in S
;; 2. if n \in S, then n + 2 \in S and n + 3 \in S
;;
;; Rules of inference
;;
;;
;; --------------------
;;       1 \in S
;;
;;                 n \in S
;; ----------------------------------------
;;     (n + 2) \in S  (n + 3) \in S

;; 1.3
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; {(n, 2n + 1) | n \in N}
;;
;; Top-down
;;
;; A pair (a, b) is in S if and only if 
;; 1. (a, b) = (0, 1), or
;; 2. (a - 1, b - 2) \in S
;;
;; Bottom-up
;;
;; Define the set S to be the smallest set contained in {a, b| a \in N, b \in N}
;; and satisfying the following two property:
;; 1. (a, b) = (0, 1)
;; 2. if (a, b) \in S, then (a + 1, b + 2) \in S
;;
;; Rules of inference
;;
;;
;; --------------------
;;    (0, 1) \in S
;;
;;       (a, b) \in S
;; -------------------------
;;   (a + 1, b + 2) \in S

;; 1.4
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; {(n, n^2) | n \in N}
;;
;; Top-down
;;
;; A pair (a, b) is in S if and only if
;; 1. (a, b) = (0, 0)
;; 2. (a - 1, b - 2a + 1) \in S
;;
;; Bottom-up
;;
;; Define the set S to be the smallest set contained in {a, b| a \in N, b \in N}
;; and satisfying the following two property:
;; (0, 0) \in S
;; if (a, b) \in S, then (a + 1, a^2 + 2a + 1) \in S
;;
;; Rules of inference
;;
;; --------------------
;;     (0, 0) \in S
;;
;;     (a, b) \in S
;; ----------------------------------
;;   (a + 1, a^2 + 2a + 1) \in S
