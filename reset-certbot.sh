#!/bin/bash

# Affiche un message de début
echo "Début de la réinitialisation de Certbot..."

# Arrête le service Certbot (si applicable)
echo "Arrêt du service Certbot..."
sudo systemctl stop certbot

# Supprime tous les certificats et clés Certbot
echo "Suppression des certificats et clés Certbot..."
sudo rm -rf /etc/letsencrypt/live/*
sudo rm -rf /etc/letsencrypt/archive/*
sudo rm -rf /etc/letsencrypt/renewal/*

# Optionnel : Supprime les logs Certbot
echo "Suppression des logs Certbot..."
sudo rm -rf /var/log/letsencrypt/*

# Optionnel : Supprime la configuration Certbot
echo "Suppression de la configuration Certbot..."
sudo rm -rf /etc/letsencrypt

# Redémarre le service Certbot (si applicable)
echo "Redémarrage du service Certbot..."
sudo systemctl start certbot

# Affiche un message de fin
echo "Réinitialisation de Certbot terminée."
