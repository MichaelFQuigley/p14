function countChain(n, cache)
{
    count = 0;
    initialVal = n;
    while( n !== 1 )
    {
        if(n in cache)
        {
            cache[initialVal] = count + cache[n];
            return cache[initialVal];
        }
        if (n % 2 === 0)
            n /= 2;
        else
            n = n * 3 + 1;
        count++;
    }
    cache[initialVal] = count;
    return cache[initialVal];
}

function collatz(minR, maxR)
{
    currBest = [0,0];
    cache = {};
    for(i = minR; i < maxR + 1; i++)
    {
        n = countChain(i, cache)
        if(n > currBest[1])
        {
            currBest = [i, n];
        }
    }
    return currBest;
}

result = collatz(1, 1000000);
console.log("Resulting number is " + result[0] + ", max count is " + result[1])
