package main

import (
        "strconv"
        "fmt"
)

func chain_count(n int) int {
    for n != 1 {
        if n % 2 == 0 {
            return 1 + chain_count(n / 2)
        } else {
            return 1 + chain_count(n * 3 + 1)
        }
    }
    return 0
}

func collatz(minR int, maxR int) {
    var bestNum  int = 0
    var maxCount int = 0
    for i := minR; i <= maxR; i++ {
        var tempMaxCount = chain_count(i)
        if tempMaxCount > maxCount {
            maxCount = tempMaxCount
            bestNum  = i
        }
    }
    fmt.Println("Resulting number is " + strconv.Itoa(bestNum) + ", max count is " + strconv.Itoa(maxCount))
}

func main() {
    collatz(1, 1000000)
}
