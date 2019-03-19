#!/bin/bash
foldername=$1
executeble=$2
curentLoctin=`pwd`

cd $foldername
make
secssesfillMake=$?
if[secssesfillMake -gt 0]; then
echo  Compilation     Memory leaks      thread race
         FAIL            FAIL              FAIL
exit 7
fi
valgrind --tool=memcheck --leak-check=full --error-exitcode=3 -q ./$executeble >  /dev/null 2>&1
Memory=$?
valgrind --tool=helgrind --error-exitcode=3 -q ./$executeble > /dev/null 2>&1
Threads=$?
if[Memory -eq 0]; then
if[Threads -eq 0]; then
echo  Compilation     Memory leaks    thread race
         PASS            PASS            PASS
exit 0
else
echo  Compilation     Memory leaks    thread race
         PASS             PASS            FAIL
exit 1
else if[Threads -eq 0]; then
echo  Compilation      Memory leaks    thread race
         PASS             FAIL            PASS
exit 2
else
echo  Compilation      Memory leaks    thread race
         PASS             FAIL            FAIL
exit 3
fi
