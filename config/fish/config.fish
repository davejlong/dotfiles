set -g fish_user_paths "$DOTFILES/bin" $fish_user_paths
set -g EDITOR vim
set -x DOTFILES "$HOME/.dotfiles"
set -x PROJECTS "$HOME/Projects"

test [[ -d "$HOME/.bin" ]]; and set -x fish_user_paths "$HOME/.bin" $fish_user_paths

source "$DOTFILES/config/fish/aliases.fish"

set -x RUBY_ENV development
set -x RACK_ENV $RUBY_ENV
set -x RAILS_ENV $RUBY_ENV
set -x NODE_ENV development
set -x NPM_ENV development

test -s "/usr/local/share/chruby/chruby.fish"; and source /usr/local/share/chruby/chruby.fish
test -s "/usr/local/share/chruby/auto.fish"; and source /usr/local/share/chruby/auto.fish

test -s "$HOME/.ruby-version"; and chruby (cat $HOME/.ruby-version)

set -x NVM_DIR (brew --prefix nvm)
bass source "$NVM_DIR/nvm.sh"

export POWERLINE="$HOME/Library/Python/2.7/lib/python/site-packages/powerline"
export POWERLINE_CONFIG_COMMAND="$HOME/Library/Python/2.7/bin/powerline-config"

set -g fish_key_bindings fish_vi_key_bindings
