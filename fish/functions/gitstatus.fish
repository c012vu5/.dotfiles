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

    set total 0
    set dirty 0

    for element in $fixed
        for repository in (find $element -type d -name .git | xargs -r dirname)
            set -e status_msg
            set mod 0
            set total (math $total + 1)
            pushd $repository >/dev/null

            if [ (git status | grep modified -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg"(printf "\e[0;31mModified files\e[0m, ")
            end

            if [ (git status | grep Untracked -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg"(printf "\e[0;31mUntracked files\e[0m, ")
            end

            if [ (git status | grep 'Your branch is ahead' -c) -ne 0 ]
                set mod 1
                set status_msg "$status_msg"(printf "\e[0;31mUnpushed commit\e[0m, ")
            end

            if [ $mod -ne 0 ]
                set dirty (math $dirty + 1)
                set status_msg (string trim -r -c ', ' $status_msg)
                printf "\e[0;35m%s\e[0m : %s\n" $repository "$status_msg"
            end

            popd >/dev/null
        end
    end

    if [ $dirty -eq 0 ]
        if [ $total -eq 0 ]
            printf "\e[0;32mNo git repositories found under the specified directories\e[0m\n"
        else
            printf "\e[0;32mAll repositories clean, Nothing to commit in any working tree\e[0m\n"
        end
    end
end
