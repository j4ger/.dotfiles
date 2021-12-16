# greet with uptime
echo `uptime`

# history config
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory

# fzf
path+=("$USER_HOME/.fzf/bin")
export PATH
export FZF_DEFAULT_COMMAND="fd --type f"
