#!/bin/bash

#This solution is really slow. 
#But, I guess realistically, you wouldn't do this in a bash script anyways.

declare -gA CACHE
resultCount=0

#params: number to run collatz count on
countN() {
#    local CACHE=$2
    local initialVal=$1
    local currVal=$1
    local count=0
    while [ $currVal -ne 1 ]; do
        if [ ${CACHE[$currVal]} ]; then
            CACHE[$initialVal]=$(($count+${CACHE[$currVal]}))
            resultCount=${CACHE[$initialVal]}
            return
        elif [ $(($currVal%2)) -eq 0 ]; then
            currVal=$(($currVal/2))
        else
            currVal=$(($(($currVal*3)) + 1))
        fi
        count=$(($count+1))
    done
    CACHE[$initialVal]=$count
    resultCount=$count
}

#params: max number to iterate up to
maxCollatz() {
   local currMaxNum=0
   local currMaxCount=0 
   local currNum=1
   while [ $1 -ge $currNum ]; do
       countN $currNum $CACHE
       if [ $resultCount -gt $currMaxCount ]; then
        currMaxCount=$resultCount
        currMaxNum=$currNum
       fi
       currNum=$(($currNum+1))
   done
   echo "Resulting number is $currMaxNum, max count is $currMaxCount"

}

maxCollatz 1000000
