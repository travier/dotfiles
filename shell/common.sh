# All commands shared by both zsh and bash

# Set solarized colors for ls
eval $(dircolors -b ~/.shell/dircolors.256dark)

# Environment variables
export GREP_COLOR="1;33"
export EDITOR="/usr/bin/vim"
export GIT_EDITOR='/usr/bin/vim'

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
alias ark='flatpak run org.kde.ark'
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

sshl() {
    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "${@}"
}

shac() {
    sha256sum -c --ignore-missing "${@}"
}

find_whitespace() {
    find . -type f -exec egrep -l " +$" {} \;
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

# Flatpak
fpb() {
	manifest=""
	if [[ -f "$(basename $(pwd)).yml" ]]; then
		manifest="$(basename $(pwd)).yml"
	elif [[ -f "$(basename $(pwd)).yaml" ]]; then
		manifest="$(basename $(pwd)).yaml"
	elif [[ -f "$(basename $(pwd)).json" ]]; then
		manifest="$(basename $(pwd)).json"
	fi
	flatpak-builder --ccache --repo=repo --jobs=12 --subject="wip" --force-clean app "${manifest}"
}
fpr() {
	manifest=""
	if [[ -f "$(basename $(pwd)).yml" ]]; then
		manifest="$(basename $(pwd)).yml"
	elif [[ -f "$(basename $(pwd)).yaml" ]]; then
		manifest="$(basename $(pwd)).yaml"
	elif [[ -f "$(basename $(pwd)).json" ]]; then
		manifest="$(basename $(pwd)).json"
	fi
	if [[ "${#}" -gt 0 ]]; then
		flatpak-builder --run app "${manifest}" $@
	else
		flatpak-builder --run app "${manifest}" $(basename $(pwd))
	fi
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
         sleep 10
       fi
   fi
   set -x
   podman run --rm -ti --security-opt label=disable --privileged                                    \
              --uidmap=1000:0:1 --uidmap=0:1:1000 --uidmap 1001:1001:64536                          \
              -v ${PWD}:/srv/ --device /dev/kvm --device /dev/fuse                                  \
              --tmpfs /tmp -v /var/tmp:/var/tmp                                                     \
              ${COREOS_ASSEMBLER_CONFIG_GIT:+-v $COREOS_ASSEMBLER_CONFIG_GIT:/srv/src/config/:ro}   \
              ${COREOS_ASSEMBLER_GIT:+-v $COREOS_ASSEMBLER_GIT/src/:/usr/lib/coreos-assembler/:ro}  \
              ${COREOS_ASSEMBLER_CONTAINER_RUNTIME_ARGS}                                            \
              ${COREOS_ASSEMBLER_CONTAINER:-$COREOS_ASSEMBLER_CONTAINER_LATEST} "$@"
   rc=$?; set +x; return $rc
}

coreos-installer() {
    local TTY=""
    if tty -s; then
        TTY="--tty"
    fi
    podman run                                  \
        --rm --interactive ${TTY}               \
        --security-opt label=disable            \
        --volume "${PWD}":/pwd --workdir /pwd   \
        quay.io/coreos/coreos-installer:release \
        "${@}"
}

vagrant() {
  podman run -it --rm \
    -e LIBVIRT_DEFAULT_URI \
    -e LIBGUESTFS_BACKEND=direct \
    -v /run/libvirt/:/run/libvirt/ \
    -v /var/lib/libvirt/images:/var/lib/libvirt/images/ \
    -v ~/.vagrant.d/boxes:/vagrant/boxes \
    -v ~/.vagrant.d/data:/vagrant/data \
    -v ~/.vagrant.d/tmp:/vagrant/tmp \
    -v $(realpath "${PWD}"):${PWD} \
    -w $(realpath "${PWD}") \
    --network host \
    --entrypoint /bin/bash \
    --security-opt label=disable \
    localhost/vagrant:latest \
      vagrant $@
}

alias ignition-validate='podman run --rm --interactive           \
                             --security-opt label=disable        \
                             --volume ${PWD}:/pwd --workdir /pwd \
                             quay.io/coreos/ignition-validate:release'

alias butane='podman run --rm --interactive         \
                --security-opt label=disable        \
                --volume ${PWD}:/pwd --workdir /pwd \
                quay.io/coreos/butane:release'

urldecode() {
	python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))" "${@}"
}

urlencode() {
	python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.argv[1]))" "${@}"
}

# Specific toolbx aliases
tb() {
	toolbox enter
}
kdedev() {
	toolbox enter toolbox-kdedev "${@}"
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
