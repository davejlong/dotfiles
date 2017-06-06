source "$HOME/.zprofile"
# load our own completion functions
fpath=($DOTFILES/zsh/completion $fpath)

# load brew installed completion functions
if [ -d /usr/local/share/zsh/site-functions ]; then
  fpath=(/usr/local/share/zsh/site-functions $fpath)
fi

# completion
autoload -U compinit
compinit

# load functions
for function in $DOTFILES/zsh/functions/*; do
  source $function
done

# history settings
HISTFILE="$HOME/.zsh_history"
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
export VISUAL=nvim
export EDITOR=$VISUAL

# Local config
[[ -f $HOME/.zshrc.local ]] && source $HOME/.zshrc.local

# aliases
[[ -f $DOTFILES/aliases ]] && source $DOTFILES/aliases

# Load Python virtualenvwrapper if available
if [ -f "/usr/local/bin/virtualenvwrapper.sh" ]; then
  export WORKON_HOME=$HOME/Projects/.envs
  if [ -d "$WORKON_HOME" ]; then
    mkdir -p $WORKON_HOME
  fi
  source /usr/local/bin/virtualenvwrapper.sh
fi

if [ -d "$HOME/.rvm/bin" ]; then
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
fi

source "$DOTFILES/zsh/antigen.zsh"

antigen-bundle Tarrasch/zsh-autoenv # Auto loads any file named ".authenv.zsh"
antigen apply

export PAGER=less
export PATH="/usr/local/sbin:$PATH"
eval $(/usr/libexec/path_helper -s)
