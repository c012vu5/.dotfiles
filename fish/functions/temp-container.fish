function temp-container -d "Run a temporary container for testing"

    dependencies docker grep || return 1

    if [ (count $argv) -ne 1 ]
        echo "Usage: temp-container <image>"
        return 1
    end

    set base_name "temp"
    set suffix 0
    set running (docker ps -a --format "table {{.Names}}" | grep $base_name)

    while true
        set new_name "$base_name$suffix"

        if not contains -- $new_name $running
            break
        end

        set suffix (math $suffix + 1)
    end

    docker run --name $new_name -h $new_name --rm -it $argv[1] /bin/sh
end
