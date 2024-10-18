function fdir --wraps=cd --description 'cd into directory with with interactive fzf'
    set fzf_query $(fzf --walker=dir --walker-root=$HOME -q$argv)
    if test -n "$fzf_query"
        cd $fzf_query
    else
        set_color red
        echo "❌ Query Canceled"
        set_color normal
    end
end
