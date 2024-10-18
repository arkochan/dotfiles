function fnvim --wraps=nvim --description 'start nvim from fzf selection'
    set fzf_query $(fzf --walker=dir --walker-root=$HOME -q$argv)
    if test -n "$fzf_query"
        nvim $fzf_query
    else
        set_color red
        echo "❌ Query Canceled"
        set_color normal
    end
end
