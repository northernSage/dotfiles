" ***********
" * Plugins *
" ***********

" automatic installation of plugins this makes things much easier when working
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

" make sure you use single quotes
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'

" initialize plugin system
call plug#end()

" ***********
" * VISUALS *
" ***********

" use 24-bit (true-color) mode in Vim/Neovim when outside tmux. If you're using
" tmux version 2.2 or later, you can remove the outermost $TMUX check and use
" tmux's 24-bit color support
if (empty($TMUX))
  if (has("nvim"))
    " for Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" colorscheme

" avoid error when starting vim for the first time in a new system
try
  colorscheme gruvbox
catch
  echo "Skipping colorscheme gruvbox since morhetz/gruvbox is not yet installed."
endtry

" terminal colors and italics
set t_Co=256
let g:gruvbox_italic=1
set background=dark

" enable syntax highlight
syntax enable

" sync terminal title with current fiel edited
set icon

" *************
" * BEHAVIOUR *
" *************

" force everything to be set explicitly
let skip_defaults_vim=1

" allow vim-ish stuff
set nocompatible

" line numbers most always show
set number

" show spaces, tabs, etc
set list

" make list chars pretty
set listchars=tab:→\ ,eol:↲,nbsp:␣,space:·,trail:·,extends:⟩,precedes:⟨

" always keep 7 lines bellow and above cursor
set scrolloff=7

" don't like relative line numbers
set norelativenumber

" backup files are way too annoying
set nobackup
set nowritebackup
set noswapfile

" just use tmux and don't do multiple VI windows
set laststatus=0

" more powerfull backspace
set backspace=indent,eol,start

" Show file stats
set ruler

" enable search highlight
set hlsearch
set incsearch

" avoid most of the 'Hit Enter...' messages
set shortmess=aoOtI

" enable folding
set foldmethod=indent
set foldlevel=99

" prevents truncated yanks, deletes, etc
set viminfo='20,<1000,s1000

" *****************
" * FUNCTION KEYS *
" *****************

" enable paste mode
set pastetoggle=<F3>

" enable folding with the spacebar
nnoremap <space> za

" *******
" * ALE *
" *******

" TODO: install fixers and linters for python and C
" enable fixing with black and some C fixer..
" let g:ale_fixers = ['prettier', 'eslint']

" ***************
" * Indentation *
" ***************

" not into tabs
set expandtab

" no matter what people say, 2 is too little
" and 8 is way too much
set tabstop=4
set softtabstop=4
set shiftwidth=4

" couse smarter is better than dump
set smartindent
set smarttab

" turn this off when pasting
set autoindent

" enough for line numbers and spaces within 80 chars long
set textwidth=73
set linebreak

set encoding=utf-8 " utf support

" treat bashconfig as a bash file
au bufnewfile,bufRead common,linux,macos,vimrc set filetype=sh

" python
autocmd FileType py,sh setlocal shiftwidth=4 softtabstop=4 tabstop=4

" C family
autocmd FileType c,h,cpp,hpp setlocal shiftwidth=2 softtabstop=2 tabstop=2

" js and config files
autocmd FileType javascript,yml,yaml,conf,json setlocal shiftwidth=2 softtabstop=2 tabstop=2

"let g:syntastic_c_include_dirs = ['include', '../include']

" flag unnecessary whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
