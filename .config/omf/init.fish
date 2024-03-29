# autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish

# rust
set -xg RUSTPATH $HOME/.rust_workspace
set PATH $HOME/.cargo/bin $PATH

# golang
set -xg GOPATH $HOME/.go_workspace
set PATH $GOPATH/bin $PATH

# theme
set fish_pager_color_progress cyan

# homebrew M1
[ -f /opt/homebrew/bin/brew ]; and set PATH /opt/homebrew/bin $PATH
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# rbenv
status --is-interactive; and rbenv init - fish | source

# jdk
set -xg JAVA_HOME (/usr/libexec/java_home)
set PATH $JAVA_HOME $PATH

