#!/bin/bash

# make sure we're updated
brew update
brew install brew-cask
brew upgrade brew-cask
brew tap caskroom/cask
brew tap caskroom/versions

# install brew stuff
brew install autojump
brew install bash
brew install coreutils
brew install cowsay
brew install doxygen
brew install ec2-api-tools
brew install findutils
brew install gawk
brew install gs imagemagick
brew install hg
brew install mobile-shell
brew install p7zip
brew install st
brew install svn
brew install tree
brew install wireshark
brew install xpdf

# install casks
brew cask install adium
brew cask install android-file-transfer
brew cask install day-o
brew cask install dropbox
brew cask install firefox
brew cask install github-desktop
brew cask install google-chrome
brew cask install iterm2
brew cask install java
brew cask install kindle
brew cask install ksdiff
brew cask install lastpass-universal
brew cask install macvim
brew cask install multibit
brew cask install openemu-experimental
brew cask install playonmac
brew cask install rstudio
brew cask install seashore
brew cask install silverlight
brew cask install sizeup
brew cask install skype
brew cask install spotify
brew cask install steam
brew cask install the-unarchiver
brew cask install transmission
brew cask install vlc
brew cask install witch
brew cask install xquartz

# must be after x-quartz
brew tap homebrew/science
brew install gfortran R
