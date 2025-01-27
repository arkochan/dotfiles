function cdf --description '(cd fast) cd into directory with with fuzzy argumentg'

    set fzf_query (fd -t d -t l -H . $HOME | fzf -f $argv | head -1)
    if test -n "$fzf_query"
        cd $fzf_query
    else
        set_color red
        echo "❌ No Results"
        set_color normal
    end
end
