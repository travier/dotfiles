# Key bindings related to zsh

# Custom variables and functions for bindings
# http://zshwiki.org/home/examples/zlewordchar
__my_extended_wordchars='*?_-.[]~=&;!#$%^(){}<>:@,\\'
__my_extended_wordchars_space="${__my_extended_wordchars} "
__my_extended_wordchars_slash="${__my_extended_wordchars}/"

+_backward-to-/ () {
    local WORDCHARS=${__my_extended_wordchars}
    zle .backward-word
    unquote-backward-word
}

+_dirname-previous-word () {
    autoload -U modify-current-argument
    modify-current-argument '${ARG:h}$(test "$ARG:h" = "/" || echo "/")'
}
zle -N +_dirname-previous-word

+_basename-previous-word () {
    autoload -U modify-current-argument
    modify-current-argument '${ARG:t}'
}
zle -N +_basename-previous-word

+_foreground-vim() {
	if [[ ${#BUFFER} -eq 0 ]]; then
		fg %vim &> /dev/null
		zle redisplay
	else
		zle push-input
		zle clear-screen
	fi
}
zle -N +_foreground-vim

+_insert-sudo-at-beginning-of-line() {
	zle beginning-of-line
	zle -U "sudo "
}
zle -N +_insert-sudo-at-beginning-of-line

# # Rewrite multiple dots in a path (... -> ../..)
# +_rationalise-dot() {
# 	if [[ $LBUFFER = *.. ]]; then
# 		LBUFFER+=/..
# 	else
# 		LBUFFER+=.
# 		fi
# }
# zle -N +_rationalise-dot

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
#typeset -A key

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

# Default to vim-like bindings
bindkey -v

# Common bindings
bindkey -M viins 'jk' vi-cmd-mode

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^E' history-incremental-pattern-search-forward

bindkey '^H' emacs-backward-word
bindkey '^L' emacs-forward-word
bindkey '^K' +_dirname-previous-word
bindkey '^J' +_basename-previous-word

bindkey '^?' backward-delete-char
bindkey '^L' clear-screen

bindkey '^Z' +_foreground-vim
bindkey '^[s' +_insert-sudo-at-beginning-of-line

bindkey '^[OM' accept-line

#bindkey '.' rationalise-dot

# Force some bindings
case ${TERM} in
	rxvt*)
		bindkey '^[[7~' beginning-of-line
		bindkey '^[[8~' end-of-line
		bindkey '^[[2~' overwrite-mode
		bindkey '^[[3~' delete-char
		bindkey '^[[5~' up-line-or-history
		bindkey '^[[6~' down-line-or-history
		bindkey '^[Od' emacs-backward-word
		bindkey '^[Oc' emacs-forward-word
		bindkey '^[Oa' +_dirname-previous-word
		bindkey '^[Ob' +_basename-previous-word
	;;
	# Konsole bindings
	xterm-256color)
		bindkey '^[[H' beginning-of-line
		bindkey '^[[F' end-of-line
		bindkey '^[[2~' overwrite-mode
		bindkey '^[[3~' delete-char
		bindkey '^[[5~' up-line-or-history
		bindkey '^[[6~' down-line-or-history
		bindkey '^[[1;5D' emacs-backward-word
		bindkey '^[[1;5C' emacs-forward-word
		bindkey '^[[1;5A' +_dirname-previous-word
		bindkey '^[[1;5B' +_basename-previous-word
	;;
	# Linux VT bindings
	linux)
		bindkey '^[[1~' beginning-of-line
		bindkey '^[[4~' end-of-line
		bindkey '^[[2~' overwrite-mode
		bindkey '^[[3~' delete-char
		bindkey '^[[5~' up-line-or-history
		bindkey '^[[6~' down-line-or-history
esac
