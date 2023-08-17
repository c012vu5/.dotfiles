if status is-interactive
    # Commands to run in interactive sessions can go here
end

# USER SETTINGS
set -gx EDITOR /usr/bin/emacs
abbr -a ls ls --color=auto
abbr -a ll ls -la --color=auto
abbr -a mktemp pushd "$(mktemp -d)"
abbr -a emacs emacs -nw
abbr -a extract grep -Ev \'^#\| +#\|^\$\'
abbr -a cleanall 'paru -Qdtq | paru -Rs -'
abbr -a gitlog git log --oneline --decorate --graph --branches --tags --remotes
abbr -a enter-container docker exec -it
abbr -a test-container docker run --name test -h test --rm -it