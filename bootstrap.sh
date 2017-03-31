#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE}")";

function install_dotfiles() {
    echo "Updating .dotfiles in `pwd` ...";
    git pull origin master;
}

function install_vimrc() {
    if ! (cd ~/.vim_runtime && \
          echo "Updating .vimrc in `pwd` ..." && \
          git pull --rebase) then
        echo "Installing .vimrc ...";
        git clone https://github.com/amix/vimrc.git ~/.vim_runtime;
        sh ~/.vim_runtime/install_awesome_vimrc.sh;
    fi;
}

function pre_installs() {
    installs=( install_dotfiles install_vimrc )
    for install in "${installs[@]}" 
    do
        echo "";
        `expr $install`;
    done
    echo ""
}

function bootstrap() {
    pre_installs;

    echo "Bootstraping ...";

    rsync --exclude ".git/" \
        --exclude ".DS_Store" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "LICENSE" \
        -avhR --no-perms . ~;
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

