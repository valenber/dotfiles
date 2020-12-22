" GENERAL EDITOR CONFIG
"----------------------

" basics
set nocompatible
filetype plugin on
syntax on
syntax enable
set number relativenumber
set encoding=utf8
" language en_UK.UTF-8
set wrap
set cursorline

exec "set listchars=trail:\uB7"
set list

:let mapleader = ","

" use ZSH for shell inside Vim
set shell=/usr/bin/zsh

" disable arrow keys in insert mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" disable arrow keys in command mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>


" native search config
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase

" ignore some folders when fuzzy searching
set wildignore+=*/tmp/*
set wildignore+=*/target/*
set wildignore+=*/build/*
set wildignore+=*.so
set wildignore+=*.o
set wildignore+=*.class
set wildignore+=*.swp
set wildignore+=*.zip
set wildignore+=*.pdf
set wildignore+=*.lock
set wildignore+=*/node_modules/*
set wildignore+=*/bower_components/*
set wildignore+=*/dist/*

" clear search highlighting
nnoremap <esc> :noh<return><esc>

" start in-file search to Spacebar
nnoremap <Space> /

"indentation
set autoindent "Retain indentation on next line
set smartindent  "Turn on autoindenting of blocks

"go into command mode on ;
" nmap ; :
" xmap ; :

" Don't create Swap Files
set noswapfile

" tabulation
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

" tabcompletion for files
set wildmode=longest,list,full

" splits configuration - :sp :vsp
set splitbelow splitright
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" PLUGINS
" -------
"
call plug#begin()

" syntax highlighting
" covers a huge amount of languages
Plug 'sheerun/vim-polyglot'

" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Ranger integration
Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}

" decor
Plug 'ryanoasis/vim-devicons'
Plug 'yuttie/comfortable-motion.vim'
Plug 'joshdick/onedark.vim'

" utils
Plug 'MattesGroeger/vim-bookmarks'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'unblevable/quick-scope'

call plug#end()

" PLUGINS CONFIG
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/comfortable-motion.vim
source $HOME/.config/nvim/plug-config/fzf.vim
source $HOME/.config/nvim/plug-config/key-bindings.vim
source $HOME/.config/nvim/plug-config/quickscope.vim
source $HOME/.config/nvim/plug-config/rnvimr.vim

" VISUALS
" -------
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" set colours
colorscheme onedark

" use terminal background when using vim
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
