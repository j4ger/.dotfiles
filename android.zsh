# start socat
source ~/.dotfiles/socat.zsh
export ADB_SERVER_SOCKET="tcp:$windows_host:5037"

# Android SDK path
export ANDROID_SDK_ROOT=/usr/local/bin/AndroidSDK
export ANDROID_HOME=$ANDROID_SDK_ROOT/cmdline-tools/tools
path+=("$ANDROID_HOME/bin")
path+=("$ANDROID_SDK_ROOT/platform-tools")

# flutter path
path+=("$ANDROID_SDK_ROOT/flutter/bin")

# Android Studio alias
alias astudio='/usr/local/bin/AndroidSDK/android-studio/bin/studio.sh'

# Apktool path
path+=("$USER_HOME/dev/Apktool")

# Android OS development
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'

export PATH