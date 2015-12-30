#lang racket

(define (countChain n)
    (if (= n 1) 0
     (if (= (modulo n 2) 0)
      (+ 1 (countChain (/ n 2)))
      (+ 1 (countChain (+ (* 3 n) 1))))))

(write (countChain 8))
