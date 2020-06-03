# All commands shared by both zsh and bash

# Set solarized colors for ls
eval $(dircolors -b ~/.shell/dircolors.256dark)

# Environment variables
export GREP_COLOR="1;33"
export EDITOR="/usr/bin/vim"
export GIT_EDITOR='/usr/bin/vim'

# Longer lines for pdflatex output
# export max_print_line=1000

# Aliases
alias ..='cd ..'
alias bashrc='vim ~/.bashrc'
alias bat='bat --theme TwoDark'
alias c='cd'
alias df='df --human-readable'
alias dmesg="sudo dmesg --human"
alias du='du --human-readable'
alias g='git'
alias gdb='gdb --quiet'
alias gg='git g'
alias gi='git'
alias gr='grep --dereference-recursive --line-number --ignore-case'
alias grep='grep --color=auto'
alias gt='git'
alias ip='ip -color'
alias la='ls --human-readable --almost-all'
alias less='less --long-prompt --RAW-CONTROL-CHARS'
alias lla='ls --color=auto --human-readable -l --all'
alias ls='ls --color=auto'
alias m='make'
alias ma='make'
alias mak='make'
alias sdr='sudo systemctl daemon-reload'
alias sje='sudo journalctl --pager-end'
alias sjf='sudo journalctl --follow --lines=100'
alias ssr='sudo systemctl restart'
alias sss='sudo systemctl status'
alias tm='tmux'
alias tree='tree -pugha'
alias v='vim'
alias vi='vim'
alias vimrc='vim ~/.vimrc'
alias xo='xdg-open'
alias zshrc='vim ~/.zshrc'

# "Function" aliases that can not be expressed as regular aliases
diff() {
    if [[ -z "$(command -v colordiff)" ]]; then
        diff "${@}"
    else
        colordiff "${@}"
    fi
}
function l() {
    if [[ -z "$(command -v exa)" ]]; then
        ls --color=auto "${@}"
    else
        exa "${@}"
    fi
}
function ll() {
    if [[ -z "$(command -v exa)" ]]; then
        ls --color=auto --human-readable -l "${@}"
    else
        exa --long "${@}"
    fi
}

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
    if [[ ${#} -ne 1 ]]; then
        printf "Usage : %s <filename>\n" "${0}"
        return
    fi
    cp -- "${1}"{,.bak}
}

# Restore a backup file (.bak)
restore() {
    if [[ ${#} -ne 1 ]]; then
        printf "Usage : %s <filename>\n" "${0}"
        return
    fi
    cp -- "${1}"{.bak,}
}

sshl() {
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${@}"
}

shac() {
    sha256sum -c --ignore-missing "${@}"
}

run_iso() {
    local -r iso="${1}"
    qemu-system-x86_64 -accel kvm -m 4096M -smp cores=2 \
        -net nic,model=virtio -net user,hostfwd=tcp::2222-:22 \
        -boot d -cdrom "${iso}"
}

run_isoc() {
    local -r iso="${1}"
    echo "[+] Please append 'console=ttyS0' to GRUB boot entry!"
    read
    qemu-system-x86_64 -accel kvm -m 4096M -smp cores=2 \
        -net nic,model=virtio -net user,hostfwd=tcp::2222-:22 \
        -boot d -cdrom "${iso}" -nographic -serial mon:stdio
}

run_qcow2() {
    local -r img="${1}"
    qemu-system-x86_64 -accel kvm -m 4096M -smp cores=2 \
        -net nic,model=virtio -net user,hostfwd=tcp::2222-:22 \
        -fw_cfg name=opt/com.coreos/config,file=metadata/key.ign \
        -drive file="${img}"
        # -nographic -serial mon:stdio -append 'console=ttyS0'
}

+podman_run_cwd() {
	local cmd=""
	if [[ ${#} -eq 1 ]]; then
		cmd="bash"
	fi
	podman run --rm --tty --interactive \
		--security-opt label=disable \
		--volume "${PWD}:/mnt" \
		--tmpfs '/tmp:exec' \
		--tmpfs '/var/tmp:exec' \
		--workdir '/mnt' \
		"${@}" \
		bash
}
