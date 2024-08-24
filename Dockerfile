# Use the official Rust image as the base image
FROM rust:latest as builder

# Install Zola
RUN cargo install zola

# Create a new stage with a minimal image
FROM debian:buster-slim

# Copy Zola binary from the builder stage
COPY --from=builder /usr/local/cargo/bin/zola /usr/local/bin/zola

# Set the working directory in the container
WORKDIR /app

# Copy the content of the local directory to the working directory
COPY . .

# Build the Zola site
RUN zola build

# Expose port 8080
EXPOSE 8080

# Command to run the application
CMD ["zola", "serve", "--interface", "0.0.0.0", "--port", "8080"]
