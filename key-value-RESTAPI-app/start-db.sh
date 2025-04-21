#!/bin/bash

MONGODB_IMAGE="mongo"
MONGODB_TAG="7.0"
source .env.db

# Root credentials
MONGODB_ROOT_USER="root-user"
MONGODB_ROOT_PASSWORD="root-password"


# Connection settings
source .env.network
LOCALHOST_PORT="27017"
CONTAINER_PORT="27017"

# Storage settings
source .env.volume
VOLUME_CONTAINER_PATH=/data/db

source setup.sh

# Create mongo-init.js using envsubst
export KEY_VALUE_DB KEY_VALUE_DB_USER KEY_VALUE_DB_PASSWORD
envsubst < ./db-config/mongo-init.template.js > ./db-config/mongo-init.js

# Clean up any existing container
if [ "$(docker ps -aq -f name=$DB_CONTAINER_NAME)" ]; then
    echo "A container named $DB_CONTAINER_NAME was found. Removing it..."
    docker rm -f $DB_CONTAINER_NAME 2>/dev/null
else
    echo "No container named $DB_CONTAINER_NAME was found. Skipping container removal and running a new container named $DB_CONTAINER_NAME."
fi


# Run MongoDB container with mounted init script
docker run -d --name $DB_CONTAINER_NAME \
    -e MONGODB_ROOT_USERNAME=$MONGODB_ROOT_USER \
    -e MONGODB_ROOT_PASSWORD=$MONGODB_ROOT_PASSWORD \
    -e KEY_VALUE_DB=$KEY_VALUE_DB \
    -e KEY_VALUE_DB_USER=$KEY_VALUE_DB_USER \
    -e KEY_VALUE_DB_PASSWORD=$KEY_VALUE_DB_PASSWORD \
    -p $LOCALHOST_PORT:$CONTAINER_PORT \
    -v $VOLUME_NAME:$VOLUME_CONTAINER_PATH \
    -v "$(pwd)/db-config/mongo-init.js:/docker-entrypoint-initdb.d/mongo-init.js:ro" \
    --network $NETWORK_NAME \
    $MONGODB_IMAGE:$MONGODB_TAG \
    --auth

    # Note: The --auth flag is used to enable authentication in MongoDB.
    # The mongodb/mongodb-community-server image is a community edition of MongoDB and does not use -e MONGODB_INITDB_ROOT_USERNAME and -e MONGODB_INITDB_ROOT_PASSWORD environment variables. Instead you pass it using -e MONGODB_ROOT_USERNAME and -e MONGODB_ROOT_PASSWORD

