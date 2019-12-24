#!/usr/bin/env bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function update_dotfiles() {
    printf "\nUpdating .dotfiles in $DIR ...\n"
    git -C "$DIR" pull --rebase --autostash
}

function install_brew() {
    if ! which brew >/dev/null; then
        printf "\nInstalling brew ...\n"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
}

function install_ohmyzsh() {
    if [ ! -d ~/.oh-my-zsh ]; then
        printf "\nInstalling .oh-my-zsh ...\n"
        curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
    fi
}

function install_fish() {
    if ! which fish >/dev/null; then
        printf "\nInstalling fish ...\n"
        $(which brew) install fish
    fi
}

function install_ohmyfish() {
    if [ ! -d "$OMF_PATH" ]; then
        printf "\nInstalling .oh-my-fish ...\n"
        curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | $(which fish)
    fi
}

function install_vimrc() {
    if [ ! -d ~/.vim_runtime ]; then
        printf "\nInstalling .vimrc ...\n"
        git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
        sh ~/.vim_runtime/install_awesome_vimrc.sh
    else
        printf "\nUpdating .vimrc ...\n"
        git -C ~/.vim_runtime pull --rebase
    fi
}

function install_tmux() {
    if [ ! -d ~/.tmux ]; then
        printf "\nInstalling .tmux ...\n"
        git clone --depth=1 https://github.com/gpakosz/.tmux.git ~/.tmux
    else
        printf "\nUpdating .tmux ...\n"
        git -C ~/.tmux pull --rebase
    fi
    ln -svf ~/.tmux/.tmux.conf ~/.tmux.conf
}

function pre_installs() {
    installs=(
        update_dotfiles
        install_ohmyzsh
        install_fish
        install_ohmyfish
        install_vimrc
        install_tmux
    )
    for install in "${installs[@]}"; do
        $(expr $install)
    done
}

EXCLUDE_PATTERNS=(".git/" ".DS_Store" "bootstrap.sh" "README.md" "LICENSE")

function sync_dotfiles() {
    printf "\nSyncing dotfiles ...\n"
    rsync $(printf "%s\n" "${EXCLUDE_PATTERNS[@]}" | sed 's/^/--exclude=/g') -avhR --no-perms . ~
}

function link_dotfiles() {
    printf "\nLinking dotfiles ...\n"
    find . -type f $(printf "*/%s*\n" "${EXCLUDE_PATTERNS[@]}" | sed 's/^/-not -iwholename /g') -exec ln -vf ~/'{}' '{}' ';'
}

function bootstrap() {
    pre_installs
    sync_dotfiles
    link_dotfiles
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    bootstrap
else
    read -p "This may overwrites existing files in your home directory. Are you sure? (y/n) " -n 1
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bootstrap
    fi
fi
unset bootstrap
