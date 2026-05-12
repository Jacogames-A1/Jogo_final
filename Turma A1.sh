#!/bin/sh
printf '\033c\033]0;%s\a' Turma A1
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Turma A1.x86_64" "$@"
