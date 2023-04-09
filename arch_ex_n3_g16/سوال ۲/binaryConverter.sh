#!/bin/bash



function fill32Bit () {
	
	if [[ ${nob} -lt 33 ]] 
	then 
		diff=`expr 33 - $nob`
		j=1;	
		while [[ $j -le $diff ]] 
		do 
			echo -n "0"
		        j=`expr $j + 1`	
		done 
	fi
}

function rTypeToBinary () {
	
	TYPE="R-Type"
	echo "$TYPE"
	for i in `cat ../README.md | grep 0x | grep "${TYPE}" |  awk '{print $2}' | sed 's/^..//g' | sed 's/[a-z]/\U&/g'`
	do 
		echo -n "| $i " 
		nob=`echo "obase=2; ibase=16; $i" | bc |wc -c`
		#fill32Bit
		#echo "obase=2; ibase=16; $i" | bc 
		( fill32Bit && echo "obase=2; ibase=16; $i" | bc ) | sed 's/.\{7\}/& | /' | sed 's/.\{15\}/& | /' | sed 's/.\{23\}/& | /g' | sed 's/.\{29\}/& | /g' | sed 's/.\{37\}/& | /g' | sed 's/^/| /g' | sed 's/$/ |/g'	
       	done 
}

function iTypeToBinary () {
	
	TYPE="I-Type"
	echo "$TYPE"
	for i in `cat ../README.md | grep 0x | grep $TYPE| awk '{print $2}' | sed 's/^..//g' | sed 's/[a-z]/\U&/g'`
	do 
		echo -n "| $i " 
		nob=`echo "obase=2; ibase=16; $i" | bc |wc -c`
		( fill32Bit && echo "obase=2; ibase=16; $i" | bc ) | sed 's/.\{12\}/& | /' | sed 's/.\{20\}/& | /' | sed 's/.\{26\}/& | /g' | sed 's/.\{34\}/& | /g' | sed 's/^/| /g' | sed 's/$/ |/g'	
       	done 
}
function sbTypeToBinary () {
	
	TYPE="S/B-Type"
	echo "$TYPE"
	for i in `cat ../README.md | grep 0x | grep $TYPE| awk '{print $2}' | sed 's/^..//g' | sed 's/[a-z]/\U&/g'`
	do 
		echo -n "| $i " 
		nob=`echo "obase=2; ibase=16; $i" | bc |wc -c`
		( fill32Bit && echo "obase=2; ibase=16; $i" | bc ) | sed 's/.\{7\}/& | /' | sed 's/.\{15\}/& | /' | sed 's/.\{23\}/& | /g' | sed 's/.\{29\}/& | /g' | sed 's/.\{37\}/& | /g' | sed 's/^/| /g' | sed 's/$/ |/g'	
       	done 
}
function ujTypeToBinary () {
	
	TYPE="U/J-Type"
	echo "$TYPE"
	for i in `cat ../README.md | grep 0x | grep $TYPE| awk '{print $2}' | sed 's/^..//g' | sed 's/[a-z]/\U&/g'`
	do 
		echo -n "| $i | " 
		nob=`echo "obase=2; ibase=16; $i" | bc |wc -c`
		( fill32Bit && echo "obase=2; ibase=16; $i" | bc ) | sed 's/.\{20\}/& | /' | sed 's/.\{28\}/& | /' | sed 's/^/| /g' | sed 's/$/ |/g'	
       	done
}
rTypeToBinary 
iTypeToBinary
sbTypeToBinary
ujTypeToBinary



