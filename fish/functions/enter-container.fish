function enter-container -d "Enter a running container"

    dependencies docker || return 1

    if [ (count $argv) -ne 1 ]
        echo "Usage: enter-container <container>"
        return 1
    end

    docker exec -it $argv[1] /bin/sh
end
