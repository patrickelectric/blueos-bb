#!/usr/bin/env bash

# Immediately exit on errors
set -e

VERSION="0.10.0-rc"
TOOLCHAIN="armv7-unknown-linux-gnueabihf"
MIRROR="1"
BINARIES=(
  "zenoh"
  "zenoh-backend-influxdb"
  "zenoh-plugin-webserver"
)

echo "Download zenoh and friends.."
DOWNLOAD_FOLDER="/tmp/zenoh_and_friends"
mkdir -p $DOWNLOAD_FOLDER
for BINARY in "${BINARIES[@]}"; do
  URL="https://www.eclipse.org/downloads/download.php?file=/zenoh/${BINARY}/${VERSION}/${TOOLCHAIN}/${BINARY}-${VERSION}-${TOOLCHAIN}.zip&mirror_id=${MIRROR}"
  echo "Download: ${URL}"
  curl -L -o "${DOWNLOAD_FOLDER}/${BINARY}.zip" $URL
done
cd ${DOWNLOAD_FOLDER}
unzip "*.zip"
mv * /usr/bin
cd - && rm -rf ${DOWNLOAD_FOLDER}