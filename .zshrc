export TERM=xterm-256color
export GPG_TTY=$(tty)
export PATH=$PATH:$HOME/scripts:$HOME/.local/bin:$HOME/.rowswell/bin

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
alias fuckuctl="journalctl --user -fu"
alias fuckctl="journalctl -fu"

alias sbcl="rlwrap sbcl"
alias spt="spt --tick-rate 12"

# Machine specific config
[ -f ~/scripts/machine-specific-zsh/$(hostname).zsh ] && source ~/scripts/machine-specific-zsh/$(hostname).zsh
