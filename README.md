# drone-docker

[![Build](https://travis-ci.org/themaz/drone-docker-tagger.svg?branch=master)](https://travis-ci.org/themaz/drone-docker-tagger)
[![Go Doc](https://godoc.org/github.com/themaz/drone-docker-tagger?status.svg)](http://godoc.org/github.com/themaz/drone-docker-tagger)
[![Go Report](https://goreportcard.com/badge/github.com/themaz/drone-docker-tagger)](https://goreportcard.com/report/github.com/themaz/drone-docker-tagger)

This Drone plugin takes in a `source_image` and creates one or more new `tags` and pushes it to the Docker repo specified. See example usage below.

## Example usage:

```
pipeline:
  build:
    image: themaz/drone-docker-tagger
    source_image: source/image:tag
    registry: <your registry>
    username: ${REGISTRY_USERNAME}
    password: ${REGISTRY_PASSWORD}
    tags:
      - tag1
      - tag2
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:rw
```

## Build

Build the binary with the following commands:

```
go build
go test
```

## Docker

Build the docker image with the following commands:

```
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -tags netgo
docker build --rm=true -t themaz/drone-docker-tagger .
```

Please note incorrectly building the image for the correct x64 linux and with
GCO disabled will result in an error when running the Docker image:

```
docker: Error response from daemon: Container command
'/bin/drone-docker-tagger' not found or does not exist..
```

## Usage

Execute from the working directory:

```
docker run --rm \
  -e PLUGIN_TAG=latest \
  -e PLUGIN_SOURCE_IMAGE=octocat/hello-world \
  -e PLUGIN_TAGS=tag1,tag2 \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  --privileged \
  themaz/drone-docker-tagger --dry-run
```
