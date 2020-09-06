function glo --wraps "git log"
	c; and git log --oneline $argv
end