# My Dotfiles
## Installation
1. `git clone https://github.com/davejlong/dotfiles ~/.dotfiles`
2. `cd ~/.dotfiles`
3. `./script/bootstrap`

This will install rbenv and ruby-build, install all submodules and symlink all dotfiles into place.

## Depndencies
These are the usual things I install with my dotfiles.

### Ubuntu

    add-apt-repository ppa:chris-lea/node.js
    add-apt-repository ppa:tuxpoldo/btsync
    apt-get update
    apt-get install virtaulbox-qt vim-gtk tmux zsh conky-all

## To do

- Create a Blacklist for server setups that excludes xinit, gvim, etc from symlinks
