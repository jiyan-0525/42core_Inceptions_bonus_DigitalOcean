FROM debian:bullseye

RUN apt-get update && apt-get install -y python3 && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY html/ /var/www/html/

EXPOSE 8081

CMD ["python3", "-m", "http.server", "8081"]
