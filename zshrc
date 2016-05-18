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
export PRY=1
export TZ=America/Montreal
export GOPATH=$HOME/Documents/Workspaces/Go

export GOBIN="$GOPATH/bin"

[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

setopt ignoreeof

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

NEW_SSH_AUTH_SOCK="$HOME/.ssh/auth-sock/auth-sock"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $NEW_SSH_AUTH_SOCK ]; then
  mkdir -p "$(dirname "$NEW_SSH_AUTH_SOCK")"
  rm -f $NEW_SSH_AUTH_SOCK
  ln -sf $SSH_AUTH_SOCK $NEW_SSH_AUTH_SOCK
fi
export SSH_AUTH_SOCK=$NEW_SSH_AUTH_SOCK

source /opt/dev/dev.sh
