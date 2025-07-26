#!/usr/bin/env bash
set -euo pipefail

# --------- CONFIG ---------
lf_bin="lf"
selector_mode="multi"
output_file=""

# --------- ARG PARSING ---------
while [[ $# -gt 0 ]]; do
    case "$1" in
        single) selector_mode="single"; shift ;;
        multi)  selector_mode="multi";  shift ;;
        *)      output_file="$1";       shift ;;
    esac
done
: "${selector_mode:=multi}"

# If no output file provided, make a temp one and schedule its removal
if [[ -z "$output_file" ]]; then
    output_file="$(mktemp)"
    trap 'rm -f "$output_file"' EXIT
fi

# --------- TEMP RCFILE FOR SINGLE MODE ---------
tmp_rcfile=""
if [[ "$selector_mode" == "single" ]]; then
    tmp_rcfile="$(mktemp)"
    trap 'rm -f "$tmp_rcfile"' EXIT

    cat > "$tmp_rcfile" <<EOF
map <enter> &echo \$f > "$output_file"; quit
EOF
    LF_FLAGS="-config=$tmp_rcfile"
else
    LF_FLAGS=""
fi

# --------- LAUNCH LF ---------
LF_SELECTION_PATH="$output_file" LF_PICK_MODE=1 LF_ICONS=1 $lf_bin $LF_FLAGS

# --------- OUTPUT RESULTS ---------
if [[ -t 1 ]]; then
    cat "$output_file"
fi
# #!/usr/bin/env bash
# set -euo pipefail
#
# # --------- CONFIG ---------
# lf_bin="lf"
# selector_mode="multi"
# output_file=""
#
# # --------- ARG PARSING ---------
# while [[ $# -gt 0 ]]; do
#     case "$1" in
#         single) selector_mode="single"; shift ;;
#         multi)  selector_mode="multi";  shift ;;
#         *)      output_file="$1";        shift ;;
#     esac
# done
# : "${selector_mode:=multi}"
#
# # If no output file provided, make a temp one and schedule its removal
# if [[ -z "$output_file" ]]; then
#     output_file="$(mktemp)"
#     trap 'rm -f "$output_file"' EXIT
# fi
#
# # --------- LAUNCH LF ---------
# if [[ "$selector_mode" == "single" ]]; then
#     # -single: quit after one file chosen
#     "$lf_bin" --single -selection-path "$output_file"
# else
#     # multi-select: toggle with SPACE, confirm with ENTER
#     "$lf_bin" --selection-path "$output_file"
# fi
#
# # --------- OUTPUT RESULTS ---------
# # lf has exited; now the selections live in $output_file.
# # If we're in an interactive terminal, print them:
# if [[ -t 1 ]]; then
#     cat "$output_file"
# fi
