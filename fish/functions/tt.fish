function tt
    # This command is sent to a new shell when iTerm launches
    clear

    # Kill all background jobs
    jobs -p | xargs kill

    # Send signals to macOS to prevent sleep
    caffeinate -d &

    # Load tmux session
    if tmux new-session -s base -n base
        return
    else
        tmux attach-session -t base
    end
end