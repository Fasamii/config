#! /bin/bash
set -e

loglv=1;

log() {
	if [ "$loglv" -gt 0 ]; then
		case "$1" in
			info) echo -e "[\e[38;5;4mERR\e[0m]: $2" >&2
				;;
			err) echo -e "[\e[38;5;1mERR\e[0m]: $2" >&2
				;;
			scrm) echo -e '[\e[38;5;1m FOCUS \e[0m]: \e[38;5;5m'"$2"'\e[0m' >&2
				;;
			*) echo -e "[\e[38;5;5mOTHER\e[0m]: $2" >&2
				;;
		esac
	fi
}

active_id=$(hyprctl activewindow -j | jq -r '.monitor');
active_name=$(hyprctl monitors -j | jq -r '.['"$active_id"'].name');
log info 'Monitor-Id: \e[38;5;5m'"$active_id"'\e[0m, Monitor-Name: \e[38;5;5m'"$active_name"'\e[0m';
active_name=$(hyprctl monitors -j -i "$active_id");
log info 'Monitor-Id: \e[38;5;5m'"$active_id"'\e[0m, Monitor-Name: \e[38;5;5m'"$active_name"'\e[0m';

wlr-randr --output "$active_name"
