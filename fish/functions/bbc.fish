function bbc
	set --local TAP ~/.system-config/brew/Brewfile_tap
	set --local BREW ~/.system-config/brew/Brewfile_brew
	set --local CASK ~/.system-config/brew/Brewfile_cask
	set --local MAS ~/.system-config/brew/Brewfile_mas

	cat $TAP $BREW $CASK $MAS > $BREWFILE
    brew bundle cleanup --file=$BREWFILE --force
end