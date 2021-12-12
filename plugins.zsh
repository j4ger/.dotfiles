# configure ice for loading time optimizations
zinit ice pick'poetry.zsh'
zinit light sudosubin/zsh-poetry
zinit light zsh-users/zsh-completions
zinit ice lucid nocompile
zinit light ryutok/rust-zsh-completions
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit light matthieusb/zsh-sdkman
zpcompinit
path+=("$USER_HOME/.fzf/bin")
export PATH
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

