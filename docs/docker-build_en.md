# Local Docker Image Build Method

This project now uses GitHub's automatic Docker build functionality. This document is prepared for those who need to build Docker images locally.

1. Install Docker
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
2. Build Docker Images
```
# Navigate to the project root directory
# Build server
docker build -t xiaozhi-esp32-server:server_latest -f ./Dockerfile-server .
# Build web
docker build -t xiaozhi-esp32-server:web_latest -f ./Dockerfile-web .

# After building, you can start the project using docker-compose
# You need to modify docker-compose.yml to use your own built image version
cd main/xiaozhi-server
docker-compose up -d
```