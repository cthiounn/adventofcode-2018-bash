#!/bin/sh

part1() {
	let inches_claim_conflict=0
	declare -A tab_number
	while read line || [ -n "$line" ] ;
		do 
			IFS="," read -r  ident x y len width <<<"$(echo "$line" | sed -re 's/(@|:|x)/,/g'| sed -re 's/(#| )//g')"
			for i in $(seq 1 "$len")
			do
				for j in $(seq 1 "$width")
				do
					position="$(( x + i - 1 ))"*"$(( y + j - 1 ))"
					[ $((tab_number[$position])) == 1 ] && inches_claim_conflict=$(( inches_claim_conflict + 1 ))
					tab_number[$position]=$(( tab_number[$position] + 1 ))
				done
			done
		done < input/day3-input.file
		echo "$inches_claim_conflict" | tee output/day3-output.file
}

part2() {

	declare -A tab_number
		while read line || [ -n "$line" ] ;
		do 
			IFS="," read -r  ident x y len width <<<"$(echo "$line" | sed -re 's/(@|:|x)/,/g'| sed -re 's/(#| )//g')"
			for i in $(seq 1 "$len")
			do
				for j in $(seq 1 "$width")
				do
					position="$(( x + i - 1 ))"*"$(( y + j - 1 ))"
					tab_number[$position]=$(( tab_number[$position] + 1 ))
				done
			done
		done < input/day3-input.file
	
	
	while read line || [ -n "$line" ] ;
		do
			conflict=0
			IFS="," read -r  ident x y len width <<<"$(echo "$line" | sed -re 's/(@|:|x)/,/g'| sed -re 's/(#| )//g')"
			for i in $(seq 1 "$len")
			do
				for j in $(seq 1 "$width")
				do
					position="$(( x + i - 1 ))"*"$(( y + j - 1 ))"
					[ $((tab_number[$position])) -gt 1 ] && conflict=1 && break
				done
			done
			[ "$conflict" -eq 0 ]  && echo "$ident" | tee -a output/day3-output.file && exit 0
		done < input/day3-input.file
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