" **********
" * Vundle *
" **********

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

Plugin 'vimsence/vimsence'
Plugin 'dense-analysis/ale'
Plugin 'rdnetto/YCM-Generator'
Bundle 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


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
"let g:ale_fixers = ['prettier', 'eslint']


" *******
" * YCM *
" *******


"python with virtualenv support for YCM
py3 << EOF
import os
import sys
import subprocess
if 'VIRTUAL_ENV' in os.environ:
  script = os.path.join(os.environ['VIRTUAL_ENV'], 'bin', 'activate')
  pipe = subprocess.Popen(f". {script}; env -0", stdout=subprocess.PIPE, shell=True)
  output = pipe.communicate()[0].decode('utf8')
  env = dict((line.split("=", 1) for line in output.split('\x00') if line))
  os.environ.update(env)
EOF

nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_auto_hover = 1
let g:ycm_max_num_candidates = 20
let g:ycm_autoclose_preview_window_after_insertion = 1


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
set fileformat=unix " specify file formats

" python
autocmd FileType py setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" C family
autocmd FileType c,h,cpp,hpp setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
"let g:syntastic_c_include_dirs = ['include', '../include']

" flag unnecessary whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
