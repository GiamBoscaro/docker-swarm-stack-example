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
    if [[ $QUIT -eq 1 ]]
    then
        echo "Removing Docker Swarm Stack..."
        docker stack rm swarm-example
    else
        echo "Deploying Docker Swarm Stack..."
        docker stack deploy --compose-file docker-compose.swarm.yaml swarm-example
    fi
else
    if [[ $QUIT -eq 1 ]]
    then
        echo "Stopping Docker Compose..."
        docker compose -f docker-compose.yaml down
    else
        echo "Starting Docker Compose..."
        docker compose -f docker-compose.yaml up -d
    fi
fi

echo "DONE"
