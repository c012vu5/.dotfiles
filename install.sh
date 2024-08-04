#!/bin/sh

LOCATION=$(dirname "$(readlink -f "$0")")

main () {
    dependencies readlink basename dirname grep cat mkdir ln git
    edit_loginshell
    edit_emacs
    edit_fish
    edit_gitconfig
}

edit_loginshell () {
    LOGINSH=$(basename "${SHELL}")
    if [ "${LOGINSH}" = "tcsh" ] && [ -e ~/.tcshrc ]; then
        LOGINSH=tcsh
    elif [ "${LOGINSH}" = "tcsh" ] && [ -e ~/.cshrc ]; then
        LOGINSH=csh
    fi

    if ! grep -qs 'exec fish' ~/."${LOGINSH}"rc; then
            cat "${LOCATION}"/modfiles/embed."${LOGINSH}" >> ~/."${LOGINSH}"rc
    fi
}

edit_emacs () {
    if [ ! -e ~/.emacs.d ]; then
        mkdir -p ~/.emacs.d
    fi
    ln -sf "${LOCATION}"/emacs.d/init.el ~/.emacs.d/init.el
}

edit_fish () {
    ln -sf "${LOCATION}"/fish/config.fish ~/.config/fish/config.fish
    ln -sf "${LOCATION}"/fish/functions ~/.config/fish/functions
}

edit_gitconfig () {
    git config --global color.ui auto
    git config --global merge.ff false
    git config --global pull.ff only
    git config --global fetch.prune true
}

dependencies () {
    MISSING=""
    for CMD in "$@"; do
        if ! type "${CMD}" > /dev/null 2>&1; then
            MISSING="${MISSING}"\ "${CMD}"
        fi
    done
    if [ -n "${MISSING}"  ]; then
        printf "Dependencies error :\e[0;31m%s\e[0;39m not found.\n" "${MISSING}"
        exit 1
    fi
}

main "$@"
