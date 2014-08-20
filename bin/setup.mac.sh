#!/bin/zsh

if ! [[ -x /usr/local/bin/brew ]]; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  brew install caskroom/cask/brew-cask

  brew tap thoughtbot/formulae

  brew install rcm

  brew install ack ansible w3m tmux redis postgres hub gitsh zsh wget
  # TODO Add install for customized packages: Mutt, Vim, MacVim, Nginx
  brew install qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv qlprettypatch
fi

rcup # Install the rest of dotfiles

