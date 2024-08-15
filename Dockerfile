# Use the official Nginx image as the base image
FROM nginx

# Copy all files from the current directory into the container
COPY . /usr/share/nginx/html/

# The default port Nginx listens on is 80, so we need to expose that port
EXPOSE 80