#!/bin/bash
# install brew stuff
brew install macvim
brew install mosh
brew install autojump
brew install gawk
brew install bash
brew install wireshark
brew install doxygen

brew tap phinze/homebrew-cask
brew install brew-cask

# install casks
brew cask install google-chrome
brew cask install adium
brew cask install size-up
#brew cask install silverlight
brew cask install dropbox
brew cask install steam
brew cask install vlc
brew cask install transmission
brew cask install seashore
brew cask install rstudio
brew cask install kindle
brew cask install firefox
#brew cask install little-snitch
brew cask install lastpass-universal
brew cask install iterm2
brew cask install ksdiff
brew cask install github
brew cask install multibit
#brew cask install witch
brew cask install x-quartz

# must be after x-quartz
brew tap homebrew/science
brew install gfortran R
