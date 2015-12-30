(*returns the chain count for a given number*)
let rec countN n cache =
        if n = 1 then 0
        else if Hashtbl.mem cache n then
                Hashtbl.find cache n
            else let cachedCount = 
                if (n mod 2) = 0 then
                  (1 + (countN (n / 2) cache))
                else
                  (1 + (countN ((3 * n) + 1) cache))
                in(
                    Hashtbl.add cache n cachedCount;
                    cachedCount);;

(* returns the number that results in the highest number of iterations of the
 * collatz conjecture from min range to max range*)
let rec collatz (currNum, maxNum) cache (bestNum, bestNumCount) = 
    if currNum > maxNum then
       (bestNum, bestNumCount)
    else
        let tempCount = (countN currNum cache) in
           if tempCount >  bestNumCount then
                collatz (currNum + 1, maxNum) cache (currNum, tempCount)
           else
                collatz (currNum + 1, maxNum) cache (bestNum, bestNumCount);;

let startT = Sys.time();;
let (resultNum, resultCount) = (collatz (1,1000000) (Hashtbl.create 1000) (0, 0));;
Printf.printf "Resulting number is %d, max count is %d\n" resultNum resultCount;;
Printf.printf "Running time was %f seconds\n" (Sys.time() -. startT);;
