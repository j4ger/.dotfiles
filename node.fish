# yarn path
set -ga PATH $USER_HOME/.yarn/bin

# deno setup
set -gx DENO_INSTALL $USER_HOME/.deno
set -ga PATH $DENO_INSTALL/bin
