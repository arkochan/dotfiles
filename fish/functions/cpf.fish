function copy_to_clipboard --description 'Copy file contents to clipboard'
    # Check if a file name is provided
    if test -z "$argv[1]"
        echo "Error: No file name provided."
        return 1
    end

    # Check if the file exists
    if not test -f "$argv[1]"
        echo "Error: File does not exist."
        return 1
    end

    # Determine the clipboard tool
    if test -n (which wl-copy)
        cat $argv[1] | wl-copy
        echo "File contents copied to clipboard using wl-copy."
    else if test -n (which xclip)
        cat $argv[1] | xclip -selection clipboard
        echo "File contents copied to clipboard using xclip."
    else if test -n (which xsel)
        cat $argv[1] | xsel --clipboard --input
        echo "File contents copied to clipboard using xsel."
    else
        echo "Error: No clipboard tool found (wl-copy, xclip, or xsel)."
        return 1
    end
end
