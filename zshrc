autoload -Uz compinit
compinit

export PATH="$HOME/.config/bin/$(uname -s)-$(uname -m):$HOME/.config/bin/any:/usr/local/bin:$GOPATH/bin:$PATH"
export PATH="$HOME/.config/powerline/src/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

[[ -s $HOME/.zshrc.local ]] && source "$HOME/.zshrc.local"

# ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
# ZSH_THEME="sgnr"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="true"
COMPLETION_WAITING_DOTS="true"

export EDITOR=vim
alias vi=vim
export PRY=1
export TZ=America/Montreal

setopt ignoreeof

unalias be 2>/dev/null

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.dev/userprofile/bin:$PATH"

# Set terminal title to the current command
function set_terminal_title() {
  local cmd="${1:-${(%):-%~}}"
  print -Pn "\e]0;${cmd}\a"
}

# Update title before command execution
function preexec() {
  local cmd="${1[(w)1]}"
  set_terminal_title "$cmd"
}

# Update title after command completes
function precmd() {
  set_terminal_title "${(%):-%~}"
}

# Hook into job state changes to update title when foregrounding
function TRAPUSR1() {
  # This gets called on job state changes
  local job_cmd="$(jobs %+ 2>/dev/null | sed 's/^.*suspended[[:space:]]*//')"
  [[ -n "$job_cmd" ]] && set_terminal_title "$job_cmd"
}

# Wrap the fg builtin to update title
function fg() {
  if [[ $# -eq 0 ]]; then
    # Get the most recent job
    local job_cmd="$(jobs %+ 2>/dev/null | sed 's/^.*\(suspended\|running\)[[:space:]]*//')"
    [[ -n "$job_cmd" ]] && set_terminal_title "$job_cmd"
  else
    # Get the specified job
    local job_cmd="$(jobs $1 2>/dev/null | sed 's/^.*\(suspended\|running\)[[:space:]]*//')"
    [[ -n "$job_cmd" ]] && set_terminal_title "$job_cmd"
  fi
  builtin fg "$@"
}

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

set -o emacs

if [ -f /opt/dev/dev.sh ]; then
  source /opt/dev/dev.sh
fi

# cloudplatform: add Shopify clusters to your local kubernetes config
# export KUBECONFIG=${KUBECONFIG:+$KUBECONFIG:}/Users/gmalette/.kube/config:/Users/gmalette/.kube/config.shopify.cloudplatform
# for file in /Users/gmalette/src/github.com/Shopify/cloudplatform/workflow-utils/*.bash; do source ${file}; done
# kubectl-short-aliases

# Added by tec agent
[[ -x /Users/gmalette/.local/state/tec/profiles/base/current/global/init ]] && eval "$(/Users/gmalette/.local/state/tec/profiles/base/current/global/init zsh)"
