function pull_repos
	find ~/.system-config/ -type d -maxdepth 1 --exec git -C {} pull \;
end