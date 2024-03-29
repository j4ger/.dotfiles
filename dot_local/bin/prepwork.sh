#!/bin/sh

# configure fzf to use fd
export FZF_DEFAULT_COMMAND="fd --type f"

# aliases
## navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

## utilities
alias cz="chezmoi"
alias ls='exa --icons --long --no-permissions --no-user'
alias cat="bat"
alias grep="rg"
alias lg="lazygit"
alias z="zoxide"
alias chmox="chmod +x"
alias gp="git push"
alias gf="git fetch"
alias gc="git commit -m"
alias ga="git add"
alias mkdir="mkdir -p"
alias g="git"
# neovide multigrid support
alias neovide="neovide --multigrid"
alias v="nvim ."
alias n="nvim"
alias vim="nvim"

export BROWSER=firefox
export EDITOR=helix
