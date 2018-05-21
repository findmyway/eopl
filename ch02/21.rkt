#lang eopl

(provide
 env?
 empty-env
 extend-env
 apply-env
 has-binding?)

(define-datatype env env?
  (empty-env)
  (extend-env
   (_var var?)
   (_val value?)
   (_env env?)))

(define var? symbol?)

(define (value? x) #t)

(define (apply-env e v)
  (cases env e
         (empty-env ()
                    (eopl:error 'apply-env "no binding for ~s" v))
         (extend-env (_var _val _env)
                     (if (equal? v _var)
                         _val
                         (apply-env _env v)))))


(define (has-binding? e v)
  (cases env e
         (empty-env ()
                    #f)
         (extend-env (_var _val _env )
                     (or (equal? v _var)
                         (has-binding? _env v)))))
