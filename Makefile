go:
	mkdir go
	find . -name *.proto -exec protoc --go_out=go --go-grpc_out=go {} \;
	cd go; go mod init github.com/isd-sgcu/rpkm66-go-proto; go mod tidy