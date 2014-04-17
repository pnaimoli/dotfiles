#!/bin/bash

# make sure we're updated
brew update
brew tap phinze/homebrew-cask
brew install brew-cask
brew upgrade brew-cask

# install brew stuff
brew install macvim
brew install mobile-shell
#brew upgrade --HEAD mobile-shell
brew install autojump
brew install gawk
brew install bash
brew install wireshark
brew install doxygen
brew install svn
brew install cowsay
brew install gs imagemagick
brew install p7zip
brew install coreutils
#brew install tuntap
#brew install reattach-to-user-namespace
brew install hg
brew install xpdf

# install casks
brew cask install adium
brew cask install day-o
brew cask install dropbox
brew cask install firefox
brew cask install github
brew cask install google-chrome
brew cask install iterm2
brew cask install kindle
brew cask install ksdiff
brew cask install lastpass-universal
brew cask install multibit
brew cask install rstudio
brew cask install seashore
brew cask install silverlight
brew cask install sizeup
brew cask install steam
brew cask install transmission
brew cask install vlc
brew cask install witch
brew cask install xquartz
#brew cask install little-snitch
brew cask install nvalt
brew cask install android-file-transfer
brew cask install pycharm-ce

# must be after x-quartz
brew tap homebrew/science
brew install gfortran R

#find ~/Applications -type l -name MacVim.app | while read f; do osascript -e "tell app \"Finder\" to make new alias file at POSIX file \"/Applications\" to POSIX file \"$(stat -f%Y "$f")\""; rm $f; done
