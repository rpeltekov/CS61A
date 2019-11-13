;;;;;;;;;;;;;;;
;; Questions ;;
;;;;;;;;;;;;;;;

; Scheme

(define (cddr s)
        (cdr (cdr s)))

(define (cadr s)
        (car (cdr s)))

(define (caddr s)
        (car (cddr s)))

(define (sign x)
        (cond ((> 0 x) -1)
              ((< 0 x) 1)
              (else 0)))

(define (square x) (* x x))

(define (pow b n)
        (cond ((= n 1) b)
              ((even? n) (square (pow b (/ n 2))))
              (else (* b (square (pow b (/ (- n 1) 2)))))))

(define (unique s)
        (if (eq? s nil)
            nil
            (cons (car s)
                  (unique (filter (lambda (x)
                                          (not (eq? x (car s))))
                                  s)))))
