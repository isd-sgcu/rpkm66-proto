all:
	find . -name *.proto -exec protoc --go_out=. --go-grpc_out=. {} \;