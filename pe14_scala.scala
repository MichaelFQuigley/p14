object Pe14 {

    def chain_count(n: Long, count: Long): Long =
        if ( n == 1 )
            count
        else 
            chain_count(if (n%2 == 0) n/2 else n*3 + 1, count + 1)

    def collatz(minR: Long, maxR: Long): Tuple2[Long, Long] =
        (for(i <- minR until (maxR + 1)) yield (i, chain_count(i, 0)))
        .reduceLeft ( (a,b) => (if (a._2 > b._2) a else b) )

    def main(args: Array[String])
    {
        val result = collatz(1, 1000000)
        println("Resulting number is " + result._1  + ", max count is " + result._2)
    }
}
