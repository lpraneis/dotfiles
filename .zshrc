# starship
eval "$(starship init zsh)"
# history file config
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt INC_APPEND_HISTORY # append into history file
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS  ## Delete empty lines from history file
setopt HIST_NO_STORE  ## Do not add history and fc commands to the history

alias ls="ls --color=always"
alias l="ls --color=always -lhA"
alias ll="ls --color=always -lh"
alias vim="nvim"

autoload -Uz compinit && compinit



alias bigchrome="/usr/bin/google-chrome --force-device-scale-factor=1 --user-data-dir=/home/lpraneis/data/chrome"
. "$HOME/.cargo/env"

export PATH="$PATH:$HOME/bin"
