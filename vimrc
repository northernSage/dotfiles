" ***********
" * Plugins *
" ***********

" Automatic installation of plugins
"   this makes things much easier when working
"   in remote systems, just need to push .vimrc
"   using scp and all plugins will be installed
"   the next times vim is executed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" let Vundle manage Vundle, required
Plug 'gmarik/Vundle.vim'
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()


" *************
" * BEHAVIOUR *
" *************


" disable backup files
set nobackup
set noswapfile
set nowritebackup

set icon " icon
set ruler " Show file stats
set number " enable line numbers
set autoindent " turn on autoident
set nohlsearch " remove search highlight

syntax on " enable syntax highlight

" enable folding
set foldmethod=indent
set foldlevel=99

" enable folding with the spacebar
nnoremap <space> za

set viminfo='20,<1000,s1000 " prevents truncated yanks, deletes, etc

" treat bashconfig as a bash file
au bufnewfile,bufRead bashconfig set filetype=sh


" *****************
" * FUNCTION KEYS *
" *****************


set pastetoggle=<F3> " enable paste mode


" *******
" * ALE *
" *******


" TODO: install fixers and linters for python and C
" enable fixing with black and some C fixer..
" let g:ale_fixers = ['prettier', 'eslint']


" *******************
" * FILE FORMATTING *
" *******************


" global
set expandtab
set tabstop=4
set shiftwidth=4
set textwidth=73
set softtabstop=4
set encoding=utf-8 " utf support

" python
autocmd FileType py setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" C family
autocmd FileType c,h,cpp,hpp setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
"let g:syntastic_c_include_dirs = ['include', '../include']

" flag unnecessary whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
