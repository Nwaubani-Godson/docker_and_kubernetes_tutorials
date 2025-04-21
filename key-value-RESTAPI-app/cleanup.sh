# 1. Stop and remove mongoDB container
# 2. Stop and remove app container
# 3. Remove volume
# 4. Remove network

source .env.network
source .env.volume
source .env.db

if [ "$(docker ps -aq -f name=$DB_CONTAINER_NAME)" ]; then
    echo "Stopping and removing the $DB_CONTAINER_NAME container..."
    docker stop $DB_CONTAINER_NAME
    docker rm $DB_CONTAINER_NAME
else
    echo "No container named $DB_CONTAINER_NAME was found. Skipping container removal."
fi


if [ "$(docker network ls -q -f name=$NETWORK_NAME)" ]; then
    echo "Removing the $NETWORK_NAME network..."
    docker network rm $NETWORK_NAME
else
    echo "No network named $NETWORK_NAME was found. Skipping network removal."
fi


if [ "$(docker volume ls -q -f name=$VOLUME_NAME)" ]; then
    echo "Removing the $VOLUME_NAME volume..."
    docker volume rm $VOLUME_NAME
else
    echo "No volume named $VOLUME_NAME was found. Skipping volume removal."
fi
