# All commands shared by both zsh and bash

# Set solarized colors for ls
eval "$(dircolors -b ~/.shell/dircolors.256dark)"

# Environment variables
export GREP_COLOR="mt=1;33"
export EDITOR="vim"

# Use podman for openshift/release
export CONTAINER_ENGINE=podman

# Longer lines for pdflatex output
# export max_print_line=1000

# Aliases
alias ..='cd ..'
alias bat='bat --theme TwoDark'
alias c='cd'
alias co='codium'
alias cog='codium --goto'
alias df='df --human-readable'
alias dmesg="sudo dmesg --human"
alias du='du --human-readable'
alias g='git'
alias gi='git'
alias gt='git'
alias gg='git g'
alias gdb='gdb --quiet'
alias gr='grep --dereference-recursive --line-number --ignore-case'
alias grep='grep --color=auto'
alias ip='ip -color'
alias la='ls --human-readable --almost-all'
alias less='less --long-prompt --RAW-CONTROL-CHARS'
alias lla='ls --color=auto --human-readable -l --all'
alias ls='ls --color=auto --human-readable'
alias m='make'
alias sdr='sudo systemctl daemon-reload'
alias sje='sudo journalctl --pager-end'
alias sjf='sudo journalctl --follow --lines=100'
alias ssr='sudo systemctl restart'
alias sss='sudo systemctl status'
alias tm='tmux'
alias tree='tree -pugh'
alias treea='tree -pugha'
alias vi='vim'
alias xo='xdg-open'

# Flatpak aliases
alias inkscape='flatpak run org.inkscape.Inkscape'
alias okular='flatpak run org.kde.okular'
alias vlc='flatpak run org.videolan.VLC'

