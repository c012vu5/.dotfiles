function test-image -d "Run a image for testing"

    if [ (count $argv) -ne 1 ]
        echo "Usage: test-image <image>"
        return 1
    end

    set suffix 0
    set running (docker ps -a --format "table {{.Names}}" | grep test)

    while true
        set new_name "test$suffix"

        if not contains -- $new_name $running
            break
        end

        set suffix (math $suffix + 1)
    end

    docker run --name $new_name -h $new_name --rm -it $argv[1] /bin/sh
end
