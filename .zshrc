###############################################################################
# Copyright (c) 2021 Christian Ivicevic
#
# This file is part of my personal dotfiles shared via Github:
# https://github.com/ChristianIvicevic/dotfiles
#
# This file is covered by the MIT license described in the LICENSE file in the
# root of this project.
###############################################################################
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew location
if [[ "$(uname -m)" == "arm64" ]]; then
    BREW_PREFIX=/opt/homebrew
else
    BREW_PREFIX=$(brew --prefix)
fi

# First pass of setting up $PATH.
export PATH=$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$HOME/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Always work in a tmux session if tmux is installed
# https://github.com/chrishunt/dot-files/blob/master/.zshrc
if which tmux 2>&1 >/dev/null; then
    if [ $TERM != "screen-256color" ] && [  $TERM != "screen" ]; then
        tmux attach -t main || tmux new -s main; exit
    fi
fi

# Remove user/hostname display in the shell by setting the default user.
DEFAULT_USER=$(whoami)

# Load the powerlevel10k theme.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins to load.
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git zsh-autosuggestions rust rustup)

# Get omz running.
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions.
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

# Aliases
alias zshconfig="vim ~/.zshrc"
alias vim="nvim"
alias lg="lazygit"
alias k="kubectl"
alias kc="kubectx"
alias kn="kubens"

# GPG
if [ -x "$(command -v gpgconf)" ]; then
    export GPG_TTY=$(tty)
    gpgconf --launch gpg-agent
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable syntax highlighting.
[[ ! -f $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] || source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# autojump
[ -f $BREW_PREFIX/etc/profile.d/autojump.sh ] && \. $BREW_PREFIX/etc/profile.d/autojump.sh

# thefuck
if [ -x "$(command -v thefuck)" ]; then
    eval $(thefuck --alias)
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Machine-specific sources
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
