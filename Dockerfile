# Use the official Nginx image as the base image
FROM nginx

# Copy the HTML file from the host into the container
COPY index.html /usr/share/nginx/html

# The default port Nginx listens on is 80, so we need to expose that port
EXPOSE 80
