#!/bin/sh

export _JAVA_AWT_WM_NONREPARENTING=1
export SBCL_HOME=/usr/lib/sbcl
export _QWT_TOOLKT=MToolkit

exec ~/.screenlayout/run.sh &

exec wmname compiz &

exec emacs-keys-everywhere &
exec picom -b --vsync --backend glx &
#exec xmodmap ~/.xmodmap &
exec xinput set-prop 10 "Coordinate Transformation Matrix" 1.2 0 0 0 1.2 0 0 0 1.8 &

exec xsetroot -cursor_name left_ptr &
exec xset s off &
exec xset b off &
exec xset -dpms &

exec feh --bg-fill --randomize ~/Wallpapers &

exec sleep 1s && dunst &

exec systemd start --user display.target &

/usr/local/bin/stumpwm
