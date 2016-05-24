public class pe14_java
{
    private static class CurrentResult
    {
        private long bestNum;
        private long bestNumCount; 
        public CurrentResult(long bestNum, long bestNumCount)
        {
            this.bestNum      = bestNum;
            this.bestNumCount = bestNumCount;
        }

        public long getBestNum()
        {
            return bestNum;
        }

        public long getBestNumCount()
        {
            return bestNumCount;
        }
    }

    private static long chain_count(long n)
    {
       long curr_val = n;
       long count    = 0;

        while( curr_val != 1 )
        {
            if( (curr_val % 2) == 0 )
            {
                curr_val >>= 1;
            }
            else
            {
                curr_val = curr_val * 3 + 1;
            }
            count++;
        }

        return count;
    }

    private static CurrentResult collatz(long minR, long maxR)
    {
        CurrentResult result = new CurrentResult(0, 0);

        for( long i = minR; i <= maxR; i++ )
        {
            long n = chain_count(i);
            if( n > result.getBestNumCount() )
            {
                result = new CurrentResult(i, n);
            }
        }

       return result; 
    }

    public static void main(String[] args)
    {
        CurrentResult result = collatz(1, 1000000);
        System.out.println("Resulting number is " 
                           + result.getBestNum()
                           + ", max count is "
                           + result.getBestNumCount());
                           
    }
}
