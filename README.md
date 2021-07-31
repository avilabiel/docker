# Docker with multiple services

This repo is a small exploration to understand how is possible to create a container with multiple services in Docker.

This project has two services:

- `webserver`: that has a simple webserver built with Fastify
- `jobserver`: that has a simple service to trigger "tick!" every second with Nodecron

The idea is to test the approaches that we have to Dockerize this system with multiple services.

## Approaches

These are the following approaches that I could identify:

- Each service has its Dockerfile + Docker compose
- One Dockerfile for all services

### Each service has its Dockerfile + Docker compose

This approach is based on the concept that each container should have just one service. Actually, Docker recommends that we separate areas of concerns by using one service per container (see more [here](https://docs.docker.com/config/containers/multi-service_container/)).

So, we would have a `docker` folder with:

- `webserver`: folder
- `Dockerfile`: containing the image for web service
- `jobserver`: folder
- `Dockerfile`: containing the image for job service
- `docker-compose`: to get each container and run them

Then, the docker compose will serve the two images. Also, the docker compose could be used to serve any other dependency or system (like DB, Redis, MySQL, NGINX, Apache, etc.)

### One Dockerfile for all services

This approach is based on the idea that we don't want to follow the recomendations from Docker and we really think that we should have just one Dockerfile.

So, we would have:

- `Dockerfile`: that builds one image with two services (webserver + jobserver)
- `wrapper_script.sh`: the script that will start the services

## Testing Approaches

It's possible to test the approaches. The requirements are the following:

- The app should log "tick!" every second
- The localhost:3000 should show "{ "hello": "world" }"

### Each service has its Dockerfile + Docker compose

To test this approach just run `docker-compose up` and see if the requirements above are fulfilled.

### One Dockerfile for all services

To test this approach just follow the steps below:

1. `chmod +x wrapper_script.sh`: to enable Docker to execute it
2. `docker build -t my-container .`: to build the container with two services
3. `docker run -p 3000:3000 my-container`: to run the container on port 3000
4. See if the requirements above are fulfilled ("tick!" + accessing localhost:3000)

## Conclusion

I had a fun time making this exploration. After all, I think we should follow what Docker recommends by avoiding one Dockerfile that has several services inside. Besides, when each service has its own Dockerfile we avoid the usage of a `wrapper_script.sh` to start the services in the background. So, **each service having its own Dockerfile + Docker Compose** is simpler!

Also, I had some trouble closing the container with multiple services. Probably Docker doesn't know how to handle well with multiple services on the same container. That's why Docker runs just one `CMD` command in a Dockerfile, the last `CMD` overrides the previous ones.

So, after testing I suggest always go with **each service having its own Dockerfile + Docker Compose**.
