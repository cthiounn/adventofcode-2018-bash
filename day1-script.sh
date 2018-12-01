#!/bin/sh

part1() {
	let frequency=0
	while read line || [ -n "$line" ];
		do
			let frequency=$frequency$line 
		done < input/day1-input.file 
	echo "$frequency"
}

part2() {
	let frequency=0
	if [ -f day1-buffer.tmp ]; then
		rm day1-buffer.tmp
	fi
	touch day1-buffer.tmp 
	while [ true ]
	do
		while read line || [ -n "$line" ] ;
			do
				let frequency=$frequency$line
				grep ^$frequency$ day1-buffer.tmp > /dev/null
				if [[ $? -eq 0 ]]; then
					echo "$frequency";
					rm day1-buffer.tmp
					exit;
				fi
				echo "$frequency" >> day1-buffer.tmp
			done < input/day1-input.file 
	done
	echo "$frequency"
	rm day1-buffer.tmp
}

case "$1" in
	part1)
		part1
		;;
	part2)
		part2
		;;
	*)
		echo "Usage : $0 {part1|part2}"
		;;
esac