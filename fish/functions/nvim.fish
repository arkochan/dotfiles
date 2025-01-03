function nvim --description 'alias nvim nvim'

    # Define the history file
    set history_file ~/.nvim_history
    set nvim_bin $(which nvim)

    # Check if the first argument is a directory
    if test -n "$argv[1]"
        if test -d "$argv[1]"
            # If it's a directory, store its absolute path
            echo (realpath $argv[1]) >>$history_file
        else
            # Otherwise, store the current working directory
            echo (pwd) >>$history_file
        end
        $nvim_bin $argv
    else
        #put the last line of history file in a variable
        set last_line (tail -n 1 $history_file)
        $nvim_bin $last_line
    end
end
