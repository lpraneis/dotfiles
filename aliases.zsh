alias vi="nvim"
alias normps="$HOME/bin/normps.sh"
alias prog="git log -- ."
alias ghidra="/home/logan/apps/ghidra_9.0.4/ghidraRun"
alias publicip="dig +short myip.opendns.com @resolver1.opendns.com"
alias sage="/home/logan/apps/SageMath/sage"
alias pia="/opt/piavpn/bin/pia-client"
alias cat="bat"
alias gp="git push"
alias ls="ls --color=tty"

cs() { dir=$(find /home/logan/currTerm/ -maxdepth 3 -type d| fzf +m) && cd "$dir"}
py() { env=$(find /home/logan/python-virtual-environments -maxdepth 1 -type d | fzf +m) &&
    source "$env/bin/activate"}


