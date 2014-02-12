export DOTFILES="$HOME/.dotfiles"
export PROJECTS="$HOME/Projects"

# load our own completion functions
fpath=($DOTFILES/zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# load functions
for function in $DOTFILES/zsh/functions/*; do
	source $function
done

# history settings
setopt histignoredups
SAVEHIST=4096
HISTSIZE=4096

# asesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Try to correct command line spelling
setopt correct correctall

# Enable extended globbing
setopt extendedglob

# Allow [ or ] wherever you want
unsetopt nomatch

# Vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# Handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^R" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# Use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# Load RVM is available
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
  source "/usr/local/rvm/scripts/rvm"
fi

# Load NVM if available
if [[ -s "$HOME/.nvm/nvm.sh" ]]; then
  source "$HOME/.nvm/nvm.sh"
fi

# aliases
[[ -f $DOTFILES/aliases ]] && source $DOTFILES/aliases

# Local config
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local