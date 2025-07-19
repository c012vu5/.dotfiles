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
    abbr -a cleanall 'paru -Qdtq | paru -Rs -' # will no longer be available
    abbr -a sshlog 'sudo journalctl --no-hostname --since "30 days ago" -u sshd | grep " Accepted "' # will no longer be available
    abbr -a listbanned "sudo iptables -L sshguard -n | tail -n +3 | awk '{print \$4}'"
    abbr -a gitlog git log --oneline --decorate --graph --branches --tags --remotes
end
