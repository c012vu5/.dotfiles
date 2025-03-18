function authenticator -d "Force to run as specific user"
    set user $argv
    if [ (count $user) -eq 0 ]
        printf "\e[0;31mError\e[0;39m : Specify the user\n"
        return 1
    end

    if not getent passwd $user > /dev/null
        printf "\e[0;31mError\e[0;39m : User \e[0;1;5;31m%s\e[0;39m does not exist\n" $user
        return 1
    end

    if [ (id -u) -ne (id -u $user) ]
        printf "\e[0;31mError\e[0;39m : Please run as \e[0;1;5;31m%s\e[0;39m\n" $user
        return 1
    end
end
