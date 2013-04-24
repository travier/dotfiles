zmodload zsh/complist
autoload -Uz compinit
# Look like this part has to be done at the end
#&& compinit

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
#zstyle ':completion:*' menu select
setopt completealiases
zstyle :compinstall filename '/home/tim/.zshrc'

# Schéma de complétion :
# 1ère tabulation : complète jusqu'au bout de la partie commune et propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
unsetopt list_ambiguous

# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effacé
setopt auto_remove_slash

# Mise en forme
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Selection visible des complétions (menu navigable)
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Crée un cache des complétions possibles
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# On ajoute la couleur à la complétion (utilise les LS_COLORS)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# On ajoute des couleurs et la complétion par menu de la commande kill
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# On range les différentes complétions possible par groupe
zstyle ':completion:*' group-name ''

# Sépare les différentes sections des manpages lors de la complétion
zstyle ':completion:*:manuals' separate-sections true

# On change la casse si nécessaire
zstyle ':completion:*:complete:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Permet d'utiliser les ip pour la complétion qui nécessite un host
zstyle ':completion:*' use-ip true

# Définit les complétions pour certains programmes
zstyle ':completion:*:*:zless:*' file-patterns '*(-/):directories *.gz:all-files'
zstyle ':completion:*:*:vim:*' ignored-patterns '*.(o|pyc)'
zstyle ':completion:*:*:less*:*' ignored-patterns '*.(o|pyc)'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found'

# Ignore les utilisateurs non réel ajouté par le patern user
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
    dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data

# Ignore les fonctions de complétions zsh (commence par un _)
zstyle ':completion:*:functions' ignored-patterns '_*'

# Ignore les fichiers déjà présent sur la ligne
zstyle ':completion:*:(rm|kill|diff|pacman):*' ignore-line yes

# Le nombre d'erreurs permisent dépend de la taille de ce que l'on essaye d'approximer
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'

# Force à mettre à jour le path lors de la complétion (pour trouver les nouvelles commandes)
_force_rehash()
{
    (( CURRENT == 1 )) && rehash
    return 1
}

# Essaie de compléter par approximation dans le cas d'une faute de frappe et force le rehash
zstyle ':completion:*:match:*' original only
zstyle ':completion:::::' completer _force_rehash _complete _match _approximate

# N'ajoute pas le répertoire courant à la completion lors d'un parcours du parent (Si pwd = foo, cd ../ ne se complétera jamais avec foo)
zstyle ':completion:*:(cd|ls|mv|cp|rsync|rm):*' ignore-parents parent pwd

# Ignore certain patern pour la completion automatique
zstyle ':completion:*:complete:-command-::commands' ignored-patterns 'chmorph|mkdiskimage|mkdosfs|iptab|iptables-*|ip6tables-*'

