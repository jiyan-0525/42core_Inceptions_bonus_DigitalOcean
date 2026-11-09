FROM debian:bullseye

RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    sed -i 's|deb.debian.org|archive.debian.org|g; s|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y redis-server && rm -rf /var/lib/apt/lists/*

# Copy configuration
COPY conf/redis.conf /etc/redis/redis.conf

# Expose Redis port
EXPOSE 6379

# Start Redis with the custom configuration
CMD ["redis-server", "/etc/redis/redis.conf", "--protected-mode no"]
