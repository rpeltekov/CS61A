(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (map (lambda (re) (cons first re)) rests))

(define (zip pairs)
    (list (map car pairs) (map (lambda (li) (car (cdr li))) pairs)))
;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
  (begin (define (helper li n)
    (if (eq? nil li)
      nil
      (cons (list n (car li)) (helper (cdr li) (+ n 1)))))
    (helper s 0)))
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17  
  (cond ((null? denoms) nil)
        ((< total 0) nil)
        ((= total 0) (cons (cons (car denoms) nil) nil))
        ((> (car denoms) total) (list-change total (cdr denoms)))
        ((= total (car denoms)) (append (list-change (- total (car denoms)) denoms)
                                        (list-change total (cdr denoms))))  
        (else (append (cons-all (car denoms) 
                                (list-change (- total (car denoms)) denoms)) 
                      (list-change total (cdr denoms))))))
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda

(define (let-to-lambda expr)
  (cond ((or (atom? expr) (quoted? expr))
         ; BEGIN PROBLEM 18
         expr
         ; END PROBLEM 18
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (append (list form params) (map let-to-lambda body)) 
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons (list 'lambda 
                        (car (zip values)) 
                        (car (map let-to-lambda body)))
                        (map let-to-lambda (car (cdr (zip values)))))

           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))