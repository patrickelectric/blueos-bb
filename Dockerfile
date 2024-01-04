FROM debian:bookworm-slim

# Install curl and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Add InfluxDB's GPG key
RUN curl -sL https://repos.influxdata.com/influxdb.key | gpg --dearmor | tee /usr/share/keyrings/influxdb-archive-keyring.gpg > /dev/null

# Port used by InfluxDB
EXPOSE 8086

RUN apt update && apt install -y unzip
COPY zenoh_install.sh /
RUN /zenoh_install.sh

COPY influxdb2_install.sh /
RUN /influxdb2_install.sh