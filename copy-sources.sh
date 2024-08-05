#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(cat .env | xargs)
fi

SCP_HOST="root@$IP_SERVER_HOST"
DIR_TARGET="/opt/ghost"

ENV_SOURCE="./.env"
DOCKER_COMPOSE_SOURCE="./docker-compose.yml"
SETUP_DOCKER_GHOST_SOURCE="./setup-docker-ghost.sh"
NGINX_SOURCE="./nginx.conf"
SETUP_CERTBOT_SOURCE="./setup-certbot.sh"
SETUP_NGINX_SOURCE="./setup-nginx.sh"
RESET_DOCKER_SOURCE="./reset-docker.sh"
RESET_CERTBOT_SOURCE="./reset-certbot.sh"

SCP_ENV_PATH="$DIR_TARGET/.env"
SCP_DOCKER_COMPOSE_PATH="$DIR_TARGET/docker-compose.yml"
SCP_SETUP_DOCKER_GHOST_PATH="$DIR_TARGET/setup-docker-ghost.sh"
SCP_NGINX_PATH="$DIR_TARGET/nginx.conf"
SCP_SETUP_CERTBOT_PATH="$DIR_TARGET/setup-certbot.sh"
SCP_SETUP_NGINX_PATH="$DIR_TARGET/setup-nginx.sh"
SCP_RESET_DOCKER_PATH="$DIR_TARGET/reset-docker.sh"
SCP_RESET_CERTBOT_PATH="$DIR_TARGET/reset-certbot.sh"

ssh $SCP_HOST "mkdir -p $DIR_TARGET"

# Copy of files .env and docker-compose.yml on the server
scp $ENV_SOURCE $SCP_HOST:$SCP_ENV_PATH
scp $DOCKER_COMPOSE_SOURCE $SCP_HOST:$SCP_DOCKER_COMPOSE_PATH
scp $SETUP_DOCKER_GHOST_SOURCE $SCP_HOST:$SCP_SETUP_DOCKER_GHOST_PATH
scp $NGINX_SOURCE $SCP_HOST:$SCP_NGINX_PATH
scp $SETUP_CERTBOT_SOURCE $SCP_HOST:$SCP_SETUP_CERTBOT_PATH
scp $SETUP_NGINX_SOURCE $SCP_HOST:$SCP_SETUP_NGINX_PATH
scp $RESET_DOCKER_SOURCE $SCP_HOST:$SCP_RESET_DOCKER_PATH
scp $RESET_CERTBOT_SOURCE $SCP_HOST:$SCP_RESET_CERTBOT_PATH
