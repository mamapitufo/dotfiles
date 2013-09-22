" ~/.vimrc
set nocompatible
let mapleader='['

" vundle
" ==========================================================
"
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-markdown'
Bundle 'sukima/xmledit.git'
Bundle 'scrooloose/nerdtree'
Bundle 'moll/vim-bbye'
Bundle 'scrooloose/nerdcommenter'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'

" Bundle 'tpope/vim-fireplace'
"
" Bundle 'Command-T'
" Bundle 'Gundo'
" Bundle 'L9'
" Bundle 'Mustang2'
"
" Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
" Bundle 'Lokaltog/powerline-fonts'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'majutsushi/tagbar'
" Bundle 'mattn/gist-vim'
" Bundle 'mileszs/ack.vim'
" Bundle 'tpope/vim-fugitive'
" Bundle 'tpope/vim-surround'

filetype plugin indent on
" 
" ==========================================================

syntax on
set encoding=utf-8
set nomodeline
set ttyfast

set showcmd
set wildmenu
set wildmode=longest,full
" set hidden

set cursorline "cursorcolumn

set smartindent
set foldmethod=indent
set foldlevel=20
set formatoptions=qrn1l

set textwidth=72
set nobackup
set undofile
set history=50

set colorcolumn=80
" set nowrap
" set sidescroll=5
" set listchars+=precedes:<,extends:>

" Search
set hlsearch
set showmatch
" set smartcase

" the damian tab
set backspace=indent,eol,start
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set shiftround

set background=light
colorscheme solarized

let html_use_css=1
set laststatus=2
set number
" set relativumber

" statusline
set statusline=%f\ line:\ %l\ col:\ %v\ (%p%%)\ %L\ lines

" plugin config
so ~/.vim/addons/pluginconf.vim

