#!/usr/bin/env sh
# Compatibility entry point; installation no longer requires Zsh to be installed.
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P) || exit 1
exec bash "$script_dir/install.sh" "$@"
