FROM golang:1.21-alpine AS builder

WORKDIR /usr/local/src

RUN apk --no-cache add bash git make gcc gettext musl-dev

COPY ["./go.mod", "./go.sum", "./"]
RUN go mod download

COPY api ./
RUN go build -o ./bin/api ./cmd/server/main.go
