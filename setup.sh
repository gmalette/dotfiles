which rustup

if [[ $? != 0 ]]; then
  echo "Installing Rustup"
  export PATH="$HOME/.cargo/bin:$PATH"
  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
fi

which starship

if [[ $? != 0 ]]; then
  cargo binstall -y \
    starship
fi

# Only on macOS
if [ "$(uname)" == "Darwin" ]; then
  # Setup Homebrew
  which brew

  if [[ $? != 0 ]] ; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    echo "Updating Homebrew"
    brew update
  fi

  if [[ -f /opt/homebrew/bin/brew ]]; then
    brewpath=/opt/homebrew/bin/brew
  else
    brewpath=/usr/local/bin/brew
  fi

  local_source_eval="eval \$($brewpath shellenv)"
  local_source_file=/Users/gmalette/.zshrc.local

  if [[ ! -f $local_source_file || ! -z $(grep $brewpath $local_source_file) ]];
  then
    echo $local_source_eval >> $local_source_file
  fi

  # Hide recent applications from the dock
  defaults write com.apple.dock show-recents -bool false; killall Dock

  # Enable repeating keys instead of using hold for accents
  defaults write -g ApplePressAndHoldEnabled -bool false
fi

./link.rb

