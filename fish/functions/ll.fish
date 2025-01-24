function ll --wraps=ls --wraps='lsd --blocks name --blocks size' --description 'alias ll lsd --blocks name --blocks size'
    lsd --blocks name --blocks size --blocks date $argv

end
