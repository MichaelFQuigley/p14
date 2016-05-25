: chain_count ( n -- n' )
    0 begin swap dup 1 <> while
    dup 2 mod 0 = if 2/ else 3 * 1 + then swap 1 +
    repeat drop ;

: collatz ( minR maxR -- bestNum maxCount )
    1 +
    swap 0 swap rot swap 0 swap rot swap \ put init bestNum and maxCount on stack.
    do dup i chain_count dup rot 
    > if \ if temp maxCount is greater than current maxCount ... 
    i rot drop rot drop swap 
    else drop then
    loop ;

1 1000000 collatz swap
s" Resulting number is " type . s" , max count is " type . CR
bye
