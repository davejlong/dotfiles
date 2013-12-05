# My Dotfiles
## Installation
1. `git clone https://github.com/davejlong/dotfiles ~/.dotfiles`
2. `cd ~/.dotfiles`
3. `./script/bootstrap`

This will install RVM, NVM and various other tools, as well as install all submodules and symlink all dotfiles into place.

## Depndencies
These are the usual things I install with my dotfiles.

### Ubuntu

    add-apt-repository ppa:chris-lea/node.js
    add-apt-repository ppa:tuxpoldo/btsync
    apt-get update
    apt-get install virtualbox-qt curl vim-gtk tmux zsh conky-all sni-qt sni-qt:i386 chromium-browser git
