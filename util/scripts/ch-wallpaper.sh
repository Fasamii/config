#!/bin/bash

set -e
notify() {
	hyprctl notify 3 2000 "rgb(ff0020)" "fontsize:14 ch-wallpaper failed" >> /dev/null;
	exit 1;
}

WALLPAPER_PATH=$HOME/.config/util/wallpapers
WALLPAPER_NAME=$(ls $WALLPAPER_PATH | shuf -n 1);

hyprctl notify -1 2000 "rgb(ffffff)" "fontsize:14 $WALLPAPER_NAME" >> /dev/null;
swww img "$WALLPAPER_PATH"/"$WALLPAPER_NAME" \
	--transition-type=simple \
	--transition-step=10 \
	--transition-fps=60 || notify
