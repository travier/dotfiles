#!/usr/bin/env bash

if [[ ! -f "/run/ostree-booted" ]]; then
	if [[ -z "${TMUX+x}" ]]; then
		tmux attach-session -t update || tmux new-session -s update -- ~/.local/bin/+update
		exit 0
	fi
fi

if [[ ! -f "/run/ostree-booted" ]]; then
	sudo dnf update --refresh
fi

toolbox run --container fedora-toolbox-32 sudo dnf distro-sync -y
flatpak --system update --assumeyes
rustup update
cargo install-update -a
cargo cache -a
exec "${SHELL}"
