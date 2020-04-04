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
