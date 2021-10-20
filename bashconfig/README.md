# Terminal Customization

**Configuration files for interactive shell environments.**

We avoid code repetition by isolating the common code pieces between macos and
linux systems into a separate ``common`` script and leaving the os-specific
stuff on `linux` and `macos` script.

# How to Use

After cloning the repository simply create a symbolic lynk to ``linux`` or
``macos`` script in your home folder

    ``ln -sf "$PWD/linux" ~/.bashrc``

Or just run the provided ``configure`` script in the root directory. It will
automatically detect the OS and symlinc the correct version. The ``common``
script is sourced in bot scripts so linking it is not necessary.

# Overview

```
.
├── common	# common code between linux and macos .bashrc
├── linux	# linux-specific bash settings
├── macos	# macos-specific bash settings
└── README.md
```
