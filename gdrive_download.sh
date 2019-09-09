#!/bin/sh
# source: https://gist.github.com/guysmoilov/ff68ef3416f99bd74a3c431b4f4c739a
# Usage: gdrive_download 123-abc ./output.zip
download_file() {
    CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://drive.google.com/uc?export=download&id=$1" -O- | sed -En 's/.*confirm=([0-9A-Za-z_]+).*/\1/p')
    wget --load-cookies /tmp/cookies.txt "https://drive.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
    rm -f /tmp/cookies.txt
}

download_dir() {
    downloads_dir=$1
    if [ -d $downloads_dir ]
    then
        echo "$downloads_dir found."
    else
        echo "$downloads_dir does NOT found."
        echo "Creating $downloads_dir..."
        mkdir -p $downloads_dir
        echo "$downloads_dir created."
    fi
}

# parse commandline input
file_id=$1
downloads_dir=$HOME/Downloads
output_file_name=$downloads_dir/$2
download_dir $downloads_dir
download_file $file_id $output_file_name
