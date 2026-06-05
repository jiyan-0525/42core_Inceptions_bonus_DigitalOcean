FROM debian:bullseye

RUN apt-get update && apt-get install -y redis-server && rm -rf /var/lib/apt/lists/*

# Copy configuration
COPY conf/redis.conf /etc/redis/redis.conf

# Expose Redis port
EXPOSE 6379

# Start Redis with the custom configuration
CMD ["redis-server", "/etc/redis/redis.conf", "--protected-mode no"]
