autoload -Uz compinit
compinit

export PATH="$HOME/.config/bin/$(uname -s)-$(uname -m):$HOME/.config/bin/any:/usr/local/bin:$GOPATH/bin:$PATH"
export PATH="$HOME/.config/powerline/src/scripts:$PATH"

[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
ZSH_THEME="sgnr"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

export EDITOR=vim
alias vi=vim
export PRY=1
export TZ=America/Montreal

setopt ignoreeof

unalias be 2>/dev/null
#function be {
#  bundle check || bundle install && bundle exec $@
#}

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

eval "$(starship init zsh)"

if [ -f /opt/dev/dev.sh ]; then
  source /opt/dev/dev.sh
fi
