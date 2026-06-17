#!/bin/bash

set -e

echo "Starting MariaDB initialization..."

# Initialize MySQL data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null
fi

# Start the server (no networking for setup)
echo "Starting temporary MariaDB server for setup..."
mysqld --skip-networking --socket=/run/mysqld/mysqld.sock --user=mysql &
pid="$!"

# Wait for MariaDB to be ready (Try both with and without password)
echo "Waiting for MariaDB to be ready..."
until mysqladmin --socket=/run/mysqld/mysqld.sock ping >/dev/null 2>&1 || \
      mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" ping >/dev/null 2>&1; do
    sleep 1
done
<<<<<<< HEAD
echo "MariaDB is ready!"

# Run setup SQL: create database and users safely
echo "Running setup SQL..."
# Try running without password first (first boot), if that fails, use the root password (subsequent boots)
if mysql --socket=/run/mysqld/mysqld.sock -u root -e "STATUS" >/dev/null 2>&1; then
    mysql --socket=/run/mysqld/mysqld.sock -u root << EOF
=======

if mysqladmin --socket=/run/mysqld/mysqld.sock -u root status >/dev/null 2>&1; then
    # Root hat noch kein Passwort oder nutzt unix_socket
    MYSQL_CMD="mysql --socket=/run/mysqld/mysqld.sock -u root"
else
    # Root hat bereits ein Passwort
    MYSQL_CMD="mysql --socket=/run/mysqld/mysqld.sock -u root -p${MYSQL_ROOT_PASSWORD}"
fi

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    $MYSQL_CMD <<EOF
>>>>>>> 8d6f6e3 (addbons)
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
else
    echo "Root password already set, running setup with credentials..."
    mysql --socket=/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" << EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
fi

# Shut down temporary server
echo "Shutting down temporary MariaDB..."
mysqladmin --socket=/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Wait for shutdown
wait "$pid" || true

# Start MariaDB normally (with networking)
echo "Initialization complete. Starting MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql --socket=/run/mysqld/mysqld.sock