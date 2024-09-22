FROM --platform=$TARGETPLATFORM alpine:3.14
#FROM alpine:3.14

# Install necessary packages
RUN apk add --no-cache bash

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable and ensure it has Unix line endings
RUN chmod +x /entrypoint.sh && \
    sed -i 's/\r$//' /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
