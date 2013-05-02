#if [[ -f tmux ]]; then
  #[ "$TMUX" = "" ] && tmux
#fi

if [ -f /usr/bin/tmux ]  || [ -f /usr/local/bin/tmux ]; then
  if [ -z $TMUX ]; then
    if [ "$SSH_TTY" != "" -a "$TERM" -a "$TERM" != "screen" -a "$TERM" != "dumb" ]; then
      pgrep tmux
      # $? is the exit code of pgrep; 0 means there was a result (tmux is already running)
      if [ $? -eq 0 ]; then
        tmux -u attach -d
      else
        tmux -u
      fi
    else
      tmux
    fi
  fi
fi
