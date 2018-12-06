#!/bin/sh

part1() {
	double=0
	triple=0
	while read line || [ -n "$line" ];
		do
			
			doubleLetter=0
			tripleLetter=0
			doubleLetter=$(echo "$line" | grep -o . | sort | uniq -c | grep -cE "[\t]*2 ")
			tripleLetter=$(echo "$line" | grep -o . | sort | uniq -c | grep -cE "[\t]*3 ")
			[ "$doubleLetter" -gt 0 ] && double=$(( double + 1 ))
			[ "$tripleLetter" -gt 0 ] && triple=$(( triple + 1 ))
		done < input/day2-input.file
	checksum=$(( double * triple )) 
	echo "$checksum" | tee output/day2-output.file
}

part2() {
    mapfile -t input < "input/day2-input.file"
    for i in $(seq 0 $((${#input[@]} - 1)) )
		do
		for j in $(seq $(( i+1 )) $((${#input[@]})) )
			do
				countDiff=0
				for k in $(seq 0 $((${#input[$i]} - 1 )))
					do
					inputI="${input[$i]}"
					inputJ="${input[$j]}"
					inputIK="${inputI:k:1}"
					inputJK="${inputJ:k:1}"
					[ "$inputIK" != "$inputJK" ] && countDiff=$(( countDiff + 1 ))
					[ "$countDiff" -eq 2 ] && break
					done
				[ "$countDiff" -eq 1 ] && tr -dc "${input[$i]}" <<< "${input[$j]}"  | tee -a output/day2-output.file && exit 0
			done
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