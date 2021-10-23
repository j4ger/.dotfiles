# n version manager
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]]
path+=(":$N_PREFIX/bin")

# yarn path
path+=("$USER_HOME/.yarn/bin")

# deno setup
local DENO_INSTALL="$USER_HOME/.deno"
path+=("$DENO_INSTALL/bin")

export PATH