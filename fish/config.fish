if status is-interactive
    # USER SETTINGS
    set -gx EDITOR /usr/bin/emacs

    # ALIASES
    # Even if it is a simple command, if the main argument is not at the end, make it into a function.
    abbr -a ls ls --color=auto
    abbr -a ll ls -la --color=auto
    abbr -a mktemp pushd (mktemp -d)
    abbr -a emacs emacs -nw
    abbr -a extract grep -Ev \'^#\| +#\|^\$\'
    abbr -a cleanall 'paru -Qdtq | paru -Rs -'
    abbr -a sshlog 'sudo journalctl --no-hostname --since "30 days ago" -u sshd | grep " Accepted "'
    abbr -a gitlog git log --oneline --decorate --graph --branches --tags --remotes
end
