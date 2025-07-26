function gitstatus -d "Check the status of all git repositories under specified directory"
    dependencies find git || return 1

    set dir $argv
    if test (count $dir) -eq 0
        set dir (pwd)
    end

    set fixed
    for element in $dir
        if string match -rq '/$' $element
            set fixed $fixed "$element"
        else
            set fixed $fixed "$element/"
        end
    end

    set total 0
    set dirty 0

    for element in $fixed
        for repository in (find $element -type d -name .git | while read -l repo; dirname $repo; end)
            set  has_modified 0
            set  has_untracked 0
            set  has_unpushed 0
            set total (math $total + 1)

            for line in (git -C $repository status --porcelain=2 --branch)
                if string match -qr '^[12]' -- $line
                    set has_modified 1
                end

                if string match -qr '^\?' -- $line
                    set has_untracked 1
                end

                if string match -qr '^# branch.ab' -- $line
                    set tokens (string split " " $line)
                    set ahead (string replace "+" "" -- $tokens[3])
                    if test "$ahead" -ge 1
                        set has_unpushed 1
                    end
                end
            end

            if test $has_modified -eq 1 -o $has_untracked -eq 1 -o $has_unpushed -eq 1
                set dirty (math $dirty + 1)
                set -e status_msg
                if test "$has_modified" -eq 1
                    set status_msg $status_msg (printf "\e[0;31mModified files\e[0m, ")
                end
                if test "$has_untracked" -eq 1
                    set status_msg $status_msg (printf "\e[0;31mUntracked files\e[0m, ")
                end
                if test "$has_unpushed" -eq 1
                    set status_msg $status_msg (printf "\e[0;31mUnpushed commit\e[0m, ")
                end
                printf "\e[0;35m%s\e[0m : %s\n" $repository (string join ', ' $status_msg)
            end
        end
    end

    if test $dirty -eq 0
        if test $total -eq 0
            printf "\e[0;32mNo git repositories found under the specified directories\e[0m\n"
        else
            printf "\e[0;32mAll repositories clean, Nothing to commit in any working tree\e[0m\n"
        end
    end
end
