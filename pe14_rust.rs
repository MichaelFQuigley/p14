fn sequence_count(n: u64) -> u64
{
    let mut curr_val = n;
    let mut count    = 0;

    while curr_val != 1 {
        curr_val =
            if curr_val % 2 == 0
            {
                curr_val >> 1
            }
            else
            {
                curr_val * 3 + 1
            };
        count += 1;
    }

    count
}

//range is of format (min, max)
//returns (max_num, max_count)
fn max_sequence(range: (u64, u64)) -> (u64, u64)
{
    let mut max_num   = 0u64;
    let mut max_count = 0u64;

    for i in range.0..range.1
    {
       let temp_count = sequence_count(i);
       if temp_count > max_count
       {
           max_num   = i;
           max_count = temp_count;
       }
    }

    (max_num, max_count)
}

fn main()
{
    let result = max_sequence((1,1000000));
   println!("Resulting number is {}, max count is {}", result.0, result.1);
}
