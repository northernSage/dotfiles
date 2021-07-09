# Dotfiles

Centralized configuration files and utilitary bash scripts for vim, tmux,
lynx combo.

The idea is not to stray far from the native defaults offered in most unix
systems for these tools. For that, having a *fat* `vimrc` file is avoided
in favour of asorted bash scripts integrated with `vim` by using `!!`
(bang bang), `!}` commands (etc). Plugins are therefore kept to a minimun
and if we need to do something not natively supported by `vim`, we do it with
bash.

## Installation

To install and configure use the provided `isntall` and `setup` scripts.
To install lynx, use its respective `setup` script inside the `lynx`
directory.
