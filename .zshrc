# Testing
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
 
path+=('/usr/local/texlive/2018/bin/x86_64-linux')
path+=('/home/logan/.local/bin')
path+=('/home/logan/go/bin/')
path+=('/home/logan/.npm-global/bin')
export PATH

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory


#Disable auto window naming in tmux
DISABLE_AUTO_TITLE=true


# User configuration
DEFAULT_USER='logan'
# prompt_context(){}
umask 026

# Allow Alt+. to have last command args in vicmd mode
set -o vi
bindkey "^[." insert-last-word
bindkey "^F" autosuggest-accept
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history


# USE POSIX time command
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'

# Pyenv
# PYENV=/home/logan/.pyenv
export PATH="/home/logan/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"
# source $PYENV/completions/pyenv.zsh


# Zsh Autocompletions
fpath=(/home/logan/apps/zsh-completions/src $fpath)

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history match_prev_cmd completion)

#source aliases
source ~/dotfiles/aliases.zsh

# source functions
source ~/dotfiles/functions.zsh

# OPAM configuration
. /home/logan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
alias config='/usr/bin/git --git-dir=/home/logan/.cfg/ --work-tree=/home/logan'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
