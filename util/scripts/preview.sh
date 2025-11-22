#!/usr/bin/env bash
set -euo pipefail

file="$1"
w=${2:-80}
h=${3:-20}
x=${4:-0}
y=${5:-0}

mtype=$(file --mime-type -Lb "$file")

cleanup() {
  command -v ueberzugpp >/dev/null 2>&1 && ueberzugpp layer --parser bash <<EOF 2>/dev/null
[{"action":"remove","identifier":"preview"}]
EOF
}
trap cleanup EXIT

case "$mtype" in
  text/*)
    bat --style=plain --color=always "$file" 2>/dev/null || cat "$file"
    ;;

  application/pdf)
    pdftotext "$file" - 2>/dev/null | head -n 100 || echo "[!] Failed to preview PDF."
    ;;

  image/*)
    if command -v chafa &>/dev/null; then
      chafa --format=symbols "$file"
    else
      echo "[!] chafa not installed."
    fi
    ;;

  video/*)
    ffprobe -v error \
      -show_entries format=duration,size:stream=codec_name,codec_type,width,height \
      -of default=noprint_wrappers=1 "$file" 2>/dev/null || echo "[!] Cannot inspect video file."
    ;;

  application/zip|application/x-tar|application/gzip|application/x-bzip2|application/x-xz)
    tar -tvf "$file" 2>/dev/null || unzip -l "$file" 2>/dev/null || echo "[!] Cannot preview archive."
    ;;

  application/x-7z-compressed)
    7z l "$file" 2>/dev/null || echo "[!] Cannot preview 7z file."
    ;;

  application/x-rar)
    unrar l "$file" 2>/dev/null || echo "[!] Cannot preview rar file."
    ;;

  *)
    echo "MIME type: $mtype"
    ;;
esac
