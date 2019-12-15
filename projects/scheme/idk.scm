(define (outer-func x y)
    (define (inner z x)
        (+ x (* y 2) (* z 3)))
    inner)


(and 1 0)