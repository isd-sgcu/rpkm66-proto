.PHONY: go

go:
	mkdir -p go
	-cd go; go mod init github.com/isd-sgcu/rpkm66-go-proto
	perl scripts/go/go.pl
	cd go; go mod tidy

	# absoluate package
	# find . -name *.proto -exec protoc --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative --proto_path=. --go_out=go --go-grpc_out=go {} \;

rust:
	mkdir -p rust
	-cd rust && cargo init --lib --name rpkm66-rust-proto && cargo add tonic prost && cargo add serde --features derive
	cd scripts/rust && cargo build --release && cp target/release/rust ../../rust-gen-cli
	-./rust-gen-cli -s . -o rust/src

.PHONY: go rust