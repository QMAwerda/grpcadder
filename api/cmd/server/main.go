package main

import (
	"log"
	"net"

	"github.com/QMAwerda/grpcadder/api/pkg/adder"
	"github.com/QMAwerda/grpcadder/api/pkg/api"
	"google.golang.org/grpc"
)

func main() {
	s := grpc.NewServer()
	srv := &adder.GRPCServer{}
	api.RegisterAdderServer(s, srv)

	l, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatal(err)
	}

	if err := s.Serve(l); err != nil {
		log.Fatal(err)
	}
}
