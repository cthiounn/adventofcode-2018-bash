#!/bin/sh
# NON FONCTIONAL

part1() {
	declare -A tab_total_sleep
	declare -A tab_total_sleep_by_minute
	dateSleep=""
	guard_number=""
	while read line || [ -n "$line" ] ; 
		do 
			read -r date hour type number _ <<< "${line}"
			date="${date/'['}"
            hour="${hour/']'}"
            if [ "$type" == "Guard" ]
				then guard_number="${number/'#'}"
			elif [ "$type" == "falls" ] 
				then dateSleep="$date $hour"
			elif [ "$type" == "wakes" ] 
				then total=1;
				tab_total_sleep[$guard_number]=$(( tab_total_sleep[$guard_number] + $total ))
			fi
			echo "$date $hour $number"
		done < input/day4-input.file | sort
		echo ${tab_total_sleep[@]} | tee output/day4-output.file
}

part2() {
	declare -A tab_number
#	while read line || [ -n "$line" ] ;
#		do
#			IFS="," read -r  ident x y len width <<<$(echo "$line" | sed -re 's/(@|:|x)/,/g'| sed -re 's/(#| )//g')
#			for i in `seq 1 $len`;
#			do
#				for j in `seq 1 $width`;
#				do
#					position="$(($x+$i-1))"*"$(($y+$j-1))"
#					tab_number[$position]=tab_number[$position]$ident';'
#				done
#			done
#		done < input/day4-input.file
#		echo ${tab_number[$@]} | tee output/day4-output.file
}

case "$1" in
	part1)
		part1
		;;
	part2)
		part2
		;;
	*)
		part1
		part2
		;;
esac