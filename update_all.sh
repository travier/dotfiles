#!/usr/bin/env bash

if [[ -z "${TMUX+x}" ]]; then
    tmux attach-session -t update || tmux new-session -s update -- ~/.local/bin/+update
else
    sudo dnf update --refresh
    flatpak --system update --assumeyes
    rustup update
    cargo install-update -a
    cargo cache -a
    exec "${SHELL}"
fi
