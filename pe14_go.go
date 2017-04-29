package main

import (
  "strconv"
  "fmt"
  "sync"
)

var waitGroup sync.WaitGroup

type CollatzPair struct {
  bestNum int
  maxCount int
}

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

func collatz(minR int, maxR int, collatzChan chan CollatzPair) {
  var bestNum  int = 0
  var maxCount int = 0
  for i := minR; i <= maxR; i++ {
    var tempMaxCount = chain_count(i)
    if tempMaxCount > maxCount {
      maxCount = tempMaxCount
      bestNum  = i
    }
  }
  collatzChan <- CollatzPair{bestNum, maxCount}
  defer waitGroup.Done()
}

func monitor(collatzChan chan CollatzPair) {
    waitGroup.Wait()
    close(collatzChan)
}

func main() {
  var numChans int = 16
  collatzChan := make(chan CollatzPair)
  for i := 0; i < numChans; i++ {
    waitGroup.Add(1)
    go collatz(i * (1000000/numChans) + 1, (i + 1) * (1000000/numChans), collatzChan)
  }
  go monitor(collatzChan)
  var bestCollatzPair CollatzPair = CollatzPair{0, 0}
  for collatzPair := range collatzChan {
    if (collatzPair.maxCount > bestCollatzPair.maxCount) {
      bestCollatzPair = collatzPair
    }
  }
  fmt.Println("Resulting number is " + strconv.Itoa(bestCollatzPair.bestNum) +
        ", max count is " + strconv.Itoa(bestCollatzPair.maxCount));
}
