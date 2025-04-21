#!/bin/bash

source .env.db

# Connection settings
source .env.network
LOCALHOST_PORT="3000"
CONTAINER_PORT="3000"

BACKEND_IMAGE_NAME="key-value-backend"
BACKEND_CONTAINER_NAME="key-value-backend-cont"

MONGODB_HOST="mongodb"

# Clean up any existing image
if [ "$(docker ps -aq -f name=$BACKEND_IMAGE_NAME)" ]; then
    echo "An image named $BACKEND_IMAGE_NAME was found. Removing it..."
    docker rmi $BACKEND_IMAGE_NAME 2>/dev/null
    echo "Building a new image named $BACKEND_IMAGE_NAME..."
else
    echo "No image named $BACKEND_IMAGE_NAME was found. Skipping image removal and building a new image named $BACKEND_IMAGE_NAME."
fi

# Build the backend image
docker build -t $BACKEND_IMAGE_NAME \
    -f backend/Dockerfile.dev \
    backend


# Clean up any existing container
if [ "$(docker ps -aq -f name=$BACKEND_CONTAINER_NAME)" ]; then
    echo "A container named $BACKEND_CONTAINER_NAME was found. Removing it..."
    docker rm -f $BACKEND_CONTAINER_NAME 2>/dev/null
    echo "Running a new container named $BACKEND_CONTAINER_NAME..."
else
    echo "No container named $BACKEND_CONTAINER_NAME was found. Skipping container removal and running a new container named $BACKEND_CONTAINER_NAME."
fi


# Run MongoDB container 
docker run -d --name $BACKEND_CONTAINER_NAME \
    -e KEY_VALUE_DB=$KEY_VALUE_DB \
    -e KEY_VALUE_DB_USER=$KEY_VALUE_DB_USER \
    -e KEY_VALUE_DB_PASSWORD=$KEY_VALUE_DB_PASSWORD \
    -e MONGODB_HOST=$MONGODB_HOST \
    -e PORT=$CONTAINER_PORT \
    -p $LOCALHOST_PORT:$CONTAINER_PORT \
    -v ./backend/src:/app/src \
    --network $NETWORK_NAME \
    $BACKEND_IMAGE_NAME 

    # Note: The --auth flag is used to enable authentication in MongoDB.
    # The mongodb/mongodb-community-server image is a community edition of MongoDB and does not use -e MONGODB_INITDB_ROOT_USERNAME and -e MONGODB_INITDB_ROOT_PASSWORD environment variables. Instead you pass it using -e MONGODB_ROOT_USERNAME and -e MONGODB_ROOT_PASSWORD

