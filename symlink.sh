#!/bin/sh
# create relative symlink to dir [$XDG_CONFIG_HOME]
ABSP="$(realpath "$0")" # get absolute full path of current script
BD="$(dirname "$ABSP")" # base directory path of current script
home_path_hack="$(echo "$BD" | grep -o "/home/\w*")" # we assume that $BD is inside users home directory
HOME="${HOME-"$home_path_hack"}" # if $HOME is empty use $home_path_hack
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
ln -rs "$BD" "$XDG_CONFIG_HOME" # create relative symlink to dir
