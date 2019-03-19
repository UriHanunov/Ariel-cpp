#!/bin/bash
foldername=$1
executeble=$2

cd $foldername
make
secssesfillMake=$?
if [secssesfillMake -gt 0]
	then
	echo  Compilation     Memory leaks      thread race
			FAIL            FAIL              FAIL
	exit 7
	
	else
		valgrind --tool=memcheck --leak-check=full --error-exitcode=3 -q ./$executeble >  /dev/null 2>&1
		Memory=$?
		if [Memory -eq 0] 
			then
			MEMO=PASS
			else
			MEMO=FAIL
		fi

		valgrind --tool=helgrind --error-exitcode=3 -q ./$executeble > /dev/null 2>&1
		Threads=$?
		if [Threads -eq 0] 
			then
			THRED=PASS
			else
			THRED=FAIL
		fi	

fi
echo  Compilation      Memory leaks    thread race
				PASS             $MEMO            $THRED
exit 0
