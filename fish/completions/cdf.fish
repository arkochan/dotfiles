function __fish_cdf_complete --description 'Search for files with fd and preview with tab'
    set -l query (commandline -ct)
    set -l results $(fzf --walker=dir --walker-root=$HOME -f $query | head)
    for result in $results
        echo $result
    end
end

# Register the completion function for the `fd` command
complete --keep-order -c cdf -a "(__fish_cdf_complete)"
