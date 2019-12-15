
; Tail recursion

(define (replicate x n)
  (define (helper n cur)
    (if (= n 0)
        cur
        (helper (- n 1) (cons x cur))))
  (helper n nil))

(define (accumulate combiner start n term)
  (define (helper comb m ter cur)
    (if (= m 0)
          cur
          (helper comb (- m 1) ter (comb cur (ter m)))))
  (helper combiner n term start))

(define (accumulate-tail combiner start n term)
  (define (helper comb m ter cur)
    (if (= m 0)
          cur
          (helper comb (- m 1) ter (comb cur (ter m)))))
  (helper combiner n term start))

; Streams

(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define multiples-of-three
  (cons-stream 3 (map-stream (lambda (x) (+ 3 x)) multiples-of-three)))


(define (nondecreastream s)
  (define (helper1 str)
    (cond ((null? (cdr-stream str)) (list (car s)))
          ((< (car (cdr-stream str)) (car str)) (cons (car str) nil))
          (else (cons (car str) (helper1 (cdr-stream str))))))

  (define (helper2 str length)
    (if (<= length 0) 
        str
        (cdr-stream (helper2 str (- length 1)))))

  (if (null? s)
      s
      (begin 
        (define inside (helper1 s))
        (cons-stream inside (nondecreastream (helper2 s (length inside)))))))


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))