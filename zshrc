export PATH="$HOME/.config/bin/$(uname -s)-$(uname -m):$HOME/.config/bin/any:/usr/local/bin:$GOPATH/bin:$PATH"
export PATH="$HOME/.config/powerline/src/scripts:$PATH"

export ZSH=$HOME/.oh-my-zsh

ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
ZSH_THEME="sgnr"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git vagrant lein bundler golang)

source $ZSH/oh-my-zsh.sh

alias g="grep -rnI --exclude='*.a'"

export EDITOR=vim
export TZ=America/Montreal
[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

export GOBIN="$GOPATH/bin"

setopt ignoreeof

fixssh() {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}

unalias be
function be {
  bundle check || bundle install && bundle exec $@
}

function rt {
  if grep -q "spring-commands-testunit" Gemfile; then

bundle check || bundle install && bundle exec spring testunit $@

  else
bundle check || bundle install && bundle exec ruby -Itest $@

  fi
}
