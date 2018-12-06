#!/bin/sh

part1and2() {
	cat input/day4-input.file | sort > day4-tmp.tmp
	declare -A tab_total_sleep
	declare -A tab_total_sleep_by_minute
	dateSleep=""
	hourSleep=""
	minSleep=""
	guard_number=""
	guard="Guard"
	falls="falls"
	wakes="wakes"
	while read line || [ -n "$line" ] ; 
		do
			read -r date hourmin type number _ <<< "${line}"
			date="${date//'['}"
            hourmin="${hourmin//']'}"
			hour="${hourmin:0:2}"
			min="${hourmin:3:2}"
			min="${min#0}"
            if [ "$type" = "$guard" ];
				then guard_number="${number//'#'}"; number="in"; dateSleep="" ; hourSleep="" ; minSleep="" ;
			elif [ "$type" = "$falls" ];
				then dateSleep="$date"; hourSleep="$hour"; minSleep="$min";
			elif [ "$type" = "$wakes" ];
				then 
				if [ "$dateSleep" = "$date" ] && [ "$hourSleep" = "$hour" ];
					then total=$(( min - minSleep ));
						tab_total_sleep[$guard_number]=$(( tab_total_sleep[$guard_number] + total )); 
						for i in $(seq "$minSleep" "$(( min - 1 ))")
							do tab_total_sleep_by_minute[$guard_number"*"$i]=$(( tab_total_sleep_by_minute[$guard_number"*"$i] + 1 )) ; done;
				fi
			fi
		done < day4-tmp.tmp
	max_sleep=0
	sleepiest_guard=""
	max_min=0
	min_asleep=0
	max_max_minu=0
	max_minu_asleep=0
	for i in "${!tab_total_sleep[@]}"
	do	
		sleep="${tab_total_sleep[$i]}";
		[[ "$sleep" -gt "$max_sleep" ]] && max_sleep="$sleep" && sleepiest_guard="$i"
	done
	
	for i in "${!tab_total_sleep_by_minute[@]}"
	do
		[[ "$i" == $sleepiest_guard* ]] && [[ "${tab_total_sleep_by_minute[$i]}" -gt "$max_min" ]] && max_min="${tab_total_sleep_by_minute[$i]}" && min_asleep="$i";
		[[ "${tab_total_sleep_by_minute[$i]}" -gt "$max_max_minu" ]] && max_max_minu="${tab_total_sleep_by_minute[$i]}" && max_minu_asleep="$i"
	done
	echo "$(( min_asleep ))" | tee output/day4-output.file
	echo "$(( max_minu_asleep ))" | tee -a output/day4-output.file
	rm day4-tmp.tmp
}

case "$1" in
	*)
		part1and2
		;;
esac