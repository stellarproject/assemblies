GOOS?=linux
GOARCH?=amd64
COMMIT=`git rev-parse --short HEAD`
NAMESPACE?=stellarproject
IMAGE_NAMESPACE?=$(NAMESPACE)
CWD=$(PWD)
VAB_ARGS?=
ASSEMBLIES=$(shell find . -maxdepth 1 -type d \( ! -name ".git" \) \( ! -name "." \) -exec basename {} \; )

all: $(ASSEMBLIES)

$(ASSEMBLIES):
	@echo " -> building $@"
	@cd $@; vab build -r docker.io/${IMAGE_NAMESPACE}/$@:latest ${VAB_ARGS}

build-kernel:
	@buildctl build --frontend=dockerfile.v0 --frontend-opt filename=Dockerfile --local context=. --local dockerfile=. --progress plain --exporter=local --exporter-opt output=.

clean:
	@rm -rf ./*.deb

.PHONY: kernel clean $(ASSEMBLIES)
