FROM debian:bookworm-slim

# Set environment variables
ENV INFLUXDB_VERSION=2.7.3-1

# Install curl and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Add InfluxDB's GPG key
RUN curl -sL https://repos.influxdata.com/influxdb.key | gpg --dearmor | tee /usr/share/keyrings/influxdb-archive-keyring.gpg > /dev/null

# Download and install InfluxDB based on the architecture
# Right now only supports amd64 and arm64
RUN ARCH=$(dpkg --print-architecture | sed 's/armhf/arm64/;s/aarch64/arm64/;s/amd64/amd64/;s/arm64/arm64/') && \
    echo "https://dl.influxdata.com/influxdb/releases/influxdb2_${INFLUXDB_VERSION}_${ARCH}.deb" && \
    curl -o /tmp/influxdb2.deb https://dl.influxdata.com/influxdb/releases/influxdb2_${INFLUXDB_VERSION}_${ARCH}.deb && \
    dpkg -i /tmp/influxdb2.deb && \
    rm /tmp/influxdb2.deb

# Port used by InfluxDB
EXPOSE 8086

RUN apt update && apt install -y unzip
COPY zenoh_install.sh /
RUN /zenoh_install.sh