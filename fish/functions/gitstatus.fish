# Migrating bash script to fish; https://gist.github.com/mzabriskie/6631607
# 文字修飾が壊れているので修正

function gitstatus -d "Check the status of all git repositories under specified directory"

    dependencies find git grep xargs || return 1

    set dir $argv
    if [ (count $dir) -eq 0 ]
        set dir (pwd)
    end

    for element in $dir
        if string match -q '*/' $element
            set fixed $fixed "$element"
        else
            set fixed $fixed "$element/"
        end
    end

    for element in $fixed
        for repository in (find $element -type d -name .git | xargs dirname)
            set -e status_msg
            set mod 0
            pushd $repository
            printf "\033[0;35m%s\033[0m : " $repository

            if [ $(git status | grep modified -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg\033[0;31mModified files\033[0m, "
            end

            if [ $(git status | grep Untracked -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg\033[0;31mUntracked files\033[0m, "
            end

            if [ $(git status | grep 'Your branch is ahead' -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg\033[0;31mUnpushed commit\033[0m, "
            end

            if [ $mod -eq 0 ]
                printf "Nothing to commit"
            else
                set status_msg (string trim -r -c ', ' $status_msg)
                printf "%s" $status_msg
            end

            echo
            popd
        end
    end
end
