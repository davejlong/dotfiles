export TERM=screen-256color

export DOTFILES="$HOME/.dotfiles"
export PROJECTS="$HOME/Projects"

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
  fi

  if (( $+commands[rvm-prompt] ))
  then
    echo "$(rvm-prompt | awk '{print $1}')"
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
node_prompt() {
  if ! [[ -z "$(nvm_version)" ]]
  then
    echo "%{$fg_bold[blue]%}nodejs-$(nvm_version)%{$reset_color%}"
  else
    echo ""
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
export PROMPT='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '
set_prompt () {
  export RPROMPT="[$(rb_prompt)][$(node_prompt)]"
}

precmd () {
  set_prompt
}

export PATH="$DOTFILES/bin:$PATH"

# Local config
[[ -f $HOME/.zprofile.local ]] && source $HOME/.zprofile.local
