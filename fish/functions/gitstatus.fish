# Migrating bash script to fish; https://gist.github.com/mzabriskie/6631607

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

            if [ (git status | grep modified -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg\e[0;31mModified files\e[0m, "
            end

            if [ (git status | grep Untracked -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg\e[0;31mUntracked files\e[0m, "
            end

            if [ (git status | grep 'Your branch is ahead' -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg\e[0;31mUnpushed commit\e[0m, "
            end

            if [ $mod -ne 0 ]
                set status_msg (string trim -r -c ', ' $status_msg)
                echo -e "\e[0;35m$repository\e[0m : $status_msg"
            end

            popd
        end
    end
end
