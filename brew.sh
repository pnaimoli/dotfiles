#!/bin/bash

# Ensure we're using zsh (redundant on macOS 10.15+, but included for safety)
chsh -s /bin/zsh

# Suppress login message
touch .hushlogin

echo "Setting some Mac settings..."
# Disable diacritical marks on key long-press, enable key repeat
defaults write -g ApplePressAndHoldEnabled -bool false
# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Disable warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Avoid .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Enable snap-to-grid for icons on desktop and Finder views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
sudo killall Finder
# Hide Siri from menu bar
defaults write com.apple.Siri StatusMenuVisible -bool false

# Make the dock hidden and on the left
defaults write com.apple.dock orientation left
defaults write com.apple.dock autohide -bool true
killall Dock

# Install Xcode CLI tools
echo "Installing Xcode CLI tools..."
xcode-select --install
sudo xcodebuild -license accept

# Install Rosetta (for Apple Silicon Macs)
sudo softwareupdate --install-rosetta --agree-to-license

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update
brew tap pnaimoli/homebrew-personal

# Install Homebrew packages
brew install autojump       # Navigate directories faster
brew install bash           # GNU Bourne Again Shell
brew install boost          # C++ libraries for performance
brew install bsdiff         # Binary diff/patch utility
brew install cfr-decompiler # Java decompiler
brew install cmake          # Cross-platform build system
brew install coreutils      # GNU core utilities
brew install csvkit         # Tools for working with CSV files
brew install docutils       # Python documentation utilities
brew install dvdbackup      # Backup DVDs to disk
brew install exiftool       # Metadata reader and editor
brew install exiv2          # Image metadata manipulation tool
brew install ffmpeg         # Play, record, convert, and stream audio and video
brew install findutils      # GNU find, locate, updatedb, xargs
brew install gawk           # GNU awk programming language
brew install gh             # GitHub CLI
brew install git            # Version control system
brew install grep           # GNU grep, better than macOS version
brew install imagemagick    # Image manipulation tools
brew install lftp           # Sophisticated file transfer program
brew install lsusb          # USB device listing
brew install macvim         # Vim with macOS enhancements
brew install mosh           # Mobile shell replacement for SSH
brew install nmap           # Network scanner
brew install node           # JavaScript runtime
brew install offlineimap    # IMAP synchronization tool
brew install p7zip          # 7-Zip command-line tool
brew install procs          # Modern replacement for ps
brew install sphinx-doc     # Python documentation generator
brew install st             # statistics from the command line
brew install telnet         # Classic Telnet client
brew install tidy-html5     # HTML, XML, and XHTML validator
brew install tree           # Display directories as trees
brew install vim            # Vi Improved text editor, +clipboard is nice
brew install wget           # Retrieve files from the web
brew install wget2          # Improved version of wget
brew install xpdf           # PDF viewer and utilities, like pdftotext, etc...
brew install yt-dlp         # YouTube and media downloader

# Install Homebrew Casks
brew install alt-tab                # Better version of Witch3 for window management
brew install android-platform-tools # ADB (Android Debug Bridge) tools
brew install blackhole-2ch          # Virtual audio driver to capture sound
brew install calibre                # E-book reader and library manager
brew install crossover              # Tool to run Windows software on macOS
brew install diffusionbee           # AI-powered image generation tool
brew install discord                # Chat and voice communication app
brew install dropbox                # Cloud storage and file synchronization
brew install firefox                # Web browser
brew install github                 # GitHub CLI tool
brew install google-chrome          # Web browser
brew install hammerspoon            # Automation tool for macOS
brew install iina                   # Modern macOS video player
brew install iterm2                 # Advanced terminal emulator for macOS
brew install java                   # Java runtime environment
brew install karabiner-elements     # Powerful keyboard customizer for macOS
brew install keyboardcleantool      # Temporarily disable keyboard for cleaning
brew install ksdiff                 # File comparison tool
brew install mactex                 # TeX distribution for macOS
brew install macvim                 # macOS-specific version of Vim
brew install microsoft-teams        # Microsoft collaboration and chat app
brew install mullvadvpn             # Privacy-focused VPN service
brew install musescore              # Open-source music notation software
brew install musicbrainz-picard     # Music tagger using MusicBrainz database
brew install openemu                # Multi-console emulator for macOS
brew install oversight              # Alerts you when the microphone or camera is accessed
brew install qbittorrent            # Open-source BitTorrent client
brew install qflipper               # Utility for managing Flipper Zero devices
brew install rcdefaultapp           # Tool for changing default app handlers like ssh://
brew install rectangle              # Window management tool
brew install rstudio                # IDE for R programming
brew install sizeup                 # Window management tool
brew install spotify                # Music streaming service
brew install steam                  # Gaming platform
brew install sublime-text           # Text editor
brew install synthesia              # Piano learning software
brew install the-unarchiver         # Archive extraction tool
brew install vlc                    # Open-source media player
brew install wireshark              # Network packet analyzer
brew install xquartz                # X11 windowing system for macOS
brew install yacreader              # Comic and manga reader
brew install zoom                   # Video conferencing app

defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

# Must be after XQuartz
brew install gcc r

# Clean up Homebrew installations
echo "Cleaning up Brew..."
brew cleanup
