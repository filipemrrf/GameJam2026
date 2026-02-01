#!/bin/sh
printf '\033c\033]0;%s\a' GameJam2026
base_path="$(dirname "$(realpath "$0")")"
"$base_path/GameJam2026.x86_64" "$@"
