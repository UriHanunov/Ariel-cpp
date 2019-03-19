#!/bin/bash
foldername=$1
executeble=$2
$exitCode=0
cd $foldername
make
secssesfillMake=$?
if [$secssesfillMake -ne 0]
	then
	echo  Compilation     Memory leaks      thread race
			FAIL            FAIL              FAIL
	exit 7
	
valgrind --tool=memcheck --leak-check=full --error-exitcode=3 -q ./$executeble >  /dev/null 2>&1
Memory=$?
if [$Memory -eq 3] 
	then
	$exitCode=2
fi

valgrind --tool=helgrind --error-exitcode=3 -q ./$executeble > /dev/null 2>&1
Threads=$?
if [$Threads -eq 3] 
	then
	(($exitCode++))
fi	


echo  Compilation      Memory leaks    thread race
				PASS             $MEMO            $THRED
exit $exitCode
