# Set the base image to Debian Bullseye
FROM debian:bullseye

# Update the package repository and install required packages (wget, curl, PHP-FPM, PHP MySQL extension)
RUN apt-get update && apt-get install -y wget curl php7.4-fpm php7.4-mysqli

# Copy the entrypoint script to the container
COPY /tools/entrypoint.sh /tools/entrypoint.sh

# Grant execute permission to the entrypoint script
RUN chmod +x /tools/entrypoint.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Set the entrypoint to the entrypoint script
ENTRYPOINT [ "/tools/entrypoint.sh" ]
