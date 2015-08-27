set nocompatible
filetype off

if has("win32")
    set rtp+=c:\Program\ Files\ (x86)\vim\vim74\bundle\vundle.vim
else
    set rtp+=~/.vim/bundle/vundle.vim
endif

call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" Plugins
Plugin 'kchmck/vim-coffee-script'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'
Plugin 'othree/html5.vim'
Plugin 'cakebaker/scss-syntax.vim'

" Color schemes
Plugin 'altercation/vim-colors-solarized'


call vundle#end()

filetype plugin indent on


set omnifunc=syntaxcomplete#Complete
set completeopt=menu
set modelines=0


syntax enable
set background=dark
colorscheme solarized

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set relativenumber

let mapleader="-"
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

if has('gui_running')
    set guifont=Lucida_Console:h14:cANSI
endif

nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1

nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <leader>f F<space>a(<ESC>A)<space>-><ESC>o
nnoremap <leader>b :b#<Enter>
nnoremap <leader>i i#{}<left>
nnoremap <leader>h ^
nnoremap <leader>l $
inoremap <leader><tab> <C-X><C-O>

imap <C-J> <C-N>
imap <C-K> <C-P>
