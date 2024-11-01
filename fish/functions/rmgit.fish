function rmgit --wraps='rm -rf * git' --wraps='rm -rf .git' --description 'alias rmgit rm -rf .git'
  rm -rf .git $argv
        
end
