FROM debian:bullseye

RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    sed -i 's|deb.debian.org|archive.debian.org|g; s|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y wget tar ca-certificates && rm -rf /var/lib/apt/lists/*

# Download Portainer binary
RUN wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz -O /tmp/portainer.tar.gz \
    && tar -xzf /tmp/portainer.tar.gz -C /opt \
    && rm /tmp/portainer.tar.gz

# Expose Portainer port
EXPOSE 9443

# Run Portainer
CMD ["/opt/portainer/portainer"]
