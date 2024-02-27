PROTOPATH ?= api/proto
IMAGE ?= grpcadder
TAG ?= v1

.DEFAULT_GOAL := build

.PHONY: build
build:
	@go build -v ./api/cmd/server

.PHONY: protoc
protoc:
	@protoc --go_out=./api/pkg $(PROTOPATH)/adder.proto \
    --go-grpc_out=./api/pkg $(PROTOPATH)/adder.proto \

.PHONY: dist-clean 
dist-clean: 
	@find ./api/pkg/api -name "*.pb.*" | xargs rm -rf

.PHONY: protoc-update
protoc-update: dist-clean protoc

.PHONY: docker-build
docker-build:
	docker build -t $(IMAGE):$(TAG) ./

.PHONY: docker-run
docker-run: docker-build
	docker run $(IMAGE):$(TAG)

.PHONY: docker-publish
docker-publish:
	docker push $(IMAGE):$(TAG)
