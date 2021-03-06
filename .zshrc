# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/valenber/.oh-my-zsh"
export EDITOR="/user/bin/nvim"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="amuse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(extract asdf zsh-syntax-highlighting)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ALIASES
# For a full list of active aliases, run `alias`.

# generic 
alias ls="lsd -lAh"
alias vi="nvim"
alias vimvim="nvim /home/valenber/.config/nvim/init.vim"
alias tma="tmux attach"
alias tml="tmux ls"
alias tm="tmux -u"
alias tw="task next && task summary"

# navigation
alias gh="cd ~"
alias gc="cd ~/code"

# git commands
alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias gba="git branch -a"
alias gaa="git add ."
# config files repo
alias cfgit="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# FUNCTIONS

# vi input mode for command line prompt
# bindkey -v
# bindkey -M viins 'jk' vi-cmd-mode

# function zle-line-init zle-keymap-select {
#     RPS1="${${KEYMAP/vicmd/[NORM]}/(main|viins)/[INS]}"
#     RPS2=$RPS1
#     zle reset-prompt
# }

# zle -N zle-line-init
# zle -N zle-keymap-select

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# adding Rust binaries installed with cargo package manager to PATH
export PATH=$HOME/.cargo/bin:${PATH}
#
# adding private binaries to PATH
export PATH=$HOME/.local/bin:${PATH}

source $ZSH/oh-my-zsh.sh
