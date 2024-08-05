#!/bin/bash

# Charger les variables d'environnement à partir du fichier .env
if [ -f /opt/ghost/.env ]; then
  export $(grep -v '^#' /opt/ghost/.env | xargs)
else
  echo "Le fichier .env n'a pas été trouvé après vérification."
  exit 1
fi

# Vérifier si les variables DOMAIN_NAME et EMAIL_ADMIN sont définies
if [ -z "$DOMAIN_NAME" ] || [ -z "$EMAIL_ADMIN" ]; then
  echo "Les variables DOMAIN_NAME et EMAIL_ADMIN doivent être définies dans le fichier .env."
  exit 1
fi

# Mettre à jour la liste des paquets et installer snapd si nécessaire
sudo apt-get update
sudo apt-get install -y snapd

# Assurer que snapd est à jour
sudo snap install core; sudo snap refresh core

# Installer Certbot via Snap
sudo snap install --classic certbot

# Créer un lien symbolique pour utiliser la commande certbot, s'il n'existe pas déjà
if [ ! -L /usr/bin/certbot ]; then
  sudo ln -s /snap/bin/certbot /usr/bin/certbot
fi

# Obtenir les certificats SSL avec Certbot en mode standalone
sudo certbot certonly --standalone -d "$DOMAIN_NAME" --non-interactive --agree-tos -m "$EMAIL_ADMIN"

# Configurer le renouvellement automatique des certificats
echo "0 3 * * * /usr/bin/certbot renew --quiet" | sudo tee -a /etc/crontab > /dev/null

# Afficher une confirmation
echo "Certbot a été installé et configuré. Les certificats SSL seront renouvelés automatiquement."
