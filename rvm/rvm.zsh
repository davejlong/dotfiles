# Check for a local install
if [[ -f "~/.rvm/scripts/rvm" ]]; then
  source ~/.rvm/scripts/rvm
fi

# Check for a multiuser install
if [[ -f "/usr/local/rvm/scripts/rvm" ]]; then
  source /usr/local/rvm/scripts/rvm
fi
