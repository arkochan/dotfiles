function nf --wraps='nvim yay/src/yay-12.3.5/query.go' --description 'alias nf nvim yay/src/yay-12.3.5/query.go'
    nvim $(fzf) $argv

end
