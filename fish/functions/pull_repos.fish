function pull_repos
	find ~/.system-config/ -type d -maxdepth 0 --exec git -C {} pull \;
end