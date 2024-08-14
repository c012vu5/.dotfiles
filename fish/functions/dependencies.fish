function dependencies -d "Command dependencies check for functions"
    set dependencies $argv
    set missing ""

    for cmd in $dependencies
        if ! type $cmd > /dev/null 2>&1
            set missing $missing $cmd
        end
    end

    if [ (count $missing) -gt 1 ]
        printf "Dependencies error :\e[0;31m%s\e[0;39m not found.\n" $missing[2..-1]
        return 1
    end
end
