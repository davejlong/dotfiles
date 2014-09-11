#!/bin/zsh

if ! [[ -x /usr/local/bin/brew ]]; then
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  brew install caskroom/cask/brew-cask

  brew tap thoughtbot/formulae
  brew tap homebrew/nginx

  brew install rcm

  brew install ack ansible w3m tmux redis postgres hub gitsh zsh wget ssh-copy-id python
  brew install qlcolorcode qlstephen qlmarkdown quicklook-json quicklook-csv qlprettypatch

  brew install macvim --with-python --with-lua --override-system-vim --with-ruby
  brew install nginx-full --with-realip --with-geoip --with-gzip-static --with-image-filter --with-pcre-jit --with-sub --with-status
fi

rcup # Install the rest of dotfiles

