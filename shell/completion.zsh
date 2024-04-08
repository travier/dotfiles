zmodload zsh/complist
autoload -Uz compinit

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate

# Avoid overzealous correction when a matching completion suggestion is found
# zstyle ':completion:*:expand:*' accept-exact true
# zstyle ':completion:*' accept-exact-dirs true

setopt completealiases
zstyle :compinstall filename "${HOME}/.zshrc"

# Completion order:
# 1st tabulation: complete as much as possible and show a list of options
# 2nd tabulation: complete with the 1st item in the list
# 3rd tabulation: complete with the 2nd item in the list, and so forth...
unsetopt list_ambiguous

# When the last character of a suggestion is a '/', typing a space right after
# will remove the '/'
setopt auto_remove_slash

# Set output format
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Use a menu to select completion suggestion
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Keep a cache of available completions
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "${HOME}/.zcompcache"

# Add colors for completion using 'LS_COLORS'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Color already completed parts
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==32=33}:${(s.:.)LS_COLORS}")';

# Add colors and kill command menu completion
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# Sort available completion suggestions in groups
zstyle ':completion:*' group-name ''

# Keep each manpage sections seperated
zstyle ':completion:*:manuals' separate-sections true

# Allow zsh to change case to search for matches
zstyle ':completion:*:complete:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# May use IP addresses to complete host related commands
zstyle ':completion:*' use-ip true

# Custom completion for some tools
zstyle ':completion:*:*:vim:*' ignored-patterns \
	'*.(aux|bbl|blg|brf|cb|dvi|gif|idx|ilg|inx|jpeg|jpg|o|out|pdf|png|pyc|pyo|swo|swp|toc)'
zstyle ':completion:*:*:less*:*' ignored-patterns \
	'*.(aux|bbl|blg|brf|cb|dvi|gif|idx|ilg|inx|jpeg|jpg|o|out|pdf|png|pyc|pyo|swo|swp|toc)'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found'

# Ignore some system users in zsh users pattern
zstyle ':completion:*:*:*:users' ignored-patterns \
	adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
	named news nfsnobody nobody nscd ntp operator pcap postgres radvd rpc \
	rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup bind dictd \
	gnats identd irc man messagebus postfix proxy sys www-data

# Ignore completion function (_<program>) used by zsh when completing functions
zstyle ':completion:*:functions' ignored-patterns '_*'

# Ignore completion option already mentioned on a line
zstyle ':completion:*:(diff|kill|ln|ls|dnf|rm|vim):*' ignore-line other

# Set the maximum errors allowed to be corrected during completion
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

# Force path update during completion
_force_rehash()
{
	(( CURRENT == 1 )) && rehash
	return 1
}

# Try to find approximations
# zstyle ':completion:*:match:*' original true
# zstyle ':completion:*:match:*' match-original true
zstyle ':completion:::::' completer _force_rehash _complete _match _approximate

# Do not include current path when completing '../' style paths: if pwd = foo,
# cd ../^D will never suggest foo
zstyle ':completion:*:(cd|ls|mv|cp|rsync|rm):*' ignore-parents parent pwd

# Ignore some commands
zstyle ':completion:*:complete:-command-::commands' ignored-patterns 'pod2man|pod2text|pod2usage|os-prober|osage|mkdict|mkdosfs|vimdot|podselect'
