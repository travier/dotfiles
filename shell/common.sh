# All commands shared by both zsh and bash

# Set solarized colors for ls
eval $(dircolors -b ~/.shell/dircolors.256dark)

# Colors related aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='colordiff'

# 'ls' related aliases
alias l='ls'
alias la='ls --human-readable --almost-all'
alias ll='ls --human-readable -l'
alias lla='ls --human-readable -l --all'
#alias ldir='ls -l| egrep "^d"'

# Misc
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'

# systemd
alias sdr='sudo systemctl daemon-reload'
alias ssr='sudo systemctl restart'
alias sss='sudo systemctl status'
alias sje='sudo journalctl -e'
alias sjf='sudo journalctl -fn 100'

# Overload and others
alias ..='cd ..'
alias c='cd'
alias df='df --human-readable'
alias dmesg="dmesg --human"
alias du='du --human-readable'
alias g='git'
alias gi='git'
alias gt='git'
alias gg='git g'
alias gdb='gdb --quiet'
alias gr='grep --dereference-recursive --line-number --ignore-case'
alias less='less --long-prompt --RAW-CONTROL-CHARS'
alias m='make'
alias ma='make'
alias mak='make'
alias mutt='(cd && mutt)'
alias pyserv='python -m http.server'
alias syncmail='mbsync --all ; notmuch new'
alias tree='tree -pugh'
alias v='vim'
alias vi='vim'
alias xo='xdg-open'


# Environment variables
export GREP_COLOR="1;33"
export EDITOR="/usr/bin/vim"
export GIT_EDITOR='/usr/bin/vim'

# Longer lines for pdflatex output
export max_print_line=1000


# Various functions

# Colored man
man() {
	env \
		LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
		LESS_TERMCAP_md="$(printf "\e[1;31m")" \
		LESS_TERMCAP_me="$(printf "\e[0m")" \
		LESS_TERMCAP_se="$(printf "\e[0m")" \
		LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
		LESS_TERMCAP_ue="$(printf "\e[0m")" \
		LESS_TERMCAP_us="$(printf "\e[1;32m")" \
		man "${@}"
}

# Create a backup file (.bak)
backup() {
    if [ ${#} -ne 1 ]; then
        printf "Usage : %s <filename>\n" "${0}"
        return
    fi
    cp -- "${1}"{,.bak}
}

# Restore a backup file (.bak)
restore() {
    if [ ${#} -ne 1 ]; then
        printf "Usage : %s <filename>\n" "${0}"
        return
    fi
    cp -- "${1}"{.bak,}
}
