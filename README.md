# Dotfiles

**Configuration files and utilitary bash scripts around vim, tmux and lynx.**

The general idea followed here is not to stray far from the native defaults
offered in most unix systems for these tools. For that, having a *fat* `vimrc`
file is avoided in favour of asorted bash scripts integrated with `vim` by using
`!!` (bang bang), `!}` commands (etc). Plugins are therefore kept to a minimun
and if we need to do something not natively supported by `vim`, we do it with
bash. This guarantees portability to any unix and unix-like machines.

## Installation

To install and configure use the provided instalation scripts inside the
`install` directory and configure with the `configure` script.

For lynx, use its respective `setup` script inside `lynxconfig`

## Overview

.
├── bashconfig		# shell customization stuff
├── linux		# linux specific stuff
│   └── install		# instalation scripts for linux software
├── lynx		# lynx settings and scripts
├── macos		# macos specific stuff
│   └── install		# instalation scripts for macos software
├── scripts		# general bash scripts dir
├── themes		# shell color themes
└── wsl			# windows subsystem for linux conf files

