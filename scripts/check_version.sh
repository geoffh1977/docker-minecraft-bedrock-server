#!/bin/bash -e

# Get Latests Docker Hub Tag
LATEST_TAG=$(curl -s https://hub.docker.com/v2/repositories/geoffh1977/minecraft-bedrock-server/tags | jq -r '.results[].name' | grep -v "[a-z]" | sort -rn | head -n1)

# Get Live Software Version
RAND_NUM=$((1 + RANDOM % 5000))
DOWNLOAD_FILE=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.33 (KHTML, like Gecko) Chrome/90.0.$RAND_NUM.212 Safari/537.33" -Ls https://www.minecraft.net/en-us/download/server/bedrock | grep -o "https://.*bin-linux/bedrock-server-.*.zip" | head -1)
VERSION=$(echo "${DOWNLOAD_FILE}" |  grep -Eo "[0-9]{1,3}\.[0-9]{1,3}(\.[0-9]{1,3}\.[0-9]{1,3})?")

# Display Results
echo
echo "Latest Stored Docker Build Tag: ${LATEST_TAG}"
echo "Current Live Software Version: ${VERSION}"

echo
if [ "${LATEST_TAG}" == "${VERSION}" ]
then
  echo "Versions Match. No Rebuild Is Required."
else
  echo "Version MisMatch. A Rebuild Is Required."
  
  # shellcheck disable=SC1091
  source ./scripts/build_image.sh
fi
echo
