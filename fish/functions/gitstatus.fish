# Migrating bash to fish; https://gist.github.com/mzabriskie/6631607
# syntax check; fish -d debug script.fish

function gitstatus -d "Check the status of all git repositories in a directory" -a dir

    # set dir "$1"

    # No directory has been provided, use current
    if [ -z "$dir" ]
        set dir (pwd)
    end

    # Make sure directory ends with "/"
    if [[ $dir != */ ]]
        set dir "$dir/*"
    else
        set dir "$dir*"
    end

    # Loop all sub-directories
    for f in $dir
        # Only interested in directories
        [ -d "${f}" ] || continue

        echo -en "\033[0;35m"
        echo "${f}"
        echo -en "\033[0m"

        # Check if directory is a git repository
        if [ -d "$f/.git" ]
            set mod 0
            cd $f

            # Check for modified files
            if [ $(git status | grep modified -c) -ne 0 ]
                set mod 1
                echo -en "\033[0;31m"
                echo "Modified files"
                echo -en "\033[0m"
            end

            # Check for untracked files
            if [ $(git status | grep Untracked -c) -ne 0 ]
                set mod 1
                echo -en "\033[0;31m"
                echo "Untracked files"
                echo -en "\033[0m"
            end

            # Check for unpushed changes
            if [ $(git status | grep 'Your branch is ahead' -c) -ne 0 ]
                    set mod 1
                    echo -en "\033[0;31m"
                    echo "Unpushed commit"
                    echo -en "\033[0m"
            end

            # Check if everything is peachy keen
            if [ $mod -eq 0 ]
                echo "Nothing to commit"
            end

            cd ../
        else
            echo "Not a git repository"
        end

        echo
    end
end
