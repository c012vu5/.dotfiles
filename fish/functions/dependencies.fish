function dependencies -d "Command dependencies check for functions"
    set dependencies $argv

    for cmd in $dependencies
        if ! type $cmd > /dev/null 2>&1
            set missing $missing $cmd
        end
    end

    if [ (count $missing) -ne 0 ]
        printf "Dependencies error : \e[0;31m%s\e[0;39m" $missing[1]
        for element in $missing[2..-1]
            printf ", \e[0;31m%s\e[0;39m" $element
        end
        printf " not found.\n"
        return 1
    end
end
