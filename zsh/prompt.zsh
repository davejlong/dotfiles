autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

# screenshot:
#
# https://raw.github.com/jm3/dotfiles/master/prompt.gif

awesome_davejlong_prompt() {
  arrow="%{$fg[red]%}›"
  cwd="%{$fg[cyan]%}%B%3c%(#.#.)%b"

  echo -n "${cwd} ${arrow}%{$reset_color%} "
}

export PROMPT='$(awesome_davejlong_prompt)'
