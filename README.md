# Test the image
    # docker-compose up --build

# Build the image (for testing)
    # docker build -t waiter-image .
    # docker tag waiter-image connorc419/waiter:0.2
    # docker images
    # docker push connorc419/waiter:0.1
    # tag waiter-image connorc419/waiter:latest


# Build the image (for deployment)
    # docker buildx create --name mybuilder --use
    # docker run --privileged --rm tonistiigi/binfmt --install all
    # docker buildx build --platform linux/amd64,linux/arm64 -t connorc419/waiter:0.4 --push .
    # docker buildx build --platform linux/amd64,linux/arm64 -t connorc419/waiter:latest --push .
    # docker buildx imagetools inspect connorc419/waiter:0.3
