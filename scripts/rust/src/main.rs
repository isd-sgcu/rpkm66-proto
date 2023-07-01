use std::path::PathBuf;

use clap::Parser;

#[derive(Parser, Debug)]
#[command(author, version, about, long_about = None)]
struct Args {
    /// Proto output
    #[arg(short, long)]
    output_dir: PathBuf,

    /// proto source file
    #[arg(short, long)]
    source_dir: PathBuf,
}

fn main() {
    let args = Args::parse();

    let Args {
        output_dir,
        source_dir,
    } = args;

    let mut proto_files = Vec::new();
    let mut include_dirs = Vec::new();

    for entry in walkdir::WalkDir::new(source_dir.clone()).into_iter() {
        let entry = match entry {
            Ok(x) => x,
            Err(e) => {
                println!("Error getting entry: {e}");
                continue;
            }
        };

        let is_file = entry.file_type().is_file();
        let file_path = entry.into_path();

        let is_proto = file_path
            .extension()
            .and_then(|str| str.to_str())
            .map(|str| str.ends_with("proto"))
            .unwrap_or(false);

        if is_file && is_proto {
            let dir_name = match file_path.parent() {
                Some(x) => x.to_owned(),
                None => {
                    println!("Unable to get parent of `{file_path:?}`");
                    continue;
                }
            };
            proto_files.push(file_path.to_owned());
            include_dirs.push(dir_name);
        }
    }

    println!("proto_files: {proto_files:?}\n");
    println!("output_dir: {output_dir:?}");

    tonic_build::configure()
        .build_client(true)
        .build_server(true)
        .build_transport(true)
        .include_file("lib.rs")
        .out_dir(output_dir)
        .compile(&proto_files, &["."])
        .unwrap();
}
