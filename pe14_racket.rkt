#lang racket

;finds longest chain
(define (countChain n)
    (if (= n 1) 0
     (if (= (modulo n 2) 0)
      (+ 1 (countChain (/ n 2)))
      (+ 1 (countChain (+ (* 3 n) 1))))))

;best is a list of of the following format: '(bestNum, bestNumCount)
(define (collatz currNum maxNum best)
    (if (> currNum maxNum)
     best
     (let ([tempCount (countChain currNum)])
           (if (> tempCount (cadr best))
            (collatz (+ currNum 1) maxNum (list currNum tempCount))
            (collatz (+ currNum 1) maxNum best)))))

(let ([result (collatz 1 1000000 '(0 0))])
   (printf "Resulting number is ~s, max count is ~s\n" 
           (car result)
           (cadr result)))
