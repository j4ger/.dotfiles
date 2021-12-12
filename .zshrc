local default_user="j4ger"
local default_machine="v04-blade15"
local USER_HOME=~
local windows_user="v04-local"

# separate config files
source ~/.dotfiles/proxy.zsh
source ~/.dotfiles/android.zsh
source ~/.dotfiles/node.zsh
source ~/.dotfiles/rust.zsh
source ~/.dotfiles/python.zsh
source ~/.dotfiles/aliases.zsh
source ~/.dotfiles/customizations.zsh
source ~/.dotfiles/x-server.zsh
source ~/.dotfiles/vscode.zsh
source ~/.dotfiles/zinit.zsh

# Starship prompt
eval "$(starship init zsh)"

source ~/.dotfiles/plugins.zsh
