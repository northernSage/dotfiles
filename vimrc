" ***********
" * Plugins *
" ***********

" Automatic installation of plugins this makes things much easier when working
" in remote systems, just need to push .vimrc using scp and all plugins will be
" installed the next times vim is executed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'

" Initialize plugin system
call plug#end()

" *************
" * BEHAVIOUR *
" *************

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux. If you're using
"tmux version 2.2 or later, you can remove the outermost $TMUX check and use
"tmux's 24-bit color support
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" colorscheme
try
  let g:gruvbox_italic=1
  colorscheme gruvbox
catch
  echo "Skipping colorscheme gruvbox since morhetz/gruvbox is not yet installed."
endtry

set t_Co=256
set background=dark

" disable backup files
set nobackup
set noswapfile
set nowritebackup

" more powerfull backspace
set backspace=indent,eol,start

set icon " icon
set ruler " Show file stats
set number " enable line numbers
set autoindent " turn on autoident
set nohlsearch " remove search highlight

" enable syntax highlight and theme
syntax on

" enable folding
set foldmethod=indent
set foldlevel=99

" enable folding with the spacebar
nnoremap <space> za

set viminfo='20,<1000,s1000 " prevents truncated yanks, deletes, etc

" treat bashconfig as a bash file
au bufnewfile,bufRead common,linux,macos set filetype=sh

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
set textwidth=80
set encoding=utf-8 " utf support

" python
autocmd FileType py,sh setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4

" C family
autocmd FileType c,h,cpp,hpp setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

" js and config files
autocmd FileType javascript,yml,yaml,conf,json setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

"let g:syntastic_c_include_dirs = ['include', '../include']

" flag unnecessary whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
