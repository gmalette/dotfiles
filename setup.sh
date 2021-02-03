# Setup Homebrew
which -s brew
if [[ $? != 0 ]] ; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  brew update
fi

xcode-select --install

# Install Casks
/opt/homebrew/bin/brew install --cask \
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
