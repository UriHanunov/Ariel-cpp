#!/bin/bash
foldername=$1
executeble=$2
exitCode=0
MEMO
THRED

cd $foldername
make
secssesfillMake=$?
if [[$secssesfillMake -gt 0]]; then
	echo  	Compilation     Memory leaks      thread race
				FAIL            FAIL              FAIL
	exit 7
fi
	
valgrind --tool=memcheck --leak-check=full --error-exitcode=3 -q ./$2 &> temp.txt
Memory=$?
valgrind --tool=helgrind --error-exitcode=3 -q ./$2 &> temp.txt
Threads=$?
if [[$Memory -gt 0]]; then
	exitCode=2
	$MEMO=FAIL
fi
if[[$Threads -gt 0]]; then
	exitCode=$exitCode+1
	$THRED=FAIL
fi


echo  	Compilation      Memory leaks    thread race
	PASS             $MEMO            $THRED
exit $exitCode
