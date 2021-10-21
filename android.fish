# start socat
source ~/.dotfiles/socat.fish
set -gx ADB_SERVER_SOCKET "tcp:$windows_host:5037"

# Android SDK path
set -gx ANDROID_SDK_ROOT /usr/local/bin/AndroidSDK
set -gx ANDROID_HOME $ANDROID_SDK_ROOT/cmdline-tools/tools
set -ga PATH $ANDROID_HOME/bin $ANDROID_SDK_ROOT/platform-tools

# flutter path
set -ga PATH $ANDROID_SDK_ROOT/flutter/bin

# Android Studio alias
alias astudio='/usr/local/bin/AndroidSDK/android-studio/bin/studio.sh'

# Apktool path
set -ga PATH $USER_HOME/dev/Apktool

# Android OS development
set -gx USE_CCACHE 1
set -gx CCACHE_EXEC /usr/bin/ccache
set -gx REPO_URL 'https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'
