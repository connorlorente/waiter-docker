#!/bin/bash

# Get the wait time from the environment variable or use a default value
WAIT_TIME=${WAIT_TIME:-10}
STOP_TIME=${STOP_TIME:-0}
MODE=${MODE:-"TIMED"}


if [ $MODE == "TIMED" ]; then
  echo "Container will wait for $WAIT_TIME seconds before becoming healthy."
  sleep $WAIT_TIME  
  echo "Container is now healthy!"

  # create a file to indicate that the container is healthy
  touch /tmp/healthy

  # stop the container after a certain time if the STOP_TIME environment variable is set
  if [ $STOP_TIME -gt 0 ]; then
    echo "Container running. Waiting for $STOP_TIME seconds before stopping..."
    sleep $STOP_TIME

    echo "Container stopping..."
    exit 1
  fi
  
  echo "Container will keep running, as the STOP_TIME environment variable is not set."
  tail -f /dev/null
fi

