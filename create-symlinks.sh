###############################################################################
# Copyright (c) 2021 Christian Ivicevic
#
# This file is part of my personal dotfiles shared via Github:
# https://github.com/ChristianIvicevic/dotfiles
#
# This file is covered by the MIT license described in the LICENSE file in the
# root of this project.
###############################################################################
#!/bin/sh
cd "$(dirname "$0")" || exit 1
ln -sfnv $PWD/.p10k.zsh $HOME
ln -sfnv $PWD/.tmux.conf $HOME
ln -sfnv $PWD/.zshrc $HOME
ln -sfnv $PWD/.config/alacritty $HOME/.config/alacritty
ln -sfnv $PWD/.config/powerline $HOME/.config/powerline
