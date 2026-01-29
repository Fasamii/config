#! /usr/bin/env bash
set -euo pipefail

notify-send "SHUTDOWN";
sleep 1;
loginctl poweroff;
