#!/bin/bash

# Check if DOMAIN_NAME is set
# Charger les variables d'environnement à partir du fichier .env
if [ -f /opt/ghost/.env ]; then
  export $(grep -v '^#' /opt/ghost/.env | xargs)
else
  echo "Le fichier .env n'a pas été trouvé après vérification."
  exit 1
fi

# Check if the variable DOMAIN_NAME is defined
if [ -z "$DOMAIN_NAME" ]; then
  echo "La variable DOMAIN_NAME doit être définie dans le fichier .env."
  exit 1
fi

# Replace environment variables in nginx.conf
envsubst '${DOMAIN_NAME}' < /opt/ghost/nginx.conf > /opt/ghost/nginx.conf.tmp

# Move the temporary file to the final configuration file
mv /opt/ghost/nginx.conf.tmp /opt/ghost/nginx.conf

# Print confirmation
echo "Nginx configuration updated with DOMAIN_NAME=${DOMAIN_NAME}."
