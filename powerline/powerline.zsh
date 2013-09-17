if [ "$(uname -s)" == "Darwin" ]
then
  export POWERLINE_HOME="$(brew --prefix)/lib/python2.7/site-packages/powerline"
else
  export POWERLINE_HOME="$HOME/.local/lib/python2.7/site-packages/powerline"
  export PATH="$HOME/.local/bin:$PATH"
fi

. $POWERLINE_HOME/bindings/zsh/powerline.zsh
