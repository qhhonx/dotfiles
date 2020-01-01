# locale
export LC_ALL="en_US.UTF-8"
export LANG="zh_CN.UTF-8"

# tmux
status is-interactive
and not set -q TMUX
and exec tmux
