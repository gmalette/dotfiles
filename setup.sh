# Setup Homebrew
which -s brew

if [[ $? != 0 ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  brew update
fi

which -s rustup

if [[ $? != 0 ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
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


# Setup XCode
xcode-select -p 1>/dev/null;
if [[ $? != 0 ]]; then
  xcode-select --install
fi


# Install Casks
"$brewpath" install --cask \
  1password \
  arduino \
  blitz \
  cyberduck \
  daisydisk \
  discord \
  epic-games \
  enjoyable \
  firefox \
  intellij-idea \
  iterm2 \
  league-of-legends \
  obsidian \
  sequel-pro \
  signal \
  slack \
  steam \
  transmission \
  visual-studio-code \
  vlc


"$brewpath" install \
  chruby \
  ripgrep \
  ruby-install \
  yarn

./link.rb
git submodule update --init

# Hide recent applications from the dock
defaults write com.apple.dock show-recents -bool false; killall Dock

# Enable repeating keys instead of using hold for accents
defaults write -g ApplePressAndHoldEnabled -bool false
