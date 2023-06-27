all:
	find . -name *.proto -exec protoc --go_out=dist --go-grpc_out=dist {} \;