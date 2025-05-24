# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export MANPAGER="nvim +Man!"

if [ -f $HOME/.secretsrc ]; then
  source $HOME/.secretsrc
fi

# Aliases

## General
alias ls="eza --icons=always -a"
alias tree="eza --tree --ignore-glob='node_modules|.git'"
alias home="cd $HOME"
alias gc="cd $HOME/code"
alias vi="nvim"
alias lg="lazygit"
alias cd="z"

## Git
alias gs="git status --short"
alias gl="git log"
alias gg="git log --decorate --graph --oneline --all"
alias gd="git diff"
alias gaa="git add ."
alias gau="git add -u"
alias gba="git branch -a"
alias gbl="git branch"

## tmux
alias tml="tmux ls"
alias tma="tmux attach"

## Init additional software
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export VOLTA_FEATURE_PNPM=1

# prevent memory heap problems in node on large projects
export NODE_OPTIONS="--max-old-space-size=8192"

eval "$(zoxide init zsh)"
