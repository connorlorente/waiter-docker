#!/bin/bash

# Get the wait time from the environment variable or use a default value
WAIT_TIME=${WAIT_TIME:-10}
STOP_TIME=${STOP_TIME:-0}

# Wait for the specified time
sleep $WAIT_TIME

echo "Container is now healthy!"
touch /tmp/healthy  # create a file to indicate that the container is healthy


# stop the container after a certain time if the STOP_TIME environment variable is set
if [ $STOP_TIME -gt 0 ]; then
  echo "Container running. Waiting for $STOP_TIME seconds before stopping..."
  sleep $STOP_TIME

  echo "Container stopping..."
  exit 1
fi


  echo "STOP_TIME is not set. Container will keep running."
  tail -f /dev/null



