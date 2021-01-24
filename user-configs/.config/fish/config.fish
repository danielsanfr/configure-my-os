set _SILENT_JAVA_OPTIONS "$_JAVA_OPTIONS"
set -e _JAVA_OPTIONS
alias java="java $_SILENT_JAVA_OPTIONS"

set ANDROID_SDK_ROOT ~/.local/sdks/android/
set ANDROID_HOME $ANDROID_SDK_ROOT
set PATH $ANDROID_HOME/platform-tools/ $PATH
set PATH $ANDROID_HOME/tools/ $PATH
set PATH $ANDROID_HOME/cmdline-tools/tools/bin/ $PATH
set PATH $ANDROID_HOME/cmdline-tools/latest/bin/ $PATH

set PATH ~/.gem/ruby/2.7.0/bin/ $PATH

set PATH_TO_FX ~/.local/sdks/javafx/11/lib/

# Spacefish
set SPACEFISH_TIME_SHOW true

alias ls "lsd"

thefuck --alias | source

set -x PAGER "less -RF"
set -x BAT_PAGER "less -RF"

set -x GPG_TTY (tty)
