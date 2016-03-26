import Data.List
import Data.Ord

longest_chain n count
    | n == 1         = count
    | (mod n 2) == 0 = longest_chain (quot n 2) (count+1)
    | otherwise      = longest_chain (n*3+1) (count+1)

collatz minR maxR =
    maximumBy (comparing fst) (map (\x -> (longest_chain x 0, x)) [minR..maxR])

main = (print ("Resulting number is "
            ++(show (snd result))
            ++", max count is "
            ++(show (fst result))
            ++"."))
        where result = (collatz 1 1000000)
