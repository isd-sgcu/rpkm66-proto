all:
	mkdir dist
	find . -name *.proto -exec protoc --go_out=dist --go-grpc_out=--go-grpc_out=require_unimplemented_servers=false:dist {} \;