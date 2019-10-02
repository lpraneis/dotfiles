# Testing
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
 
path+=('/usr/local/texlive/2018/bin/x86_64-linux')
path+=('/home/logan/.local/bin')
path+=('.')
path+=('/home/logan/go/bin/')
path+=('/home/logan/.npm-global/bin')
export PATH


#Disable auto window naming in tmux
DISABLE_AUTO_TITLE=true


# User configuration
DEFAULT_USER='logan'
prompt_context(){}
umask 026

# Allow Alt+. to have last command args in vicmd mode
bindkey "^[." insert-last-word


# USE POSIX time command
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S'
#autosuggestions configuration

# FUNCTIONS

function pdfextract()
{
 # this function uses 3 arguments:
    #     $1 is the first page of the range to extract
    #     $2 is the last page of the range to extract
    #     $3 is the input file
    #     output file will be named "inputfile_pXX-pYY.pdf"
    if [ $# -lt 3 ]; then
      echo "USAGE"
      echo "pdfextract first_page last_page input_file [output_file]"
    elif [ $# -eq 3 ]; then
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${3%.pdf}_p${1}-p${2}.pdf \
       ${3}
    else 
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER \
       -dFirstPage=${1} \
       -dLastPage=${2} \
       -sOutputFile=${4} \
       ${3}
    fi
     }

#source aliases
source ~/dotfiles/aliases.zsh

# Automatically add ssh keys
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval `ssh-agent -s`
  ssh-add
fi

# OPAM configuration
. /home/logan/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
alias config='/usr/bin/git --git-dir=/home/logan/.cfg/ --work-tree=/home/logan'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(starship init zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
