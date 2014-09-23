# All commands shared by both zsh and bash

# Source Git functions
#source /usr/share/git/completion/git-prompt.sh
#export GIT_PS1_SHOWDIRTYSTATE=true
#export GIT_PS1_SHOWUNTRACKEDFILES=true
#export GIT_PS1_SHOWSTASHSTATE=true

# Set solarized colors for ls
eval $(dircolors -b ~/.shell/dircolors.256dark)

# Colors related aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='colordiff'

# 'ls' related aliases
alias l='ls'
alias la='ls --almost-all --human-readable'
alias ll='ls --human-readable -l'
alias lla='ls --almost-all --human-readable -l'
#alias ldir='ls -l| egrep "^d"'

# Misc
alias bashrc='vim ~/.bashrc'
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'

# systemd
alias sdr='sudo systemctl daemon-reload'
alias ssr='sudo systemctl restart'

# Overload and others
alias ..='cd ..'
alias c='cd'
alias df='df --human-readable'
alias dmesg="dmesg --human"
alias du='du --human-readable'
alias g='git'
alias gt='git'
alias gdb='gdb --quiet'
alias gg='git g'
alias gr='grep -Rn'
alias less='less -m'
alias mutt='(cd && mutt)'
alias pyserv='python -m http.server'
alias syncmail='mbsync -a ; notmuch new'
alias v='vim'
alias vi='vim'
alias xo='xdg-open'

# Environment variables
export GREP_COLOR="1;33"
export EDITOR="/usr/bin/vim"
export GIT_EDITOR='/usr/bin/vim'

# Firefox hack, should be checked
export MOZ_DISABLE_PANGO=1

# Longer lines for pdflatex output
export max_print_line=1000

export FULLNAME=""
export EMAIL=""

# Add local ruby path
export PATH="${PATH}:${HOME}/.gem/ruby/2.0.0/bin"

# Add path for Go
export GOPATH="${HOME}/projects/gocode/"

# Use gpg-agent if available
if [ -f "${HOME}/.gpg-agent-info" ]; then
	source "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
	export SSH_AUTH_SOCK
fi

# Custom __git_ps1 function
__git_ps1 () {
	local b="$(git symbolic-ref HEAD 2>/dev/null)";
	if [ -n "${b}" ]; then
		printf "%s" "${b##refs/heads/}";
	fi
}

# Colored man
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "${@}"
}

# Create a backup file (.bak)
backup() {
    if [ ${#} -ne 1 ]; then
        print "Usage : %s <filename>" "${0}"
        return
    fi
    cp -- ${1}{,.bak}
}

# Restore a backup file (.bak)
restore() {
    if [ ${#} -ne 1 ]; then
        print "Usage : %s <filename>" "${0}"
        return
    fi
    cp -- ${1}{.bak,}
}

#set_proxy() {
#	export http_proxy=http://0.0.0.0:5187/
#	export https_proxy=$http_proxy
#	export ftp_proxy=$http_proxy
#	export rsync_proxy=$http_proxy
#	export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
#}
