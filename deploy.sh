# !/bin/bash

QUIT=0
SWARM=0

while getopts 'qs' flag; do
  case "${flag}" in
    q) QUIT=1 ;;
    s) SWARM=1 ;;
    *) break ;;
  esac
done

docker context use swarm-manager

if [[ $SWARM -eq 1 ]]
then
    echo "Deploy Swarm Stack..."
    exit 1
else
    if [[ $QUIT -eq 1 ]]
    then
        echo "Stopping Docker Compose..."
        docker compose -f docker-compose.stack.yaml down
    else
        echo "Starting Docker Compose..."
        docker compose -f docker-compose.stack.yaml up -d
    fi
fi

echo "DONE"
