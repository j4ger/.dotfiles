# cherry-picked from: https://github.com/paulirish/dotfiles/blob/master/fish/aliases.fish

# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end

# Utilities
function g        ; git $argv ; end
function grep     ; command grep --color=auto $argv ; end

abbr --add chmox "chmod +x"

abbr --add push "git push"

abbr --add plz "sudo"

abbr --add apu "sudo apt update"
abbr --add api "sudo apt install"