function nvim --description 'alias nvim nvim'

    # Define the history file
    set history_file ~/.nvim_history

    # Check if the first argument is a directory
    if test -n "$argv[1]" -a -d "$argv[1]"
        # If it's a directory, store its absolute path
        echo (realpath $argv[1]) >>$history_file
    else
        # Otherwise, store the current working directory
        echo (pwd) >>$history_file
    end
    /sbin/nvim $argv
end
