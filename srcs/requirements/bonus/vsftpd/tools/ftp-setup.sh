#!/bin/bash
set -e

# Create FTP user from environment variables
if [ -n "$FTP_USER" ] && [ -n "$FTP_PASS" ]; then
    echo "Creating FTP user: $FTP_USER"
    useradd -m -s /bin/bash "$FTP_USER" || true
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    
    # Ensure home directory permissions
    mkdir -p /var/www/html
    chown -R "$FTP_USER:$FTP_USER" /var/www/html
fi

# Create secure chroot dir
mkdir -p /var/run/vsftpd/empty

# Start vsftpd
echo "Starting vsftpd..."
exec vsftpd /etc/vsftpd.conf
