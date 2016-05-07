$cache = Hash.new

def chain_count(n)
    while n != 1 do
        if $cache.has_key?(n)
            return $cache[n]
        end
        $cache[n] = 1 + (n%2 == 0 ? chain_count(n/2) : chain_count(n*3 + 1))
    end
    return $cache.has_key?(n) ? $cache[n] : 0
end

def collatz(minR, maxR)
    currBest = [0,0]
    for i in minR..maxR
        n = chain_count(i)
        if n > currBest[1]
            currBest = [i, n]
        end
    end
    return currBest
end

result = collatz(1,1000000)
puts "Resulting number is " + result[0].to_s + ", max count is " + result[1].to_s
