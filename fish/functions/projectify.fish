function projectify --description 'Set up a tmux session for a project'

    # Get the directory name as session name
    set DIR_PATH (pwd)
    set SESSION_NAME (basename $DIR_PATH)

    # Start a new tmux session
    tmux new-session -d -s "$SESSION_NAME" -c "$DIR_PATH"

    # Pane 1: Run pnpm dev
    tmux new-window -t "$SESSION_NAME:1" -n pnpm-dev -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:1" "pnpm dev" Enter

    # Pane 2: Open nvim
    tmux new-window -t "$SESSION_NAME:2" -n nvim -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:2" "nvim ." Enter

    # Pane 3: Open lazygit
    tmux new-window -t "$SESSION_NAME:3" -n lazygit -c "$DIR_PATH"
    tmux send-keys -t "$SESSION_NAME:3" lazygit Enter

    # Attach to the session
    tmux attach-session -t "$SESSION_NAME"

end
