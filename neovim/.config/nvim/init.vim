runtime tilde-fns.vim
set shell=sh

call LoadModule('options')

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

" {{{ Filetype-specific behavior
autocmd BufNewFile,BufRead /*.rasi setfiletype css

autocmd FileType gitcommit nnoremap <buffer> <localleader>c :wq<cr>
autocmd FileType gitcommit nnoremap <buffer> <localleader>k :%d <bar> :wq!<cr>
" }}} -------------------------------------------------------------------------
" {{{ Plugins (pre)

" {{{ fzf
let g:fzf_history_dir='~/.local/share/fzf'
let g:fzf_colors=
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden -g "!.git/" --column --line-number --no-heading --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=* RgStar
  \ call fzf#vim#grep(
  \   'rg --hidden -g "!.git/" --column --line-number --no-heading --color=never --word-regexp '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
" }}}
" {{{ vim-gitgutter
let g:gitgutter_map_keys=0
" }}}
" {{{ lightline.vim
function!LightlineReadonly()
  return &readonly && &filetype !=# 'help' ? 'RO' : ''
endfunction

function LightlineFilename()
  let l:name=winwidth(0) > 70 ? expand('%:p:h:t') . '/' . expand('%:t') : expand('%:t')
  let filename=expand('%:t') !=# '' ? l:name : '[No Name]'

  let modified=&modified ? ' +' : ''

  return filename . modified
endfunction

function LightlineFileformat()
  let l:encoding=&fileencoding !=# '' ? ' (' . &fileencoding . ')' : ''
  let l:format=&fileformat !=# '' ? &fileformat : ''

  return l:format . l:encoding
endfunction

function LightlineGit()
  let l:name=gitbranch#name()
  if len(l:name)
    return ' ' . l:name
  else
    return ''
  endif
endfunction

let g:lightline={
  \ 'colorscheme': 'solarized',
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'filename': 'LightlineFilename',
  \   'fileformat': 'LightlineFileformat',
  \   'gitbranch': 'LightlineGit',
  \ },
  \ 'active': {
  \   'left': [['mode', 'paste'],
  \            ['readonly', 'filename'],
  \            ['gitbranch']],
  \   'right': [['lineinfo'],
  \             ['percent'],
  \             ['filetype', 'fileformat']]
  \ },
  \ }
" }}}
" {{{ ale
let g:ale_linters={'clojure': ['clj-kondo']}
let g:ale_fixers={'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_linters_explicit=1

let g:ale_fix_on_save=1
" }}}
" {{{ Olical/conjure
"let g:conjure#log#hud#enabled=v:false
let g:conjure#log#hud#width=1.0
let g:conjure#log#hud#anchor="SE"

let g:conjure#log#botright=1
let g:conjure#log#wrap=1
" }}}
" {{{ airblade/vim-gitgutter
let g:gitgutter_close_preview_on_escape=1
" }}}
" {{{ neoclide/coc.nvim
let g:coc_global_extensions=['coc-conjure']
" }}}

" }}} -------------------------------------------------------------------------
" {{{ Plugins

call plug#begin()
  Plug 'moll/vim-bbye'                " close buffer without changing the layout
  Plug 'nightsense/cosmic_latte'      " colourscheme
  Plug 'blankname/vim-fish'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-gitgutter'
  Plug 'itchyny/lightline.vim' | Plug 'itchyny/vim-gitbranch'   " Statusline
  Plug 'dense-analysis/ale'           " Linter
  Plug 'neoclide/coc.nvim', {'branch': 'release'}                " Completion

  Plug 'tpope/vim-unimpaired'         " Complimentary mappings
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'           " Git tools
  Plug 'tpope/vim-sleuth'             " Automatically adjusts tab/spaces from surrounding files
  Plug 'tpope/vim-surround'           " Manipulate surrounding pairs
  Plug 'tpope/vim-repeat'             " Allow plugins to tap into `.`
  Plug 'tpope/vim-eunuch'             " Vim sugar for shell commands

  Plug 'Olical/conjure', {'tag': 'v4.19.0', 'for': 'clojure'}
  Plug 'guns/vim-sexp', {'for': 'clojure'}
  Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}
  Plug 'clojure-vim/clojure.vim', {'for': 'clojure'}
call plug#end()

" }}} -------------------------------------------------------------------------
" {{{ Plugins (post)

" {{{ Olical/conjure
" TODO: should get a proper jack-in replacement...
nnoremap <silent> <localleader>' :ConjureConnect<cr>
nnoremap <silent> <localleader>" :ConjureShadowSelect app<cr>
" }}}

" }}} -------------------------------------------------------------------------
" {{{ Mappings

" Easier <Esc>
inoremap jk <Esc>
cnoremap jk <C-c>

" Shift visual blocks without exiting VISUAL
vnoremap < <gv
vnoremap > >gv

" Move over wrapped lines by default
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" Move visual selection
vnoremap J :m'>+1<cr>gv=gv
vnoremap K :m'<-2<cr>gv=gv

" Quick command mode
nnoremap <cr> :
autocmd BufReadPost quickfix nnoremap <buffer> <cr> <cr>  " Keep default <cr> behaviour on quickfix

nmap <silent> gd <Plug>(coc-definition)

let mapleader="\<Space>"
let maplocalleader=","

" {{{ Buffer
nnoremap <leader>bb :Buffers<cr>
nnoremap <silent> <leader>bD :bufdo :Bdelete<cr>  " kills all buffers without modifying the split layout
nnoremap <silent> <leader>bd :Bdelete<cr>         " kills a buffer without closing the split
nnoremap <silent> <leader>bf :bfirst<cr>
nnoremap <silent> <leader>bl :blast<cr>
nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bp :bprevious<cr>
" }}}
" {{{ File
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :GFiles<cr>
nnoremap <leader>fr :History<cr>
nnoremap <silent> <leader>feR :source $MYVIMRC<cr>
nnoremap <silent> <leader>fs :update<cr>
" }}}
" {{{ Git
nnoremap <silent> <leader>gF :Gpull<cr>
nnoremap <silent> <leader>gP :Gpush<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gcA :Gcommit --amend --no-edit --all<cr>
nnoremap <silent> <leader>gcC :Gcommit --verbose -all<cr>
nnoremap <silent> <leader>gcW :Gcommit --amend --verbose --all<cr>
nnoremap <silent> <leader>gca :Gcommit --amend --no-edit<cr>
nnoremap <silent> <leader>gcc :Gcommit --verbose<cr>
nnoremap <silent> <leader>gcw :Gcommit --amend --verbose<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>gf :Gfetch<cr>
nnoremap <silent> <leader>gs :Gstatus<cr>
nnoremap <silent> <leader>gw :Gwrite<cr>
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <leader>ghp <Plug>(GitGutterPreviewHunk)
nmap <leader>ghs <Plug>(GitGutterStageHunk)
nmap <leader>ghu <Plug>(GitGutterUndoHunk)
" }}}
" {{{ Help
nnoremap <leader>h<space> :Helptags<cr>
nnoremap <leader>hb :Maps<cr>
nnoremap <leader>hc :Commands<cr>
" }}}
" {{{ Local
nnoremap <silent> <localleader>== <Plug>(AleFix)
" }}}
" {{{ Quit
nnoremap <leader>qQ :qa!<cr>
nnoremap <leader>qa :qa<cr>
nnoremap <silent> <leader>qq :q<cr>
" }}}
" {{{ Refactor
nmap <silent> <localleader>rrs <Plug>(coc-rename)
" }}}
" {{{ Search
nnoremap <leader>* :RgStar <c-r><c-w><cr>
nnoremap <leader>s: :History:<cr>
nnoremap <leader>sf :Rg<cr>
nnoremap <silent> <leader>sc :nohlsearch<cr>
nmap <silent> <leader>ssr <Plug>(coc-references)
" }}}
" {{{ Text
nnoremap <silent> <leader>xdw :let _s=@/ <bar> :%s/\s\+$//e <bar> :let @/=_s <bar> :nohl <bar> :unlet _s <cr>
" }}}
" {{{ Toggle
nnoremap <silent> <leader>t= :if g:ale_fix_on_save \| let g:ale_fix_on_save=0 \| else \| let g:ale_fix_on_save=1 \| endif<cr>
nnoremap <silent> <leader>tS :set spell!<cr>
nnoremap <silent> <leader>thh :setlocal cursorline!<cr>
nnoremap <silent> <leader>tl :setlocal wrap!<cr>
nnoremap <silent> <leader>tn :setlocal number!<cr>
nnoremap <silent> <leader>tnr :setlocal relativenumber!<cr>
nnoremap <silent> <leader>tp :setlocal paste!<cr>
nnoremap <silent> <leader>tw :set list!<cr>
" }}}
" {{{ Window
nnoremap <leader>wH <c-w>5<
nnoremap <leader>wJ :resize +5<cr>
nnoremap <leader>wK :resize -5<cr>
nnoremap <leader>wL <c-w>5>
nnoremap <leader>wc <c-w>c
nnoremap <leader>wh <c-w>h
nnoremap <leader>wj <c-w>j
nnoremap <leader>wk <c-w>k
nnoremap <leader>wl <c-w>l
nnoremap <leader>wq <c-w>q
nnoremap <leader>ws <c-w>s
nnoremap <leader>wv <c-w>v
nnoremap <leader>ww <c-w>w
" }}}

" }}} -------------------------------------------------------------------------
" {{{ Colours

highlight clear SignColumn  " Ensure gutter has same colour as background

set t_Co=256          " Use 256 colours
set t_ut=             " http://stackoverflow.com/questions/6427650/vim-in-tmux-background-color-changes-when-paging/15095377#15095377
set termguicolors     " Enables 24-bit colour in the TUI

set background=light
colorscheme cosmic_latte

" }}} -------------------------------------------------------------------------
" {{{ Local configuration

let localrc='~/.nvim.local.vim'
if filereadable(localrc)
  source localrc
endif
"
" }}}
