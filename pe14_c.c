#include <time.h>
#include <stdio.h>
#include <stdint.h>
#include <pthread.h>


#define NUM_THREADS 6

typedef struct int_tup {
    uint32_t a;
    uint32_t b;
} int_tup_t;

typedef struct thread_data{
    int_tup_t range;
    int_tup_t result;
} thread_data_t;

static uint32_t chain_count(uint32_t n)
{
    uint32_t curr_val = n;
    uint32_t count    = 0;

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



//result is an array that looks as follows: {max_num, max_count}
static int_tup_t max_collatz(int_tup_t range)
{
    int_tup_t result;
    result.a = 0;
    result.b = 0;

    for(int i = range.a; i <= range.b; i++)
    {
        uint32_t result_count = chain_count(i);

        if( result_count > result.b )
        {
            result.a = i;
            result.b = result_count;
        }
    }

    return result;
}

static void* thread_fn(void* data)
{
    thread_data_t* tdata = (thread_data_t*)data;
    tdata->result = max_collatz(tdata->range);
    pthread_exit(NULL);
}

//result is an array that looks as follows: {max_num, max_count}
static int_tup_t max_collatz_threaded(int_tup_t range){

    pthread_t threads[NUM_THREADS];
    thread_data_t tdata[NUM_THREADS];
    int_tup_t result;
    result.a = 0;
    result.b = 0;

    for(uint32_t i = 0; i < NUM_THREADS; i++)
    {
        tdata[i].range.a  = range.a + (i * (range.b - range.a)) / NUM_THREADS;
        tdata[i].range.b  = range.a + ((i + 1) * (range.b - range.a)) / NUM_THREADS;
        tdata[i].range.b  = (i == NUM_THREADS - 1) ? tdata[i].range.b : tdata[i].range.b - 1;
        tdata[i].result.a = 0;
        tdata[i].result.b = 0;

        if( pthread_create(&threads[i], NULL, thread_fn, (void*) &tdata[i]) )
        {
            printf("Error creating thread %d\n", i);
        }
    }


    for(uint32_t i = 0; i < NUM_THREADS; i++)
    {
        pthread_join(threads[i],NULL);
 
        if( tdata[i].result.b > result.b )
        {
            result = tdata[i].result;
        }
   }

    return result;
}



int main()
{
    int_tup_t range;
    range.a = 1;
    range.b = 1000000;
    struct timespec start, end;

    clock_gettime(CLOCK_MONOTONIC, &start);
    int_tup_t result = max_collatz_threaded(range);
    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_taken = (end.tv_sec - start.tv_sec);
    time_taken       += (end.tv_nsec - start.tv_nsec) / 1000000000.0;

    printf("Resulting number is %d, max count is %d\n", result.a, result.b);
    printf("Time taken is %f seconds\n", time_taken);
    return 0;
}
