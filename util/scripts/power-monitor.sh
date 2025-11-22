#!/usr/bin/bash

# Prevent duplicates
if pidof -x "$(basename "$0")" -o $$ >/dev/null; then
	echo "Already Running";
	exit 0;
fi;

last_pct=100;

while read -r line; do
	if [[ $line == *percentage* ]]; then
		pct=$(awk '{print int($2)}' <<< "$line");
		if (( pct < last_pct )); then
			if (( pct < 20 )); then
				if (( pct > 10 )); then
					notify-send "Low battery ( ${pct}% )" -u normal -t 1400;
				else
					notify-send "Low battery ( ${pct}% )" -u critical -t 1800;
				fi;
			fi;
		fi;
		last_pct=$pct;
	fi;
done < <(upower --monitor-detail) &
