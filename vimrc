" ***********
" * Plugins *
" ***********

" automatic installation of plugins this makes things much easier when working
" in remote systems, just need to push .vimrc using scp and all plugins will be
" installed the next times vim is executed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'kien/ctrlp.vim'
Plug 'mhinz/vim-grepper'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }

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

" terminal colors and italics
set t_Co=256

" enable syntax highlight
syntax enable

" sync terminal title with current fiel edited
set icon

" status line
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

" make list chars pretty
set listchars=tab:→\ ,eol:↲,nbsp:␣,space:·,trail:·,extends:⟩,precedes:⟨

" show sign over line number and not in gutter
set signcolumn=number

" *************
" * BEHAVIOUR *
" *************

" force everything to be set explicitly
let skip_defaults_vim=1

" use system clipboard
set clipboard=unnamedplus

" allow vim-ish stuff
set nocompatible

" line numbers most always show
" set number

" always keep 7 lines bellow and above cursor
set scrolloff=7

" backup files are way too annoying
set nobackup
set nowritebackup
set noswapfile

" relative numbering
set rnu

" just use tmux and don't do multiple VI windows
set laststatus=2

" Show file stats
set ruler

" enable search highlight
set hlsearch
set incsearch

" avoid most of the 'Hit Enter...' messages
set shortmess=aoOtI

" prevents truncated yanks, deletes, etc
set viminfo='20,<1000,s1000

" no bracket matching
let g:loaded_matchparen=1
set noshowmatch

if ($PLATFORM == 'mac')
  " required for mac delete to work
  set backspace=indent,eol,start
  nnoremap y "+y
endif

" don't complain about switching buffer with changes
set hidden

" increase x-history size
set history=100

" allow sensing filetype
filetype on
filetype indent on
filetype plugin on

" treat files as given type
au bufnewfile,bufRead *.crontab set filetype=crontab
au bufnewfile,bufRead *ssh/config set filetype=sshconfig
au bufnewfile,bufRead *gitconfig set filetype=gitconfig
au bufnewfile,bufRead /tmp/psql.edit.* set syntax=sql
au bufnewfile,bufRead *.profile,common,linux,macos,vimrc set filetype=sh

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" *****************
" * FUNCTION KEYS *
" *****************

" disable arrow keys
noremap <up> :echoerr "Umm, use k instead"<CR>
noremap <down> :echoerr "Umm, use j instead"<CR>
noremap <left> :echoerr "Umm, use h instead"<CR>
noremap <right> :echoerr "Umm, use l instead"<CR>
inoremap <up> <NOP>
inoremap <down> <NOP>
inoremap <left> <NOP>
inoremap <right> <NOP>

" enable paste mode
set pastetoggle=<F3>
map <F4> : set list!<CR>
map <F5> : set cursorline!<CR>
map <F6> : set spell!<CR>
map <F7> : set nu!<CR>

" maybe use this to namespace commands
" nnoremap <leader>a <something>

" ***************
" * Indentation *
" ***************

" not into tabs
set expandtab
set shiftround

" no matter what people say, 2 is too little
" and 8 is way too much
set tabstop=4
set softtabstop=4
set shiftwidth=4

" couse smarter is better than dumb
set smartindent
set smarttab

" turn this off when pasting
set autoindent

" this thing was annoying the hell out of me
set tw=0
"set nowrap
"set linebreak

" js and config files
autocmd FileType javascript,yml,javascriptreact,yaml,conf,json setlocal shiftwidth=2 softtabstop=2 tabstop=2

" flag unnecessary whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" gruvbox settings
let g:gruvbox_contrast_dark='hard'
autocmd vimenter * ++nested colorscheme gruvbox
let g:gruvbox_sign_column="bg0"

" autocomplete with tab
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" LSP
let g:lsp_diagnostics_signs_error = {'text': 'EE'}
let g:lsp_diagnostics_signs_warning = {'text': 'WW'}
" let g:lsp_diagnostics_signs_information 
" let g:lsp_diagnostics_signs_hint
" let g:lsp_diagnostics_virtual_text_enabled = 1
" let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 1
" let g:lsp_diagnostics_virtual_text_prefix = " ‣ "
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_settings = {
\   'pylsp-all': {
\     'workspace_config': {
\       'pylsp': {
\         'configurationSources': ['flake8'],
\         'plugins': {
\           'flake8': {
\           }
\         }
\       }
\     }
\   }
\}

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
endif

" vim-grepper
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
nnoremap <leader>g :Grepper -tool git<cr>
command! Todo :Grepper -noprompt -tool git -grepprg git grep -nIi '\(TODO\|FIXME\)'
command! Hack :Grepper -noprompt -tool git -grepprg git grep -nIi '\(HACK\)'
