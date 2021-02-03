# Setup Homebrew
which -s brew

if [[ $? != 0 ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  brew update
fi

# Setup XCode
xcode-select -p 1>/dev/null;
if [[ $? != 0 ]]; then
  xcode-select --install
fi

# Install Casks
/usr/local/bin/brew install --cask \
  1password \
  adafruit-arduino \
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
  sequel-pro \
  signal \
  steam \
  transmission \
  vlc


/usr/local/bin/brew install \
  chruby \
  ruby-install

./link.rb
git submodule update --init
