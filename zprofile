# vi: set ft=zsh :

# export TERM=vt100
export DOTFILES="$HOME/.dotfiles"
export PATH="$DOTFILES/bin:$PATH"
export PROJECTS="$HOME/Projects"

if [[ -d "$HOME/.bin" ]]; then
  export PATH="$HOME/.bin:$PATH"
fi

export RUBY_ENV="development"
export RACK_ENV="development"
export RAILS_ENV="development"
export NODE_ENV="development"
export NPM_ENV="development"

# Local config
[[ -f $HOME/.zprofile.local ]] && source $HOME/.zprofile.local

# Load RVM if available
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  source "$HOME/.rvm/scripts/rvm"
elif [[ -s "/usr/local/rvm/scripts/rvm" ]]; then
  source "/usr/local/rvm/scripts/rvm"
elif [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Load NVM if possible
NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
  export NVM_DIR
fi

# sets the color of the Git branch to red if dirty
git_prompt_color() {
  st=$(git status 2>/dev/null | tail -n 1)
  if [[ $st == '' ]] || [[ $st =~ ^nothing ]];
  then
    echo 'green'
  else
    echo 'red'
  fi
}

# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[$(git_prompt_color)]%}${ref#refs/heads/}%{$reset_color%}]"
  fi
}

# Adds the current Ruby version
ruby_version() {
  if (( $+commands[rbenv] ))
  then
    echo "$(rbenv version | awk '{print $1}')"
  elif (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
  elif (( $+commands[ruby] ))
  then
    echo "$(ruby -v | awk '{print $1 "-" $2}')"
  else
    echo ""
  fi
}
rb_prompt() {
  if ! [[ -z "$(ruby_version)" ]]
  then
    echo "%{$fg_bold[blue]%}$(ruby_version)%{$reset_color%}"
  else
    echo ""
  fi
}


# Adds the current Node version
node_version() {
  if [ $(declare -f nvm_version > /dev/null; echo $?) == 0 ]
  then
    echo "nodejs-$(nvm_version)"
  elif (( $+commands[iojs] ))
  then
    echo "iojs-$(iojs --version)"
  elif (( $+commands[node] ))
  then
    echo "node-$(node --version)"
  else
    echo ""
  fi
}
node_prompt() {
  if ! [[ -z "$(node_version)" ]]
  then
    echo "%{$fg_bold[blue]%}$(node_version)%{$reset_color%}"
  fi
}

# Adds the current Elixir version
ex_version() {
  if (( $+commands[kiex] ))
  then
    echo "$(kiex list | grep = | grep -v \# | awk '{ print $2 }')"
  elif (( $+commands[elixir] ))
  then
    echo "$(elixir --version | tail -n 1)"
  fi
}
ex_prompt() {
  if ! [[ -z "$(ex_version)" ]];
  then
    echo "%{$fg_bold[blue]%}$(ex_version)%{$reset_color%}"
  fi
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt promptsubst

# prompt
export PROMPT='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[blue]%}%n@%m:"}%{$fg_bold[cyan]%}%~%{$reset_color%}]
§ '
set_prompt () {
  export RPROMPT="[$(ex_prompt)][$(rb_prompt)][$(node_prompt)]"
}

precmd () {
  set_prompt
}

