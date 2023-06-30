.PHONY: go

go:
	mkdir -p go
	-cd go; go mod init github.com/isd-sgcu/rpkm66-go-proto
	find . -name *.proto -exec protoc --go_opt=module=github.com/isd-sgcu/rpkm66-go-proto --go-grpc_opt=module=github.com/isd-sgcu/rpkm66-go-proto --proto_path=. --go_out=go --go-grpc_out=go {} \;
	cd go; go mod tidy