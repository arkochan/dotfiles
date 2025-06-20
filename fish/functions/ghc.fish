function ghc
    # Hide cursor
    tput civis
    
    # Run the command in background and capture its PID
    fish -c "printf '\n' | gh copilot suggest --target shell $argv | grep -A1 'Suggestion:' | tail -1" &
    set command_pid $last_pid
    
    # Start spinner that monitors the command PID
    spinner $command_pid &
    set spinner_pid $last_pid
    
    # Wait for the command to complete and get its output
    wait $command_pid 2>/dev/null
    set exit_code $status
    
    # Stop the spinner
    kill $spinner_pid 2>/dev/null
    # wait $spinner_pid 2>/dev/null
    
    # Show cursor again and clear spinner line
    tput cnorm
    # printf "\r\033[K"
    
    # Get the result now that command is done
    if test $exit_code -eq 0
        # Clear everything printed since last input
        printf "\r\033[K\033[1A\r\033[K"
        commandline (wl-paste)
    else
        printf "\r\033[K"
        echo "✗ Command failed"
    end
end

function spinner
    set target_pid $argv[1]
    set chars "⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏"
    set i 1

    # Keep spinning while the target process is running
    while kill -0 $target_pid 2>/dev/null
        printf "\r🤖 Generating command... %s" $chars[$i]
        sleep 0.1
        set i (math "$i % 10 + 1")
    end
    printf "\r\033[K\033[1A\r\033[K"
end
