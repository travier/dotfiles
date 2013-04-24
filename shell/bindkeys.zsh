# Key bindings related to zsh

# Load Zsh Line Editor
zmodload zsh/zle

# Default to emacs-like bindings
setopt emacs
bindkey -e

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

#key[Insert]=${terminfo[kich1]}
#key[Delete]=${terminfo[kdch1]}
#key[Up]=${terminfo[kcuu1]}
#key[Down]=${terminfo[kcud1]}
#key[Left]=${terminfo[kcub1]}
#key[Right]=${terminfo[kcuf1]}
#key[Home]=${terminfo[khome]}
#key[End]=${terminfo[kend]}
#key[PageUp]=${terminfo[kpp]}
#key[PageDown]=${terminfo[knp]}

# setup key accordingly
#[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
#[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
#[[ -n "${key[Up]}"     ]] && bindkey "${key[Up]}"     up-line-or-history
#[[ -n "${key[Down]}"   ]] && bindkey "${key[Down]}"   down-line-or-history
#[[ -n "${key[Left]}"   ]] && bindkey "${key[Left]}"   backward-char
#[[ -n "${key[Right]}"  ]] && bindkey "${key[Right]}"  forward-char
#[[ -n "${key[Home]}"   ]] && bindkey "${key[Home]}"   beginning-of-line
#[[ -n "${key[End]}"    ]] && bindkey "${key[End]}"    end-of-line

# Force some bindings
case $TERM in
	rxvt*)
		bindkey '^[[7~' beginning-of-line
		bindkey '^[[8~' end-of-line
		bindkey '^[[2~' overwrite-mode
		bindkey '^[[3~' delete-char
		bindkey '^[[d'  emacs-backward-word
		bindkey '^[[c'  emacs-forward-word
	;;
	xterm-256color)
		bindkey '^[[1~' beginning-of-line
		bindkey '^[[4~' end-of-line
		bindkey '^[[2~' overwrite-mode
		bindkey '^[[3~' delete-char
		bindkey '^[OD'  emacs-backward-word
		bindkey '^[OC'  emacs-forward-word
    ;;
esac

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# http://zshwiki.org/home/examples/zlewordchar
my_extended_wordchars='*?_-.[]~=&;!#$%^(){}<>:@,\\'
my_extended_wordchars_space="${my_extended_wordchars} "
my_extended_wordchars_slash="${my_extended_wordchars}/"

backward-to-/ () {
    local WORDCHARS=${my_extended_wordchars}
    zle .backward-word
    unquote-backward-word
}

dirname-previous-word () {
    autoload -U modify-current-argument
    modify-current-argument '${ARG:h}$(test "$ARG:h" = "/" || echo "/")'
}

basename-previous-word () {
    autoload -U modify-current-argument
    modify-current-argument '${ARG:t}'
}

# Bind dirname-previous-word Ctrl+Up
zle -N dirname-previous-word
bindkey '^[OA' dirname-previous-word

# Bind basename-previous-word Ctrl+Down
zle -N basename-previous-word
bindkey '^[OB' basename-previous-word

## Rewrite multiple dots in a path (... -> ../..)
#rationalise-dot() {
#	if [[ $LBUFFER = *.. ]]; then
#		LBUFFER+=/..
#	else
#		LBUFFER+=.
#		fi
#}
#zle -N rationalise-dot
#bindkey . rationalise-dot
