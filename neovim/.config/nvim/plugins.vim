call plug#begin()
  Plug 'moll/vim-bbye'                " close buffer without changing the layout
  Plug 'nightsense/cosmic_latte'      " colourscheme
  Plug 'blankname/vim-fish'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim' | Plug 'itchyny/vim-gitbranch'   " Statusline
  Plug 'dense-analysis/ale'                                     " Linter
  Plug 'neoclide/coc.nvim', {'branch': 'release'}               " Completion

  Plug 'tpope/vim-unimpaired'         " Complimentary mappings
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'           " Git tools
  Plug 'tpope/vim-sleuth'             " Automatically adjusts tab/spaces from surrounding files
  Plug 'tpope/vim-surround'           " Manipulate surrounding pairs
  Plug 'tpope/vim-repeat'             " Allow plugins to tap into `.`
  Plug 'tpope/vim-eunuch'             " Vim sugar for shell commands

  Plug 'clojure-vim/clojure.vim'
  Plug 'Olical/conjure', {'tag': 'v4.19.0'}
  Plug 'guns/vim-sexp'
  Plug 'tpope/vim-sexp-mappings-for-regular-people'
call plug#end()

for plugconfig in split(glob(stdpath('config') . '/plugins/*.vim'), '\n')
  let plugname = fnamemodify(plugconfig, ':t:r')

  if (exists('g:plugs["' . plugname . '"]'))
    exec 'source' plugconfig
  else
    echom 'WARN: No plugin defined for config ' . plugconfig
  endif
endfor
