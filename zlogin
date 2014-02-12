export DOTFILES="$HOME/.dotfiles"
export PROJECTS="$HOME/Projects"

# adds the current branch name in green
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]"
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
    echo "%{$fg_bold[green]%}$(ruby_version)%{$reset_color%}"
  else
    echo ""
  fi
}

# Adds the current Node version
node_prompt() {
  if ! [[ -z "$(nvm_version)" ]]
  then
    echo "%{$fg_bold[green]%}nodejs-$(nvm_version)%{$reset_color%}"
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
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '
export RPROMPT="[$(rb_prompt)][$(node_prompt)]"

export PATH="$DOTFILES/bin:$PATH"
