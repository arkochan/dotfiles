function fdir --wraps=cd --description 'cd into directory with with interactive fzf'
    # searches for type dir type links include Hidden .
    set fzf_query $(fd -t d -t l -H . $HOME | fzf -q$argv)

    if test -n "$fzf_query"
        cd $fzf_query
    else
        set_color red
        echo "❌ Query Canceled"
        set_color normal
    end
end
