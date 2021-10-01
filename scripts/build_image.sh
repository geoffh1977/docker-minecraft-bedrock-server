#!/bin/bash

# Set Some Build Variables
DOCKER_REPO="geoffh1977/minecraft-bedrock-server"
LATEST_IMAGE="${DOCKER_REPO}:latest"

# Get Live Software Version
DOWNLOAD_FILE=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.33 (KHTML, like Gecko) Chrome/90.0.$RandNum.212 Safari/537.33" -Ls https://www.minecraft.net/en-us/download/server/bedrock | grep -o "https://.*bin-linux/bedrock-server-.*.zip" | head -1)
VERSION=$(echo "${DOWNLOAD_FILE}" |  grep -Eo "[0-9]{1,3}\.[0-9]{1,3}(\.[0-9]{1,3}\.[0-9]{1,3})?")

# Build The Image
docker build --build-arg VERSION="${VERSION}" -f "./Dockerfile" -t "${LATEST_IMAGE}" .

# Get Software Version
# shellcheck disable=SC2155
SHORT_VERSION=$(echo "${VERSION}" | cut -d. -f1-2)

# Tag Additional Version Of Build
docker tag "${LATEST_IMAGE}" "${DOCKER_REPO}:${VERSION}"
docker tag "${LATEST_IMAGE}" "${DOCKER_REPO}:${SHORT_VERSION}"

# Push Builds To Docker Hub
docker push "${LATEST_IMAGE}"
docker push "${DOCKER_REPO}:${VERSION}"
docker push "${DOCKER_REPO}:${SHORT_VERSION}"
