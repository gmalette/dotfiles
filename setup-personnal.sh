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
