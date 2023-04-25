export PATH="/home/lizzy/.roswell/bin:$PATH"

# asdf
[ -f /opt/asdf-vm/asdf.sh ] && . /opt/asdf-vm/asdf.sh

# thefuck
eval $(thefuck --alias)

 # ghcup-env
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
