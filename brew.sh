#!/bin/bash

chsh -s /bin/zsh
touch .hushlogin

echo "Setting some Mac settings..."
# Disable diacritical marks on key long-press, enable key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
# Showing all filename extensions in Finder by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Disabling the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Avoiding the creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Enabling snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
# Don't show Siri in the menu bar
defaults write com.apple.Siri StatusMenuVisible -bool false

# Make the dock hidden and on the left
defaults write com.apple.dock orientation left
defaults write com.apple.dock autohide -bool true
killall Dock

# Change Touch Bar control strip actions
defaults write com.apple.controlstrip '{ MiniCustomized = (
  "com.apple.system.volume",
  "com.apple.system.mute",
  "com.apple.system.brightness",
  "com.apple.system.show-desktop"
 ); }'
killall ControlStrip

# Disable mouse acceleration - does this work??
defaults write .GlobalPreferences com.apple.mouse.scaling -1
defaults write .GlobalPreferences com.apple.trackpad.scaling -1

# this has to happen before gcc
echo "Installing xcode-stuff..."
xcode-select --install

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Updating homebrew..."
brew update
brew tap caskroom/versions
brew tap pnaimoli/homebrew-personal

# install brew stuff
brew install autojump
brew install bash
brew install coreutils
brew install findutils
brew install gawk
brew install gcc
brew install git
brew install gs imagemagick
brew install hg # mercurial
brew install mobile-shell # mosh
brew install p7zip
brew install st # statistics from the command line
brew install vim # +clipboard is nice
brew install xpdf

# install casks
brew cask install adium
#brew cask install copay #cask doesn't exist
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
brew cask install multipatch # snes ips patcher
brew cask install rcdefaultapp # for changing ssh:// etc... handlers

# must be after x-quartz
brew install gcc r

echo "Cleaning up brew"
brew cask cleanup
brew cleanup
brew prune
