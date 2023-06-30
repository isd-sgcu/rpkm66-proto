.PHONY: go

go:
	mkdir -p go
	-cd go; go mod init github.com/isd-sgcu/rpkm66-go-proto
	perl scripts/go.pl
	cd go; go mod tidy

	# absoluate package
	# find . -name *.proto -exec protoc --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative --proto_path=. --go_out=go --go-grpc_out=go {} \;