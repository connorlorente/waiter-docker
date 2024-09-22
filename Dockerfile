#FROM alpine:3.14
FROM --platform=$TARGETPLATFORM alpine:3.14

# Install necessary packages
RUN apk add --no-cache bash

# Install Docker CLI to allow the action to interact with the Docker daemon
# RUN apk add --no-cache bash docker-cli

#create a test file to see if the image is working
RUN echo "Hello, World!" > /test.txt

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh



# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Test the image
    # docker-compose up --build

# Build the image
    # docker build -t waiter-image .
    # docker tag waiter-image connorc419/waiter:0.2
    # docker images
    # docker push connorc419/waiter:0.1
    # tag waiter-image connorc419/waiter:latest


# Build for arm
    # docker buildx create --name mybuilder --use
    # docker run --privileged --rm tonistiigi/binfmt --install all
    # docker buildx build --platform linux/amd64,linux/arm64 -t connorc419/waiter:0.3 --push .
    # docker buildx imagetools inspect connorc419/waiter:0.3


