function hnvim
    # Define the history file
    set history_file ~/.nvim_history

    # Ensure the history file exists
    if not test -f $history_file
        set_color red
        echo "❌ History file not found at $history_file"
        set_color normal
        return 1
    end


    # Pipe the unique directories into fzf
    set selected_dir (tac $history_file | awk '!seen[$0]++' | fzf --prompt="Select directory: " --height=20 --reverse )

    # Check if a directory was selected
    if test -n "$selected_dir"
        # Execute nvim with the selected directory
        cd $selected_dir
        nvim $selected_dir
    end
end
