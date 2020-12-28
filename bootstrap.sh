#!/usr/bin/env bash

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# meta

function is_darwin() {
    if [[ $(uname -s | awk '{print tolower($0)}') == darwin* ]]; then
        return 0
    else
        return 1
    fi
}

function install_brew() {
    if is_darwin && ! which brew >/dev/null; then
        printf "\nInstalling brew ...\n"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
}

function brew_install() {
    for tool in "$@"; do
        if is_darwin && ! which $tool >/dev/null; then
            printf "\nInstalling $tool ...\n"
            HOMEBREW_NO_AUTO_UPDATE=1 $(which brew) install $tool
        fi
    done
}

function brew_cask_install() {
    for item in "$@"; do
        set -- $item
        formula=""
        if [ $# -ne 1 ]; then
            formula=$1
        fi
        is_darwin && [ ! -z $formula ] && HOMEBREW_NO_AUTO_UPDATE=1 $(which brew) tap $formula
        for tool in "$@"; do
            if is_darwin && [ "$tool" != "$formula" ] && ! $(which brew) list --cask | grep $tool >/dev/null; then
                printf "\nInstalling $tool ...\n"
                HOMEBREW_NO_AUTO_UPDATE=1 $(which brew) cask install $tool
            fi
        done
    done
}

function aptget_install() {
    for tool in "$@"; do
        if ! is_darwin && ! which $tool >/dev/null; then
            printf "\nInstalling $tool ...\n"
            sudo $(which apt-get) install $tool
        fi
    done
}

function setup_meta() {
    install_brew
}

# terminal & shell

function set_default_shell() {
    for shell in "$@"; do
        if ! grep -q $(which $shell) /etc/shells; then
            printf "\nSetting $(which $shell) to default shell ...\n"
            echo $(which $shell) | sudo tee -a /etc/shells
            chsh -s $(which $shell)
        else
            if [[ $SHELL != $(which $shell) ]]; then
                printf "\nSetting $(which $shell) to default shell ...\n"
                chsh -s $(which $shell)
            fi
        fi
    done
}

function setup_terminal() {
    brew_cask_install \
        alfred appgrid clean-me hyper istat-menus visual-studio-code alacritty \
        "homebrew/cask-fonts font-inconsolata font-jetbrains-mono"
    brew_install fish tmux
    aptget_install fish tmux
    # set_default_shell fish
}

# awesome dotfiles

function install_ohmyzsh() {
    if [ ! -d ~/.oh-my-zsh ]; then
        printf "\nInstalling .oh-my-zsh ...\n"
        curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
    fi
}

function install_ohmyfish() {
    if [ ! -d ~/.local/share/omf ]; then
        printf "\nInstalling .oh-my-fish ...\n"
        TMPFILE=$(mktemp)
        curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install >$TMPFILE
        $(which fish) $TMPFILE --noninteractive --yes
        rm $TMPFILE
    fi
}

function install_vimrc() {
    if [ ! -d ~/.vim_runtime ]; then
        printf "\nInstalling .vimrc ...\n"
        git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
        sh ~/.vim_runtime/install_awesome_vimrc.sh
    else
        printf "\nUpdating .vimrc ...\n"
        git -C ~/.vim_runtime pull --rebase --autostash
    fi
    if ! pip3 list | grep requests >/dev/null; then
        sudo -H pip3 install requests
    fi
    python3 ~/.vim_runtime/update_plugins.py
    python3 .vim_runtime/my_plugins/update_plugins.py
}

function install_dottmux() {
    if [ ! -d ~/.tmux ]; then
        printf "\nInstalling .tmux ...\n"
        git clone --depth=1 https://github.com/gpakosz/.tmux.git ~/.tmux
    else
        printf "\nUpdating .tmux ...\n"
        git -C ~/.tmux pull --rebase --autostash
    fi
    ln -svf ~/.tmux/.tmux.conf ~/.tmux.conf
}

function setup_dotfiles() {
    # install_ohmyzsh
    install_ohmyfish
    install_vimrc
    install_dottmux
}

# cli

function setup_cli_tools() {
    brew_install autojump tldr rg fd fzf tig
}

# pre_install

function pre_install() {
    setups=(
        setup_meta
        setup_terminal
        setup_dotfiles
        setup_cli_tools
    )
    for setup in "${setups[@]}"; do
        $(expr $setup)
    done
}

# install dotfiles

EXCLUDE_PATTERNS=(".git/" ".DS_Store" "bootstrap.sh" "README.md" "LICENSE")

function update_dotfiles() {
    printf "\nUpdating .dotfiles in $DIR ...\n"
    git -C "$DIR" pull --rebase --autostash
}

function sync_dotfiles() {
    printf "\nSyncing dotfiles ...\n"
    rsync $(printf "%s\n" "${EXCLUDE_PATTERNS[@]}" | sed 's/^/--exclude=/g') -avhR --no-perms . ~
}

function link_dotfiles() {
    printf "\nLinking dotfiles ...\n"
    find . -type f $(printf "*/%s*\n" "${EXCLUDE_PATTERNS[@]}" | sed 's/^/-not -iwholename /g') -exec ln -f ~/'{}' '{}' ';'
}

function install() {
    update_dotfiles
    sync_dotfiles
    link_dotfiles
}

# post_install

function vim_plug_install {
    vim +PlugInstall +qall
}

function post_install() {
    vim_plug_install
}

function bootstrap() {
    pre_install
    install
    post_install
}

# usage

# https://sookocheff.com/post/bash/parsing-bash-script-arguments-with-shopts/
while getopts ":fs" opt; do
    case ${opt} in
        f) # force to bootstrap
            bootstrap
            exit 1
            ;;
        s) # skip to pre_install/post_instll
            install
            exit 1
            ;;
        \?) echo "Usage: ./bootstrap.sh [-f] [-s]"
            exit 0
            ;;
    esac
done

shift $((OPTIND -1))

read -p "This may overwrites existing files in your home directory. Are you sure? (y/n) " -n 1
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bootstrap
fi
