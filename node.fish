# nvm configs
set -gx NVM_DIR "$HOME/.nvm"
function nvm
    bass source $NVM_DIR/nvm.sh ';' nvm $argv
end

# yarn path
set -Ua PATH $USER_HOME/.yarn/bin

# deno setup
set -gx DENO_INSTALL $USER_HOME/.deno
set -Ua PATH $DENO_INSTALL/bin
