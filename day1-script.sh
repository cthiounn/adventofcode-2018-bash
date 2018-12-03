#!/bin/sh

part1() {
	let frequency=0
	while read line || [ -n "$line" ];
		do
			let frequency=$frequency$line 
		done < input/day1-input.file 
	echo "$frequency" | tee output/day1-output.file
}

part2() {
	let frequency=0
	declare -A tab_number
	while [ true ]
	do
		while read line || [ -n "$line" ] ;
			do
				let frequency=$frequency$line
				if [[ $((tab_number[$frequency])) -eq 1 ]]; then
					echo "$frequency" | tee -a output/day1-output.file;
					exit;
				fi
				tab_number[$frequency]=1
			done < input/day1-input.file 
	done
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