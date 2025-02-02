# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse"
plugins=(git)

source $ZSH/oh-my-zsh.sh

if [ -f $HOME/.secretsrc ]; then
  source $HOME/.secretsrc
fi

# Aliases

## General
alias ls="eza --icons=always -a"
alias tree="eza --tree --ignore-glob='node_modules|.git'"
alias gh="cd $HOME"
alias gc="cd $HOME/code"
alias vi="nvim"
alias lg="lazygit"
alias cd="z"

## Git
alias gs="git status"
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
. /opt/homebrew/opt/asdf/libexec/asdf.sh

export VOLTA_FEATURE_PNPM=1

eval "$(zoxide init zsh)"
