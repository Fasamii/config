#!/usr/bin/env bash

STATE_FILE="/tmp/hyprland_layout_state"

# Helper to get current Hyprland value
get_val() {
    hyprctl getoption "$1" -j | jq -r '.custom // .int // .bool'
}

if [[ -f "$STATE_FILE" ]]; then
    # Restore state
    read -r GAPS_IN < <(jq -r '.gaps_in' "$STATE_FILE")
    read -r GAPS_OUT < <(jq -r '.gaps_out' "$STATE_FILE")
    read -r BORDER < <(jq -r '.border_size' "$STATE_FILE")
    read -r ROUNDING < <(jq -r '.rounding' "$STATE_FILE")
    read -r SHADOW < <(jq -r '.drop_shadow' "$STATE_FILE")

    hyprctl keyword general:gaps_in "$GAPS_IN"
    hyprctl keyword general:gaps_out "$GAPS_OUT"
    hyprctl keyword general:border_size "$BORDER"
    hyprctl keyword decoration:rounding "$ROUNDING"
    hyprctl keyword decoration:drop_shadow "$SHADOW"

    rm "$STATE_FILE"
else
    # Save current state
    GAPS_IN=$(get_val "general:gaps_in")
    GAPS_OUT=$(get_val "general:gaps_out")
    BORDER=$(get_val "general:border_size")
    ROUNDING=$(get_val "decoration:rounding")
    SHADOW=$(hyprctl getoption decoration:drop_shadow -j | jq -r '.bool')

    jq -n \
       --arg gaps_in "$GAPS_IN" \
       --arg gaps_out "$GAPS_OUT" \
       --arg border_size "$BORDER" \
       --arg rounding "$ROUNDING" \
       --arg drop_shadow "$SHADOW" \
       '{gaps_in: $gaps_in, gaps_out: $gaps_out, border_size: $border_size, rounding: $rounding, drop_shadow: $drop_shadow}' > "$STATE_FILE"

    # Apply "clean layout"
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:border_size 0
    hyprctl keyword decoration:rounding 0
    hyprctl keyword decoration:drop_shadow false
fi
