#!/bin/bash
foldername=$1
executeble=$2
exitCode=0

cd $foldername
make
secssesfillMake=$?
if [secssesfillMake -gt 0]; then
	echo  	Compilation     Memory leaks      thread race
		   FAIL            FAIL              FAIL
	exit 7
fi
	
valgrind --leak-check=full --error-exitcode=1 ./$2 &> temp.txt
Memory=$?
valgrind --tool=helgrind --error-exitcode=1 ./$2 &> temp.txt
Threads=$?
if [Memory -ne 0]; then
	exitCode=2
fi
if[Threads -ne 0]; then
	exitCode=$exitCode+1
fi


echo  Compilation      Memory leaks    thread race
	PASS             $MEMO            $THRED
exit $exitCode
