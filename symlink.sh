#!/bin/sh
# create relative symlink to dir [$XDG_CONFIG_HOME]
ABSP="$(realpath "$0")" # get absolute full path of current script
BD="$(dirname "$ABSP")" # base directory path of current script
case "$HOME" in
    /home/*) ;; # if $HOME contains "/home/" -> regular user
    # fix for: root user $HOME=/root etc.
    # HACK: we assume that $BD is inside users home directory
    *) HOME="$(echo "$BD" | grep -o "/home/\w*")" ;;
esac
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"$HOME/.config"}"
[ ! -d "$XDG_CONFIG_HOME" ] && mkdir -p "$XDG_CONFIG_HOME" # fix: in case parent dirs does not exist
ln -rs "$BD" "$XDG_CONFIG_HOME" # create relative symlink to dir
