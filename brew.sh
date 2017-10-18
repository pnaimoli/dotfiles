#!/bin/bash

# make sure we're updated
brew update
brew tap caskroom/versions
brew tap pnaiomli/homebrew-personal

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
brew install node
brew install p7zip
brew install st
brew install svn
brew install tree
brew install wireshark
brew install xpdf

# install casks
brew cask install adium
brew cask install day-o
brew cask install discord
brew cask install dropbox
brew cask install firefox
brew cask install github-desktop
brew cask install google-chrome
brew cask install iterm2
brew cask install java
brew cask install kindle
brew cask install ksdiff
brew cask install lastpass
brew cask install macvim
#brew cask install multibit #broken atm
brew cask install openemu-experimental
brew cask install playonmac
brew cask install rstudio
#brew cask install silverlight #doesn't work with chrome
brew cask install sizeup
brew cask install skype
brew cask install spotify
brew cask install steam
brew cask install the-unarchiver
brew cask install transmission
brew cask install vlc
brew cask install witch3
brew cask install xquartz
brew cask install docker
brew cask install google-cloud-sdk
brew cask install multipatch # snes ips patcher
brew cask install rcdefaultapp # for changing ssh:// etc... handlers

# must be after x-quartz
brew tap homebrew/science
brew install gcc r
