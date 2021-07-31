# Docker with multiple services

This repo is a small exploration to understand how is possible to create a container with multiple services with Docker.

This project has two services:

- `webserver`: that has a simple webserver built with Fastify
- `jobserver`: that has a simple service to trigger "tick!" every second with Nodecron

The idea is to test the approaches that we have to use Dockerize this system with multiple services.

## Approaches
These are the following approaches that I could identify:

- One Dockerfile for each service + Docker compose
- One Dockerfile for all services + Docker compose

### Each service has its Dockerfile + Docker compose
This approach is based on the concept that each container should have just one service. Actually, Docker recommends that we separate areas of concerns by using one service per container (see more [here](https://docs.docker.com/config/containers/multi-service_container/)).

So, we would have a `docker` folder with:

- `webserver`: folder
 - `Dockerfile`: containing the image for web service
- `jobserver`: folder
 - `Dockerfile`: containing the image for job service

Then, the docker compose will serve the two images. Also, the docker compose could be used to serve any other dependency or system (like DB, Redis, MySQL, NGINX, Apache, etc.)

### One Dockerfile for all services + Docker Compose
This approach is based on the idea that we don't want to follow the recomendations from Docker and we really think that we should have just one Dockerfile.

So, we would have:

- `Dockerfile`: that builds one image with two services (webserver + jobserver)
- `docker-compose`: to build this image + anything else
- `wrapper_script.sh`: the script that will start the services

## Testing Approaches
Then, it's possible to test the approaches. The requirements are the following:

- The app should log "tick!" every second 
- The localhost:3000 should show "{ "hello": "world"}"

### Each service has its Dockerfile + Docker compose
To test this approach just run `docker-compose up` and see if the requirements above are fulfilled.

### One Dockerfile for all services + Docker compose
To test this approach just run 

## Conclusion
I had a fun time by making this exploration. After all, I think we should follow what Docker recommends and we should avoid one Dockerfile that has several services inside somehow. Also, multiple Dockerfiles is more organized and clear!
