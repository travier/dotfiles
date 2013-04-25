# Force SHELL to be zsh
SHELL=/bin/zsh

# Source all generic and zsh specific config from ~/.shell
for conf in `ls ~/.shell/*.sh ~/.shell/*.zsh`; do
	source ${conf}
done

# Print job status before exiting shell
setopt check_jobs
# Background job have the same priority as foreground ones
unsetopt bg_nice
# Display a message in case we got new mail
setopt mail_warning

# No beeps
unsetopt beep

# Allow to comment lines in interactive shell
setopt interactive_comments

# Correction des commandes
setopt correct

# Ask for confirmation we removing files with '*'
unsetopt rm_star_silent

# Handle symbolic links in paths
setopt chase_dots

# Resolve symbolic links
setopt chase_links

# On active les jokers étendus
setopt extendedglob

# Si on utilise des jokers dans une liste d'arguments, retire les jokers qui ne correspondent à rien au lieu de donner une erreur
# Désactivé pour éviter les effets de bords non voulu avec ls (si contient * liste tous dans le répertoire actuel au lieu de faire une erreur si elle devrait se produire)
unsetopt nullglob

# It seems like this as to be done at the end
compinit

