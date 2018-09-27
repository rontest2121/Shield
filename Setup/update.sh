#!/bin/bash -e
############################################
#####   Ericom Shield Update           #####
###################################LO##BH###

#Check if we are root
if ((EUID != 0)); then
    #    sudo su
    echo "Usage: $0 [OPTIONS] COMMAND [ARGS]..."
    echo " Please run it as Root"
    echo "sudo $0 $@"
    exit
fi

export BRANCH="master"
export ES_PATH=/usr/local/ericomshield
export ES_CONFIG_FILE="$ES_PATH/docker-compose.yml"
export ES_PRE_CHECK_FILE="$ES_PATH/shield-pre-install-check.sh"
export ES_BRANCH_FILE="$ES_PATH/.esbranch"


if [ -f "$ES_PATH/.esbranch" ]; then
    BRANCH=$(cat "$ES_PATH/.esbranch")
fi

ARGS="${@}"

while [ $# -ne 0 ]; do
    arg="$1"
    case "$arg" in
        -v | --version )
            BRANCH="$2"
         ;;
     esac
     shift
done

MAIN_SCRIPT_URL="https://raw.githubusercontent.com/EricomSoftwareLtd/Shield/$BRANCH/Setup/update.py"

cd "$ES_PATH"

curl -s -S -o "update.py" "$MAIN_SCRIPT_URL"

/usr/bin/python3 update.py $ARGS
