#!/bin/bash

path=$1
dirpath=$(dirname "$path")
file="$(basename "$path")"
filename="${file%.*}"
fileext=${file##*.}

echo -e "path: $path\ndirpath: $dirpath\nentirefile: $file\nfilename: $filename\nfileext: $fileext"

case "$fileext" in

"txt" | "md" | "log" | "conf")
	nvim "$path"
	;;

"png" | "jpg" | "jpeg" | "gif" | "bmp" | "svg" | "webp")
	feh "$path"
	;;

"doc" | "docx" | "xlsx" | "ppt" | "pptx")
	libreoffice "$path"
	;;

"pdf")
	zathura "$path"
	;;

"mp3" | "mp4" | "wav")
	vlc "$path"
	;;
esac
