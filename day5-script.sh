#!/bin/sh

part1() {
while read line || [ -n "$line" ] ;
do
	a="$line"
	b=""
	while [ "$a" != "$b" ] ;
		do
		
		a_old="$a"
		a_new=`echo "$a" | sed  -re  "s/(aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|Gg|gG|Hh|hH|Ii|iI|Jj|jJ|kK|Kk|lL|Ll|mM|Mm|Nn|nN|Oo|oO|pP|Pp|qQ|Qq|Rr|rR|sS|Ss|Tt|tT|Uu|uU|Vv|vV|wW|Ww|Xx|xX|yY|Yy|zZ|Zz)//g"`
		a="$a_new"
		b="$a_old"
		done
	echo "$a"  | grep -o . | wc -l | tee output/day5-output.file
done < input/day5-input.file
}

part2() {
alphabet="abcdefghijklmnopqrstuvwxyz"
min=500000
for i in $(seq 0 $((${#alphabet} - 1)))
do
	upper=`echo "${alphabet:i:1}" | tr [a-z] [A-Z]`
	while read line || [ -n "$line" ] ;
	do
		a0="${line//$upper}"
		a="${a0//${alphabet:i:1}}"
		b=""
		while [ "$a" != "$b" ] ;
			do
			
			a_old="$a"
			a_new=`echo "$a" | sed  -re  "s/(aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|Gg|gG|Hh|hH|Ii|iI|Jj|jJ|kK|Kk|lL|Ll|mM|Mm|Nn|nN|Oo|oO|pP|Pp|qQ|Qq|Rr|rR|sS|Ss|Tt|tT|Uu|uU|Vv|vV|wW|Ww|Xx|xX|yY|Yy|zZ|Zz)//g"`
			a="$a_new"
			b="$a_old"
			done
		length=`echo "$a"  | grep -o . | wc -l`
		[ "$length" -lt "$min" ] && min="$length"
	done < input/day5-input.file 
done
echo "$min" | tee -a output/day5-output.file
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