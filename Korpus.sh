#!/bin/sh
echo -ne '\033c\033]0;Korpus\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Korpus.x86_64" "$@"
