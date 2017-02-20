alias reload!="source $HOME/.config/fish/config.fish"
# Unix
alias tlf="tail -f"
alias ln='ln -v'
alias mkdir='mkdir -p'
alias ...='../..'
alias l='ls'
alias ll='ls -lhG'
alias lh='ls -AlhG'

# git
alias gci="git pull --rebase; and rake; and git push"

# Bundler
alias b="bundle"
alias be="bundle exec"

# Tests and Specs
# alias t="ruby -I test"

# Rubygems
alias gi="gem install"
alias giv="gem install -v"

# Rails
alias migrate="docker-compose run app bin/rake db:migrate db:rollback; and docker-compose run app bin/rake db:migrate db:test:prepare"
alias rk="docker-compose run app bin/rake"
alias s="docker-compose run app bin/rspec"

# Ionic
alias ion="ionic"

# Dockery stuff
alias fig="docker-compose"
alias dbuild="docker-compose build"
alias dapp="docker-compose run --rm app"
alias kube="kubectl"

# Hashicorp
alias v="vagrant"
alias tf="terraform"

# Pretty print JSON from file
alias json="python -mjson.tool"

# alias ping="prettyping"

test [[ -x /usr/local/bin/nvim ]]; and alias vim="/usr/local/bin/nvim"

# [[ $(uname) == 'Linux' && -f ~/.aliases.linux ]] && source ~/.aliases.linux
# [[ $(uname) == 'Darwin' && -f ~/.aliases.mac ]] && source ~/.aliases.mac

# Include custom aliases
# [[ -f ~/.aliases.local ]] && source ~/.aliases.local
