set -ga PATH $USER_HOME/.local/bin

abbr --add thefuck fuck
abbr --add wtf fuck

thefuck --alias | source
