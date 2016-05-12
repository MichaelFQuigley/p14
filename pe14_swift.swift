func sequence_count(n: Int) -> Int
{
    var curr_val = n
    var count    = 0

    while curr_val != 1 
    {
        curr_val = curr_val % 2 == 0 ? curr_val/2 : curr_val*3 + 1
        count += 1
    }
    return count
}

func collatz(range: (min_n: Int, max_n:Int)) -> (max_num:Int, max_count:Int)
{
    var result = (max_num:0, max_count:0)
    for i in range.min_n...range.max_n
    {
        let temp_count = sequence_count(i)
        if temp_count > result.max_count
        {
            result = (max_num: i, max_count: temp_count)
        }
    }
    return result
}

let result = collatz((min_n:1, max_n:1000000))
print("Resulting number is \(result.max_num), max count is \(result.max_count).")
