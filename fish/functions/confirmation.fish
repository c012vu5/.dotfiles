function confirmation -d "Require one-time password before running dangerous commands"
    dependencies tr fold head sort uniq || return 1

    set cmd $argv
    if [ (count $cmd) -eq 0 ]
        printf "\e[0;31mError\e[0;39m : Specify the command\n"
        return 1
    end

    printf "\e[0;31mWARNING!!!\e[0;39m : You are trying to run \e[0;1;5;31m%s\e[0;39m" $cmd[1]
    for element in $cmd[2..-1]
        printf ", \e[0;1;5;31m%s\e[0;39m" $element
    end
    printf ".\n"
    set lock $(tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w 8 | head -1 | sort | uniq)
    printf "\e[0;31mEnter this password to continue.\e[0;39m\n"
    printf "PASSWORD : \e[4;32m%s\e[0;39m\n" "$lock"
    read -P "KEY : " key

    if [ -z "$key" ]
        printf "\e[0;31mCanceled.\e[0;39m\n"
        return 1
    else if [ "$lock" = "$key" ]
        printf "\e[0;32mSucceeded.\e[0;39m\n"
    else
        printf "\e[0;31mFailed.\e[0;39m\n"
        return 1
    end
end
