# configure ice for loading time optimizations
zinit ice lucid wait='1'
zinit light skywind3000/z.lua

zinit ice lucid wait='2'
zinit light changyuheng/fz

export FZ_HISTORY_CD_CMD=_zlua

zinit ice lucid wait='0'
zinit light Aloxaf/fzf-tab

zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

zinit ice lucid wait='0' pick'poetry.zsh'
zinit light sudosubin/zsh-poetry

zinit ice lucid wait='0' nocompile
zinit light ryutok/rust-zsh-completions

zinit ice lucid wait='0' as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zinit light matthieusb/zsh-sdkman

zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

zpcompinit
