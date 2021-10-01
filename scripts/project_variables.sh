#!/bin/bash
# Variables Which Are Specific To This Project
# shellcheck disable=SC2154,SC2086

# Get Latest Tag Version From Docker Hub
LATEST_TAG=$(curl -s https://hub.docker.com/v2/repositories/${project_project_hub_owner}/${project_project_hub_image}/tags | jq -r '.results[].name' | grep -v "[a-z]" | sort -rn | head -n1)

# Get Software Version From Downloaded Information
RAND_NUM=$((1 + RANDOM % 5000))
DOWNLOAD_FILE=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.33 (KHTML, like Gecko) Chrome/90.0.$RAND_NUM.212 Safari/537.33" -Ls https://www.minecraft.net/en-us/download/server/bedrock | grep -o "https://.*bin-linux/bedrock-server-.*.zip" | head -1)
VERSION=$(echo "${DOWNLOAD_FILE}" |  grep -Eo "[0-9]{1,3}\.[0-9]{1,3}(\.[0-9]{1,3}\.[0-9]{1,3})?")
SHORT_VERSION=$(echo "${VERSION}" | cut -d. -f1-2)

# Append Variables To Environment File
cat << EOF >> ./.env
# Latest Version Detected For Image On Docker Hub
DOCKER_HUB_VERSION=${LATEST_TAG}

# Latest Software Version Detected For Application
SOFTWARE_VERSION=${VERSION}
SOFTWARE_SHORT_VERSION=${SHORT_VERSION}

EOF
