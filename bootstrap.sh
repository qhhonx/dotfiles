#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE}")";

function install_dotfiles() {
    printf "\nUpdating .dotfiles in $(pwd) ...\n";
    git pull origin master;
}

function install_ohmyzsh() {
    if [ ! -d "${HOME}/.oh-my-zsh" ]; then
        printf "\nInstalling .oh-my-zsh ...\n";
        curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh;
    fi;
}

function install_vimrc() {
    if ! (cd ~/.vim_runtime && \
          printf "\nUpdating .vimrc in $(pwd) ...\n" && \
          git pull --rebase) then
        printf "\nInstalling .vimrc ...\n";
        git clone https://github.com/amix/vimrc.git ~/.vim_runtime;
        sh ~/.vim_runtime/install_awesome_vimrc.sh;
    fi;
}

function pre_installs() {
    installs=( install_dotfiles install_ohmyzsh install_vimrc )
    for install in "${installs[@]}" 
    do
        $(expr $install);
    done
}

excludes=(".git/" ".DS_Store" "bootstrap.sh" "README.md" "LICENSE");

function sync_dotfiles() {
    printf "\nSyncing dotfiles ...\n";
    rsync $(printf "%s\n" "${excludes[@]}" | sed 's/^/--exclude=/g') -avhR --no-perms . ~;
}

function link_dotfiles() {
    printf "\nLinking dotfiles ...\n"
    find . -type f $(printf "*/%s*\n" "${excludes[@]}" | sed 's/^/-not -iwholename /g') -exec ln -vf ~/'{}' '{}' ';';
}

function bootstrap() {
    pre_installs;
    sync_dotfiles;
    link_dotfiles;
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    bootstrap;
else
    read -p "This may overwrites existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        bootstrap;
    fi;
fi;
unset bootstrap;
