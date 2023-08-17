#!/bin/sh

LOCATION=`dirname $(readlink -f "$0")`

### LOGIN SHELL BLOCK
LOGINSH=`basename ${SHELL}`
if [ ${LOGINSH} = "tcsh" ] && [ -e ~/.tcshrc ]; then
    LOGINSH=tcsh
elif [ ${LOGINSH} = "tcsh" ] && [ -e ~/.cshrc ]; then
    LOGINSH=csh
fi

if ! grep -qs 'exec fish' ~/.${LOGINSH}rc; then
    if [ ${LOGINSH} = "bash" ]; then
        cat >> ~/.${LOGINSH}rc <<EOF

##### .DOTFILES MANAGED BLOCK
if which fish > /dev/null 2>&1; then
    exec fish
fi
EOF
    elif [ ${LOGINSH} = "tcsh" ] || [ ${LOGINSH} = "csh" ]; then
        cat >> ~/.${LOGINSH}rc <<EOF

##### .DOTFILES MANAGED BLOCK
if ( \${SHLVL} >= 2 && \`which fish >& /dev/null; echo \$?\` == 0 ) then
    exec fish
endif
EOF
    fi
fi

### EMACS BLOCK
if [ ! -e ~/.emacs.d ]; then
    mkdir -p ~/.emacs.d
fi
ln -sf ${LOCATION}/init.el ~/.emacs.d/init.el

### FISH BLOCK
if [ ! -e ~/.config/fish/functions ]; then
    mkdir -p ~/.config/fish/functions
fi
ln -sf ${LOCATION}/fish/config.fish ~/.config/fish/config.fish
ln -sf ${LOCATION}/fish/functions/config.fish ~/.config/fish/functions/config.fish
ln -sf ${LOCATION}/fish/functions/fish_greeting.fish ~/.config/fish/functions/fish_greeting.fish
