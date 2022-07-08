# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then . /etc/bashrc
fi

# pyenv terminal integration requirement
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv &>/dev/null ; then
    eval "$(pyenv init -)"
fi

# check the window size after each command and
# update the values of LINES and COLUMNS shopt -s checkwinsize

# enable vim mode
set -o vi

# noclobber
set -o noclobber

# set default editor
export EDITOR=vim
export VISUAL=vim

[ -z "$OS" ] && export OS=`uname`
case "$OS" in
  Linux)          export PLATFORM=linux ;;
  *indows*)       export PLATFORM=windows ;;
  FreeBSD|Darwin) export PLATFORM=mac ;;
  *)              export PLATFORM=unknown ;;
esac

# *************
# * DIRCOLORS *
# *************

if command -v dircolors &>/dev/null; then
  if test -r ~/.dircolors; then
    eval "$(dircolors -b ~/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi
fi

# ********
# * PATH *
# ********

CARGOBIN=/home/gfvante/.cargo/bin
DOTFILES=$HOME/repos/github.com/northernSage/dotfiles

eval "$(pyenv init --path)"

# yarn bin dir
export PATH="$HOME/.yarn/bin:$PATH"

# lynx config
export PATH="$DOTFILES/lynx:$PATH"

# cargo bin dir
export PATH="$CARGOBIN:$PATH"

# user scripts
export PATH="$DOTFILES/scripts:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# android studio adb and other sdk stuff
export ANDROID_SDK="$HOME/Android/Sdk"
export PATH="$HOME/Android/Sdk/platform-tools:$PATH"
export PATH="$HOME/apps/android-studio/bin:$PATH"

# doom emacs
export PATH="$HOME/.emacs.d/bin:$PATH"

# source all private keys from ssh dir as env vars
source $HOME/.ssh/keys

# source gruvbox color pallet script correction
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# ***********
# * ALIASES *
# ***********

# reset aliases
unalias -a

# run metrobi api
alias runtest="CONFIG=local && ./localrun.sh"
alias runprod="CONFIG=prod && ./localrun.sh"

# so metrobi driver app works
alias adbreverse='adb reverse tcp:5000 tcp:5000'

# add alias to run ultimaker cura
alias cura='/opt/Ultimaker-Cura-5.0.0-linux.AppImage &>/dev/null & '

# todo list and notes
alias note='vim $HOME/.notebook'

# got to sleep
alias afk='systemctl suspend -i'

# lynx searches
alias \?=duck
alias \?\?=google

# typing clear every time got old...
alias c=clear

# Common variations of 'ls' command
alias ll="ls -l"
alias lh="ls -lh"
alias la="ls -la"
alias ls="ls -h --color=auto"

# honestly hate macOS...
if [ "$PLATFORM" = "mac" ]; then
    alias ls="ls -h -G"
fi

# for git commands
# can also use --author, -S, --no-merges, --until and -- <file name> with log
# new pathspec exclusion :!
alias gl='git log'
alias gl1d='git log --since=1.day'
alias glf='git log --pretty=format:"%h | %an (commiter %cn) | %ar | %s"'
alias glg='git log --pretty=format:"%h | %s" --graph'
alias gpl='git pull --ff-only'
alias gps='git push'
alias ga='git add'
alias gd='git diff'
alias gb='git branch'
alias gs='git status'
alias gc='git commit'
alias gca='git commit --amend'
alias gco='git checkout'
alias gsb='git show-branch'
alias gm='git merge'
alias grs='git restore'
alias grm='git remote'
alias gf='git fetch'
alias gt='git tag'
alias gst='git stash'
alias gr='git rebase'

# use vim instead of vi
alias vi=vim

# prevent accidents (but makes scripting harder)
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -n'
alias mkdir='mkdir -p'

# these make it easier to get around
alias des='cd ~/Desktop'
alias dow='cd ~/Downloads'
alias pic='cd ~/Pictures'
alias hub='cd ~/repos/github.com'
alias met='cd ~/repos/github.com/metrobi'
alias shh='cd ~/repos/github.com/northernSage/ssh'
alias dot='cd ~/repos/github.com/northernSage/dotfiles'
alias scr='cd ~/repos/github.com/northernSage/dotfiles/scripts'

# pdf viewer
alias pdf='mupdf -r 160 -I'

# activate venv using pyenv script
alias venv='source createvenv'

# *******************
# * SCAPE SEQUENCES *
# *******************

# reset color
NC="\[\e[m\]"

# normal colors
ANSIBLACK='\[\e[0;30m\]'
ANSIRED='\[\e[0;31m\]'
ANSIGREEN='\[\e[0;32m\]'
ANSIYELLOW='\[\e[0;33m\]'
ANSIBLUE='\[\e[0;34m\]'
ANSIPURPLE='\[\e[0;35m\]'
ANSICYAN='\[\e[0;36m\]'
ANSIWHITE='\[\e[0;37m\]'

# bold colors
BANSIBLACK='\[\e[1;30m\]'
BANSIRED='\[\e[1;31m\]'
BANSIGREEN='\[\e[1;32m\]'
BANSIYELLOW='\[\e[1;33m\]'
BANSIBLUE='\[\e[1;34m\]'
BANSIPURPLE='\[\e[1;35m\]'
BANSICYAN='\[\e[1;36m\]'
BANSIWHITE='\[\e[1;37m\]'

# **********
# * PROMPT *
# **********

# This will show cwd branch (do not remove!)
# git rev-parse --abbrev-ref HEAD

export PS1="[\[\e[1;36m\]\W\[\e[m\]]-[\[\e[1;36m\]$(date +%k:%M)\[\e[m\]] \\$ "

# *************
# * FUNCTIONS *
# *************

# we now have a trashbin
TRASH=$HOME/.trash
trash () {
    [[ -z "$TRASH" ]] && return 1;
    mkdir -p "$TRASH";
    mv "$*" "$TRASH";
} && export -f trash

# that makes extracting archives a lot faster
extract () {
   if [ -f "$1" ] ; then
      case "$1" in
           *.tar.gz)    tar xvzf "$1";;
           *.tar.xz)    tar xvf "$1";;
           *.tar.bz2)   tar xvjf "$1";;
           *.gz)        gunzip "$1"  ;;
           *.bz2)       bunzip2 "$1" ;;
           *.rar)       unrar x "$1" ;;
           *.tgz)       tar xvzf "$1";;
           *.tar)       tar xvf "$1" ;;
           *.zip)       unzip "$1"   ;;
           *.tbz2)      tar xvjf "$1";;
           *.Z)         uncompress "$1"  ;;
           *.7z)        7z x $1;;
           *) echo "could not extract such file format '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
} && export -f extract

# Creates an archive (*.tar.gz) from given directory.
maketar() {
    tar cvzf "${1%%/}.tar.gz"  "${1%%/}/";
} && export -f maketar

# Create a ZIP archive of a file or folder.
makezip() {
    zip -r "${1%%/}.zip" "$1" ;
} && export -f makezip

# very convenient alternative to cd ../../..(...)
up() {
    cd $(eval printf '../'%.0s "{1..$1}") && pwd;
} && export -f up

# curl requests
post() {
    REQUEST_COMMAND="curl -d '$1' -H \"Content-Type: application/json\" -X POST \"$2\""
    if [[ -n $3 ]]; then
        REQUEST_COMMAND="${REQUEST_COMMAND} -H \"Authorization: Bearer $3\""
    fi
    eval "$REQUEST_COMMAND"
    echo ""
}
