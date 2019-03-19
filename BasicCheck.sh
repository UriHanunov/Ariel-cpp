#!/bin/bash
foldername=$1
executeble=$2
exitCode=0

cd $foldername
make
secssesfillMake=$?
if [[ secssesfillMake -gt 0 ]]; then
	echo  	Compilation     Memory leaks      thread race
	echo	FAIL            FAIL              FAIL
	exit 7
fi
	
valgrind --tool=memcheck --leak-check=full --error-exitcode=3 -q ./$2 &> /dev/null
Memory=$?
valgrind --tool=helgrind --error-exitcode=3 -q ./$2 &> /dev/null
Threads=$?

if [[ Memory -gt 0 ]]; then
	exitCode=2
	MEMO=FAIL
else
	MEMO=PASS
fi

if [[ Threads -gt 0 ]]; then
	exitCode=$exitCode + 1
	THRED=FAIL
else
	THRED=PASS
fi


echo  	Compilation      Memory leaks    thread race
echo	PASS             $MEMO            $THRED
exit $exitCode
