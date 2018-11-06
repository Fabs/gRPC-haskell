DOCKERFILE_VERSION := $(shell git log --format=%H Dockerfile | head -1)
DOCKER_IMAGE := grpc-haskell:$(DOCKERFILE_VERSION)

all: build

build-docker:
	git diff --exit-code Dockerfile
	docker build -t $(DOCKER_IMAGE) .

build: build-docker
	stack build --docker-repo=$(DOCKER_IMAGE)
