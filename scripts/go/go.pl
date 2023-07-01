#!/usr/bin/perl

my $all_proto_files = `find * -name *.proto -type f`;
my @proto_files = split /\R/, $all_proto_files;
my @mapped = map { 
    (my $go_package = $_) =~ s/\/\w*\.proto//;

    ("--go_opt=M$_=github.com/isd-sgcu/rpkm66-go-proto/$go_package", "--go-grpc_opt=M$_=github.com/isd-sgcu/rpkm66-go-proto/$go_package");
} @proto_files;

my @cmd_prefix = (
    "protoc",
    "--go_out=go",
    "--go-grpc_out=go",
    "--go_opt=module=github.com/isd-sgcu/rpkm66-go-proto",
    "--go-grpc_opt=module=github.com/isd-sgcu/rpkm66-go-proto",
    "--proto_path=.",
    @mapped
);

my $cmd = (join " ", @cmd_prefix) . " " . (join " ", @proto_files);
print $cmd;
system $cmd;
