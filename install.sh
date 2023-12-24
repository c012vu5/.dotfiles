#!/bin/sh

LOCATION=$(dirname $(readlink -f "$0"))

function main () {
    dependencies dirname readlink basename grep cat mkdir ln git
    edit_loginshell
    edit_emacs
    edit_fish
    edit_gitconfig
}

function edit_loginshell () {
    LOGINSH=`basename ${SHELL}`
    if [ ${LOGINSH} = "tcsh" ] && [ -e ~/.tcshrc ]; then
        LOGINSH=tcsh
    elif [ ${LOGINSH} = "tcsh" ] && [ -e ~/.cshrc ]; then
        LOGINSH=csh
    fi

    if ! grep -qs 'exec fish' ~/.${LOGINSH}rc; then
            cat ${LOCATION}/modfiles/embed.${LOGINSH} >> ~/.${LOGINSH}rc
    fi
}

function edit_emacs () {
    if [ ! -e ~/.emacs.d ]; then
        mkdir -p ~/.emacs.d
    fi
    ln -sf ${LOCATION}/emacs.d/init.el ~/.emacs.d/init.el
}

function edit_fish () {
    if [ ! -e ~/.config/fish/functions ]; then
        mkdir -p ~/.config/fish/functions
    fi
    ln -sf ${LOCATION}/fish/config.fish ~/.config/fish/config.fish
    ln -sf ${LOCATION}/fish/functions/config.fish ~/.config/fish/functions/config.fish
    ln -sf ${LOCATION}/fish/functions/fish_greeting.fish ~/.config/fish/functions/fish_greeting.fish
}

function edit_gitconfig () {
    git config --global color.ui auto
    git config --global merge.ff false
    git config --global pull.ff only
    git config --global fetch.prune true
}

function dependencies () {
    local MISSING=()
    for CMD in $@; do
        if ! type ${CMD} &> /dev/null; then
            MISSING+=(${CMD})
        fi
    done
    if [ ${#MISSING[@]} -ne 0 ]; then
        echo -e "Dependencies error : \e[0;31m${MISSING[@]}\e[0;39m not found."
        exit 1
    fi
}

main $@
