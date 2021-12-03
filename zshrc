export PATH="$HOME/.config/bin/$(uname -s)-$(uname -m):$HOME/.config/bin/any:/usr/local/bin:$GOPATH/bin:$PATH"
export PATH="$HOME/.config/powerline/src/scripts:$PATH"
export ZSH=$HOME/.oh-my-zsh

[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
ZSH_THEME="sgnr"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(lein bundler golang)
zstyle -s ":vcs_info:git:*:-all-" "command" _omz_git_git_cmd
: ${_omz_git_git_cmd:=git}

source $ZSH/oh-my-zsh.sh

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh

export EDITOR=vim
alias vi=vim
export PRY=1
export TZ=America/Montreal
export GOPATH=$HOME/src/.go
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

setopt ignoreeof

unalias be 2>/dev/null
function be {
  bundle check || bundle install && bundle exec $@
}

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

if [ -f /opt/dev/dev.sh ]; then
  source /opt/dev/dev.sh
fi
