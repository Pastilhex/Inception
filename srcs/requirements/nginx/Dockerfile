# Set the base image to Debian Bullseye
FROM debian:bullseye

# Update the package repository
RUN apt update

# Install the Nginx web server
RUN apt install nginx -y

# Create a directory to store SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Install the OpenSSL package to generate SSL certificates
RUN apt install openssl -y

# Generate a self-signed SSL key pair using OpenSSL
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/inception.key -out /etc/nginx/ssl/inception.crt -subj "/C=PT/ST=OPO/L=Porto/O=42"

# Copy the Nginx configuration file to the sites-available directory
COPY conf/ialves-m.conf /etc/nginx/sites-available

# Create a symbolic link to enable the site in the sites-enabled directory
RUN ln -s /etc/nginx/sites-available/ialves-m.conf /etc/nginx/sites-enabled/

# Expose port 443 for external access
EXPOSE 443

# Set the default command to start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
