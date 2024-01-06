export PATH="/home/lizzy/.roswell/bin:/home/lizzy/.local/bin$PATH"

# asdf
[ -f /opt/asdf-vm/asdf.sh ] && . /opt/asdf-vm/asdf.sh

 # ghcup-env
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_QPA_PLATFORM=wayland
#export GDK_BACKEND=wayland
export MOZ_ENABLE_WAYLAND=1
