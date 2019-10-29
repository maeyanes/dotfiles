#!/usr/bin/env bash

main()
{
	#configure_plist_apps # Configure all apps whose configurations are plists
	configure_numi
	configure_iterm2
	configure_system
	configure_dock
	configure_finder
}

#function configure_plist_apps()
#{
#	# Nothing to do, for now
#}

function configure_numi()
{
	quit "Numi"
	# Enable show in menu bar
	defaults write com.dmitrynikolaev.numi menuBarMode -int 1
	# Enable alfred integration
	defaults write com.dmitrynikolaev.numi alfredIntegration -int 1
	# To disable welcome tours
	defaults write com.dmitrynikolaev.numi hasLaunchedBefore -int 1
	open "Numi"
}

function configure_iterm2()
{
	defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -int 1
	defaults write com.googlecode.iterm2 PrefsCustomFolder -string ~/.system-config/iTerm2
}

function configure_system()
{
	# Disable Gatekeeper for getting rid of unknown developers error
	sudo spctl --master-disable
	# Configure keyboard repeat https://apple.stackexchange.com/a/83923/200178
	defaults write -g InitialKeyRepeat -int 15
    defaults write -g KeyRepeat -int 2
    # Make Crash Reporter appear as a notification
    defaults write com.apple.CrashReporter UseUNC 1
    # Disable "Correct spelling automatically"
    defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
    # Always show the Detailed Print Dialog in macOS
    defaults write -g PMPrintingExpandedStateForPrint -bool true
    # Enable full keyboard access for all controls which enables Tab selection in modal dialogs
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    # Show the ~/Library folder
	chflags nohidden ~/Library
}

function configure_dock()
{
	quit "Dock"
	# Don't show recent applications in Dock
	defaults write com.apple.dock show-recents -bool false
	# Set the icon size of Dock items to 60 pixels
    defaults write com.apple.dock tilesize -int 60
    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true
    # Don’t show Dashboard as a Space
    defaults write com.apple.dock dashboard-in-overlay -bool true
    # Activate magification
    defaults write com.apple.dock magnification -int 1
    # Set the icon large size of Dock Items to 128 pixeles
    defaults write com.apple.dock largesize -float 128
    # Highlight hidden apps
    defaults write com.apple.dock showhidden -bool yes
    # Enable the "suck" effect minimizing windows
    defaults write com.apple.dock mineffect -string suck

    ## Hot corners
    ## Possible values:
    ##  0: no-op
    ##  2: Mission Control
    ##  3: Show application windows
    ##  4: Desktop
    ##  5: Start screen saver
    ##  6: Disable screen saver
    ##  7: Dashboard
    ## 10: Put display to sleep
    ## 11: Launchpad
    ## 12: Notification Center
    ## Top left screen corner → Mission Control
    defaults write com.apple.dock wvous-tl-corner -int 0
    defaults write com.apple.dock wvous-tl-modifier -int 0
    ## Top right screen corner → Nothing
    defaults write com.apple.dock wvous-tr-corner -int 12
    defaults write com.apple.dock wvous-tr-modifier -int 0
    ## Bottom left screen corner → Nothing
    defaults write com.apple.dock wvous-bl-corner -int 0
    defaults write com.apple.dock wvous-bl-modifier -int 0

    #open "Dock"
}

function configure_finder()
{
	# Save screenshots to Pircutre/Screenshots folder
	if test ! -d ~/Pictures/Screenshots; then
		mkdir -p ~/Pictures/Screenshots
	fi
    defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"
    # Keep folders on top when sorting by name
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    # Set Downloads as the default location for new Finder windows
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    defaults write com.apple.finder NewWindowTargetPath -string \
        "file://${HOME}/Downloads/"
    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    # disable status bar
    defaults write com.apple.finder ShowStatusBar -bool false
    # disable path bar
    defaults write com.apple.finder ShowPathbar -bool false
    # Disable disk image verification
    defaults write com.apple.frameworks.diskimages \
        skip-verify -bool true
    defaults write com.apple.frameworks.diskimages \
        skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages \
        skip-verify-remote -bool true
    # Use list view in all Finder windows by default
    # Four-letter codes for view modes: icnv, clmv, Flwv, Nlsv
    defaults write com.apple.finder FXPreferredViewStyle -string clmv
    # Disable the warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false
}

function quit()
{
	app=$1
	killall "$app" > /dev/null 2>&1
}

function open()
{
	app=$1
	osascript > /dev/null << EOM
tell application "$app" to activate
tell application "System Events" to tell process "iTerm2"
    set fromtmost to true
end tell
EOM
}

function import_plist()
{
	domain=$1
	filename=$2
	defaults delete "$domain" $> /dev/null
	defaults import "$domain" "$filename"
}

main "$@"