#!/bin/bash

# Immediately exit on errors
set -ex

# There is only a single build with armv7 support
if [ "$(uname -m)" = "armv7l" ]; then
    URL="https://bitbucket.org/choekstra/influxdb2-linux-arm/downloads/influxdb2-v2.1.1-linux-armv7l.tar.gz"
    URL_CLI="https://bitbucket.org/choekstra/influxdb2-linux-arm/downloads/influxdb2-client-v2.2.1-linux-armv7l.tar.gz"
else
    # Transform the detected hardware in a name that exist on the repository
    ARCH=$(dpkg --print-architecture | sed 's/armhf/arm64/;s/aarch64/arm64/;s/amd64/amd64/;s/arm64/arm64/')
    INFLUXDB_VERSION="2.7.3"
    URL="https://dl.influxdata.com/influxdb/releases/influxdb2-${INFLUXDB_VERSION}_linux_${ARCH}.tar.gz"
    URL_CLI="https://dl.influxdata.com/influxdb/releases/influxdb2-client-${INFLUXDB_VERSION}-linux-${ARCH}.tar.gz"

fi

TEMP_FILE=/tmp/influxdb2.tar.gz
echo "Downloading InfluxDB from: $URL"
curl -L -o $TEMP_FILE "$URL"
tar xvfz $TEMP_FILE
rm $TEMP_FILE

TEMP_FILE=/tmp/influxdb2-client.tar.gz
echo "Downloading InfluxDB client from: $URL_CLI"
curl -L -o $TEMP_FILE "$URL_CLI"
tar xvfz $TEMP_FILE
rm $TEMP_FILE

if [ "$(uname -m)" = "armv7l" ]; then
    mv influx* /usr/bin/
fi

echo "InfluxDB installation complete."

# Client https://bitbucket.org/choekstra/influxdb2-linux-arm/downloads/influxdb2-client-v2.2.1-linux-armv7l.tar.gz