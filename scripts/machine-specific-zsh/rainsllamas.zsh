export PATH=$PATH:~/work/simple_scripts

# asdf
[ -f /opt/asdf-vm/asdf.sh ] && . /opt/asdf-vm/asdf.sh

# thefuck
eval $(thefuck --alias)

# Pyenv
if [ -d "$HOME/.pyenv" ] 
then
  export PYENV_ROOT="$HOME/.pyenv"
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
