# Brew, gnuutils
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=$PATH:/Users/lizzy/.spicetify
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export PATH="/Users/lizzy/.bun/bin/:$PATH"

# asdf
. $(brew --prefix asdf)/libexec/asdf.sh

export PATH=$PATH:/Users/lizzy/.spicetify
