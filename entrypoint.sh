#!/bin/bash

# Get the wait time from the environment variable or use a default value
WAIT_TIME=${WAIT_TIME:-10}
STOP_TIME=${STOP_TIME:-0}
MODE=${MODE:-"TIMED"}
WATCH_FILE=${WATCH_FILE:-""}


if [ $MODE == "TIMED" ]; then
  echo "Running in TIMED mode."
  echo "Container will wait for $WAIT_TIME seconds before becoming healthy."
  sleep $WAIT_TIME  
  echo "Container is now healthy!"

  # create a file to indicate that the container is healthy
  touch /tmp/healthy
fi

if [ $MODE == "WATCH" ]; then
  echo "Running in WATCH mode."

  # check if the file exists
  echo "Checking if the file $WATCH_FILE exists..."

  while [ ! -f $WATCH_FILE ]; do
    echo "File not found. Waiting for $WAIT_TIME seconds..."
    sleep $WAIT_TIME
  done

  # create a file to indicate that the container is healthy
  touch /tmp/healthy
  echo "File found. Container is now healthy!"
fi


# stop the container after a certain time if the STOP_TIME environment variable is set
if [ $STOP_TIME -gt 0 ]; then
  echo "Container running. Waiting for $STOP_TIME seconds before stopping..."
  sleep $STOP_TIME

  echo "Container stopping..."
  exit 1
fi

echo "Container will keep running, as the STOP_TIME environment variable is not set."
tail -f /dev/null
