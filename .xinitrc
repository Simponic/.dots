#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1
export SBCL_HOME=/usr/lib/sbcl
export _QWT_TOOLKT=MToolkit

exec wmname compiz &

exec emacs-keys-everywhere &
exec picom -b --vsync --backend glx &
exec xmodmap ~/.xmodmap &

exec xsetroot -cursor_name left_ptr &
exec xset s off &
exec xset b off &
exec xset -dpms &


exec ~/.screenlayout/run.sh &

exec feh --bg-fill --randomize ~/Wallpapers/*

exec sleep 1s && dunst &

/usr/local/bin/stumpwm
