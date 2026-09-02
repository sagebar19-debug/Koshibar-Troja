# KÖSHÏBÄR Trojan — Google Cloud Run

Configuration Xray Trojan + WebSocket destinée à Google Cloud Run.

## Architecture

Client
  ↓
HTTPS / WSS
  ↓
Google Cloud Run
  ↓
WebSocket
  ↓
Xray Trojan
  ↓
Internet

Cloud Run termine le TLS HTTPS.
Xray reçoit ensuite la connexion WebSocket.

## Fichiers

- Dockerfile
- config.json
- README.md

## Configuration

Le serveur utilise automatiquement la variable :

PORT

Cloud Run fournit cette variable au conteneur.

Xray écoute donc sur :

0.0.0.0:$PORT

Le chemin WebSocket est :

/koshibar-trojan

Le mot de passe Trojan configuré dans cet exemple est :

KOSHIBAR-TROJAN-2026

Il est fortement recommandé de le remplacer par une valeur longue et aléatoire avant utilisation.

## Déploiement

Construire l'image :

gcloud builds submit \
  --tag REGION-docker.pkg.dev/PROJECT_ID/REPOSITORY/koshibar-trojan

Remplacer :

REGION
PROJECT_ID
REPOSITORY

par les valeurs de votre projet Google Cloud.

Déployer :

gcloud run deploy koshibar-trojan \
  --image REGION-docker.pkg.dev/PROJECT_ID/REPOSITORY/koshibar-trojan \
  --platform managed \
  --region REGION \
  --allow-unauthenticated \
  --port 8080 \
  --timeout 3600

## WebSocket

Le chemin WebSocket est :

/koshibar-trojan

Exemple d'URL de service :

https://koshibar-trojan-XXXXXXXXXX-XX.a.run.app

Le client doit utiliser le domaine HTTPS fourni par Cloud Run.

Pour un domaine personnalisé :

https://vpn.example.com

le transport WebSocket utilise :

wss://vpn.example.com/koshibar-trojan

## Paramètres Trojan

Protocol:

trojan

Address:

votre-domaine-Cloud-Run

Port:

443

Password:

KOSHIBAR-TROJAN-2026

Network:

ws

Path:

/koshibar-trojan

TLS:

activé côté client

SNI:

votre domaine Cloud Run ou votre domaine personnalisé

## Domaine personnalisé

Si vous utilisez :

vpn.example.com

le DNS doit pointer vers le service Cloud Run conformément à la configuration du domaine personnalisé Google Cloud.

Le client utilise alors :

Address: vpn.example.com
Port: 443
Network: WebSocket
Path: /koshibar-trojan
TLS: ON

## Vérification

Après le déploiement, vérifier les logs :

gcloud run services logs read koshibar-trojan \
  --region REGION

Vérifier également que le service est bien démarré.

## Important

Cloud Run est un environnement HTTP/HTTPS et prend en charge les WebSockets.

Ce fichier n'utilise donc pas un serveur Trojan TCP/TLS classique sur le port 443.

Le TLS public est géré par Cloud Run.

Le conteneur Xray écoute sur la variable PORT fournie par Cloud Run.

Ne remplacez pas :

"port": "env:PORT"

par :

"port": 443

dans cette configuration.

## Timeout WebSocket

Les WebSockets Cloud Run sont soumis au timeout de requête Cloud Run.

Le déploiement ci-dessus utilise :

--timeout 3600

Les clients doivent également pouvoir se reconnecter si la connexion est interrompue.

## Sécurité

Remplacez le mot de passe par un mot de passe aléatoire et suffisamment long.

N'utilisez pas le mot de passe d'exemple en production.
