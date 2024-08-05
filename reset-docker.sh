#!/bin/bash

echo "Stopping all running containers..."
containers=$(docker ps -q)
if [ -n "$containers" ]; then
    docker stop $containers
else
    echo "No running containers to stop."
fi

echo "Removing all containers..."
containers=$(docker ps -a -q)
if [ -n "$containers" ]; then
    docker rm $containers
else
    echo "No containers to remove."
fi

echo "Removing all Docker networks..."
docker network prune -f

echo "Removing all Docker volumes..."
docker volume prune -f

# Listing and removing all Docker volumes explicitly
echo "Listing all Docker volumes..."
volumes=$(docker volume ls -q)

if [ -n "$volumes" ]; then
    echo "Removing all Docker volumes..."
    docker volume rm $volumes
else
    echo "No Docker volumes to remove."
fi

# Optional: Remove all Docker images
echo "Listing all Docker images..."
images=$(docker images -q)

if [ -n "$images" ]; then
    echo "Removing all Docker images..."
    docker rmi -f $images
else
    echo "No Docker images to remove."
fi

echo "Docker environment reset complete."
