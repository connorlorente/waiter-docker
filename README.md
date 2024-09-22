# Waiter Docker - A Docker Container for Enforcing Dependency Wait Times

**Is your file sharing service, media server, or Docker container dependent on network drives or other resources that need to be ready before starting?** If so, Waiter Docker is the solution. This container automatically waits for these dependencies to become available before launching your services, ensuring smooth and efficient operation and correct startup order.

## What Can Waiter Docker Do?

Waiter Docker offers two modes: **TIMED** and **WATCH**.

### TIMED Mode

```yaml
environment:
  - WAIT_TIME=5
  - MODE=TIMED
  - STOP_TIME=10
```

In this basic mode, the Docker container starts, waits for **5** seconds, and then reports as healthy. This allows you to use the **depends_on** directive in your Docker Compose file to delay the start of other containers until this one is ready. The container will then terminate after a specified stop time, which is set to **10** seconds in this example.

### WATCH Mode

```yaml
environment:
  - WAIT_TIME=5
  - MODE=WATCH
  - STOP_TIME=10
  - WATCH_FILE=/filecheckpath/testfile.txt
```

In this mode, the Docker container checks for the file **/filecheckpath/testfile.txt** every **5** seconds. If the file is not found within the first **10** seconds, the container reports as unhealthy. This status remains until the file is located, at which point the container reports as healthy. This allows you to use the **depends_on** directive in your Docker Compose file to delay the start of other containers until the required file is available.

WATCH mode is particularly useful for scenarios where containers rely on files stored on network drives or NAS devices, such as media servers or company file sharing services. To implement this setup, you'll need to use volumes in your Docker Compose file to mount the directory containing the file.

### WATCH Mode Example with Volume Mounting

```yaml
version: '4'
services:
  wait-docker:
    build: .
    container_name: Wait-Docker
    environment:
      # Wait time in TIMED mode. If you use WATCH mode, this will check for the watch file for this time period, repeatedly, until the file is found. In WATCH mode, the container will report UNHEALTHY after this time period until the file is found
      - WAIT_TIME=5
      # Supported modes are WATCH and TIMED - WATCH will monitor for a file existing, timed is just a delay/timer
      - MODE=WATCH
      # Time in seconds to mark as healthy until the docker self terminates. Set to 0 to disable this behavior
      - STOP_TIME=10
      # Watch file to check for, not needed if using TIMED mode
      - WATCH_FILE=/filecheckpath/testfile.txt
    volumes:
      # The entire volumes section is only required if you are using WATCH mode
      # e.g /root:/filecheckpath - Then setting WATCH_FILE to /filecheckpath/testfile.txt
      # would check for testfile.txt in /root/testfile.txt on the host machine
      # Useful for checking that network drives or temporary files are available before starting other dockers
      - /host/path/here:/container/path/here
    healthcheck:
      test: ["CMD", "test", "-f", "/tmp/healthy"]
      interval: 5s
      timeout: 5s
      retries: 3
      start_period: 20s
```

## Manual Build Instructions

**Note:** Manual build instructions may be outdated and are intended for developers only. For a more user-friendly experience, we highly recommend using the Docker Compose file **(docker-compose.yml)**.

### Testing the Image

```bash
docker-compose up --build
```

### Building the Image (for testing)

```bash
docker build -t waiter-image .
docker tag waiter-image connorc419/waiter:0.2
docker images
docker push connorc419/waiter:0.1
tag waiter-image connorc419/waiter:latest
```

### Building the Image (for deployment)

```bash
docker buildx create --name mybuilder --use
docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx build --platform linux/amd64,linux/arm64 -t connorc419/waiter:0.4 --push .
docker buildx build --platform linux/amd64,linux/arm64 -t connorc419/waiter:latest --push .
docker buildx imagetools inspect connorc419/waiter:0.3
```
