cache = {}

def longest_chain(n):
    while n != 1:
        if n in cache:
            return cache[n]
        else:
            if n % 2 == 0:
                cache[n] = (1 + longest_chain(n/2))
            else:
                cache[n] = (1 + longest_chain(n * 3 + 1))
    return cache[n] if n in cache else 0

def collatz(minR, maxR):
    #format of best is (bestNum, bestCount)
    currBest = (0,0)
    for i in range(minR, maxR + 1):
        n = longest_chain(i)
        if n > currBest[1]:
            currBest = (i, n)
    return currBest


result = collatz(1,1000000)
print "Resulting number is " + str(result[0]) + ", max count is " + str(result[1])