# "Function" aliases that can not be expressed as regular aliases
function l() {
    if [[ -z "$(command -v exa)" ]]; then
        ls --color=auto --human-readable "${@}"
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

# Git clone & cd into the resulting directory, optionnaly adding a remote
# Can not be a git alias as it changes the current directory
gcd() {
    if [[ ${#} -lt 1 ]] || [[ ${#} -gt 2 ]]; then
        printf "Usage : %s <origin-url> [<fork-url>]\n" "${0}"
        return
    fi
    local -r dir="$(basename "${1}" .git)"
    if [[ -d "${dir}" ]]; then
        printf "%s already exists. Going there...\n" "${dir}"
        cd "${dir}"
    else
        git clone "${1}" "${dir}" && cd "$(basename "$_" .git)"
    fi
    if [[ ${#} -eq 2 ]]; then
        git remote add travier "${2}" && git fetch --all
    fi
}

sshl() {
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${@}"
}

shac() {
    sha256sum -c --ignore-missing "${@}"
}

find_whitespace() {
    find . -type f -exec grep -El " +$" {} \;
}

# Flatpak
fpb() {
    manifest=""
    if [[ -f "$(basename "$(pwd)").yml" ]]; then
        manifest="$(basename "$(pwd)").yml"
    elif [[ -f "$(basename "$(pwd)").yaml" ]]; then
        manifest="$(basename "$(pwd)").yaml"
    elif [[ -f "$(basename "$(pwd)").json" ]]; then
        manifest="$(basename "$(pwd)").json"
    else
        echo "Manifest not found"
        return 1
    fi
    args=""
    if [[ -f "/run/.toolboxenv" ]]; then
        args="--disable-rofiles-fuse"
    fi
    flatpak-builder --ccache --repo=repo --jobs="$(nproc)" --subject="wip" --force-clean ${args} app "${manifest}"
}
fpr() {
    manifest=""
    if [[ -f "$(basename "$(pwd)").yml" ]]; then
        manifest="$(basename "$(pwd)").yml"
    elif [[ -f "$(basename "$(pwd)").yaml" ]]; then
        manifest="$(basename "$(pwd)").yaml"
    elif [[ -f "$(basename "$(pwd)").json" ]]; then
        manifest="$(basename "$(pwd)").json"
    else
        echo "Manifest not found"
        return 1
    fi
    if [[ "${#}" -gt 0 ]]; then
        flatpak-builder --run app "${manifest}" "${@}"
    else
        flatpak-builder --run app "${manifest}" "$(basename "$(pwd)")"
    fi
}
fpi() {
    manifest=""
    if [[ -f "$(basename "$(pwd)").yml" ]]; then
        manifest="$(basename "$(pwd)").yml"
    elif [[ -f "$(basename "$(pwd)").yaml" ]]; then
        manifest="$(basename "$(pwd)").yaml"
    elif [[ -f "$(basename "$(pwd)").json" ]]; then
        manifest="$(basename "$(pwd)").json"
    else
        echo "Manifest not found"
        return 1
    fi
    flatpak-builder --user --install --force-clean app/ "${manifest}"
}

fedc() {
    manifest=""
    if [[ -f "$(basename "$(pwd)").yml" ]]; then
        manifest="$(basename "$(pwd)").yml"
    elif [[ -f "$(basename "$(pwd)").yaml" ]]; then
        manifest="$(basename "$(pwd)").yaml"
    elif [[ -f "$(basename "$(pwd)").json" ]]; then
        manifest="$(basename "$(pwd)").json"
    elif [[ ${#} -eq 1 ]]; then
        manifest="${1}"
    else
        echo "Manifest not found"
        return 1
    fi
    podman run --rm --privileged -v "${PWD}":/srv:rw -w /srv -it ghcr.io/flathub/flatpak-external-data-checker --update --edit-only "${manifest}"
}

# CoreOS assembler
cosa() {
   env | grep COREOS_ASSEMBLER
   local -r COREOS_ASSEMBLER_CONTAINER_LATEST="quay.io/coreos-assembler/coreos-assembler:latest"
   if [[ -z ${COREOS_ASSEMBLER_CONTAINER} ]] && $(podman image exists ${COREOS_ASSEMBLER_CONTAINER_LATEST}); then
       local -r cosa_build_date_str="$(podman inspect -f "{{.Created}}" ${COREOS_ASSEMBLER_CONTAINER_LATEST} | awk '{print $1}')"
       local -r cosa_build_date="$(date -d ${cosa_build_date_str} +%s)"
       if [[ $(date +%s) -ge $((cosa_build_date + 60*60*24*7)) ]] ; then
         echo -e "\e[0;33m----" >&2
         echo "The COSA container image is more that a week old and likely outdated." >&2
         echo "You should pull the latest version with:" >&2
         echo "podman pull ${COREOS_ASSEMBLER_CONTAINER_LATEST}" >&2
         echo -e "----\e[0m" >&2
       fi
   fi
   set -x
   podman run --rm -ti --security-opt label=disable --privileged                                         \
              --uidmap=1000:0:1 --uidmap=0:1:1000 --uidmap 1001:1001:64536                               \
              -v ${PWD}:/srv/ --device /dev/kvm --device /dev/fuse                                       \
              --tmpfs /tmp -v /var/tmp:/var/tmp                                                          \
              ${COREOS_ASSEMBLER_CONFIG_GIT:+--volume=$COREOS_ASSEMBLER_CONFIG_GIT:/srv/src/config/:ro}  \
              ${COREOS_ASSEMBLER_GIT:+--volume=$COREOS_ASSEMBLER_GIT/src/:/usr/lib/coreos-assembler/:ro} \
              ${COREOS_ASSEMBLER_ADD_CERTS:+--volume=/etc/pki/ca-trust:/etc/pki/ca-trust:ro}             \
              ${COREOS_ASSEMBLER_CONTAINER_RUNTIME_ARGS}                                                 \
              ${COREOS_ASSEMBLER_CONTAINER:-$COREOS_ASSEMBLER_CONTAINER_LATEST} "$@"
   rc=$?; set +x; return $rc
}
# Use certs from host
export COREOS_ASSEMBLER_ADD_CERTS='y'

urldecode() {
	python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))" "${@}"
}

urlencode() {
	python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.argv[1]))" "${@}"
}

# Specific toolbx aliases
tb() {
	toolbox enter toolbox
}
kdedev() {
	toolbox enter toolbox-kdedev "${@}"
}

# Get an interactive root shell or run a command as root on the host
sudohost() {
    if [[ ${#} -eq 0 ]]; then
        cmd="$(printf "exec \"%s\" --login" "${SHELL}")"
        ssh host.local "${cmd}"
    else
        cmd="$(printf "cd \"%s\"; exec %s" "${PWD}" "$*")"
        ssh host.local "${cmd}"
    fi
}

# PATH setup
__path_pre() {
    if [[ -d "${1}" ]] && [[ ":${PATH}:" != *":${1}:"* ]]; then
        PATH="${1}${PATH:+":${PATH}"}"
    fi
}
__path_post() {
    if [[ -d "${1}" ]] && [[ ":${PATH}:" != *":${1}:"* ]]; then
        PATH="${PATH:+"${PATH}:"}${1}"
    fi
}

# Make sure that Rust and Cargo from rustup are used first
__path_pre  "${HOME}/.cargo/bin"
# Make sure that local binaries are used first
__path_pre  "${HOME}/.local/bin"
# Add Go binaries to PATH
__path_post "${HOME}/go/bin"
# Add kdesrc-build to PATH
__path_post "${HOME}/projects/kde/src/kdesrc-build"

unset -f __path_pre
unset -f __path_post
