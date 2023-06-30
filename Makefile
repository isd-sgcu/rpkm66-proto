.PHONY: go

go:
	mkdir -p go
	-cd go; go mod init github.com/isd-sgcu/rpkm66-go-proto
	find . -name *.proto -exec protoc --go_out=go --go-grpc_out=go --go_opt=module=github.com/isd-sgcu/rpkm66-go-proto {} \;
	cd go; go mod tidy