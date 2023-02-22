export PATH=$PATH:$HOME/scripts:/usr/local/i386elfgcc/bin/:$HOME/.local/bin:/usr/local/opt/binutils/bin:/usr/local/opt/gnu-tar/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:$HOME/.elixir-ls/release:$HOME/.rowswell/bin
export TERM=xterm-256color
export GPG_TTY=$(tty)

# Print a random ascii arts from ~/ascii-arts
if [ -d "$HOME/ascii-arts" ] 
then
	echo
	echo "======="
	logo="$(find $HOME/ascii-arts/* | shuf -n1)"
	printf "$(echo $logo | grep -o "[0-9a-zA-Z+\-\.]*$")\n"
	echo "======="
	printf "$(cat $logo)\n\n"
fi

. /opt/asdf-vm/asdf.sh

# Alt+b stops at forwardslashes
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    zle backward-kill-word
    zle -f kill
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# ZSH enhancements
source ~/zsh-stuff/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/zsh-stuff/spaceship-prompt/spaceship.zsh

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# thefuck
eval $(thefuck --alias)

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

 # ghcup-env
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Aliases
alias ..="cd .."
alias gc="git checkout"
alias gcm="git commit -S -m"
alias gb="git branch"
alias gbm="git branch -m"
alias ga="git add"
alias gaa="git add ."
alias gpl="git pull"
alias gps="git push"
alias gm="git merge"
alias gss="git status"
alias gsh="git stash"
alias gl="git log"

alias sbcl="rlwrap sbcl"
