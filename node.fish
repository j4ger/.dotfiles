# yarn path
set -Ua PATH $USER_HOME/.yarn/bin

# deno setup
set -gx DENO_INSTALL $USER_HOME/.deno
set -Ua PATH $DENO_INSTALL/bin
