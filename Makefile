all:
	mkdir dist
	find . -name *.proto -exec protoc --go_out=dist --go-grpc_out=dist {} \;