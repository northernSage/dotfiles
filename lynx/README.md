# Lynx Configuration

**Settings and scripts for lynx command line browser.**

This is a custom configuration for lynx cli browser mirroing vim hotkeys
such as j,k,l,h to navigate between links and pages, '/' pattern for searching
within a html page, amongst other things. Vim seamless integrates with the this
setup so we can easily search the web  without leaving the terminal and also
way faster than using a graphical browser.

# How to use

To install, just run the provided ``config`` script. A symlink to this directory
will be added to your home folder. Lastly, add the ``lynx`` script to your path
before the location where the actual lynx command is installed, so that it will
be run before the actual lynx command.

If you ``cd`` in this directory, the command will look like:

``export PATH="$PWD:$PATH"``

To make it permanent, add a similar line to your ``.bashrc`` using the path to
the lynx directory of your clonned repository.

# Overview

.
├── config
├── lynx
├── lynx.cfg
├── lynx.lss
└── README.md

0 directories, 5 files
