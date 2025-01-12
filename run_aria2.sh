#!/bin/bash

# Check if a torrent link is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: docker run --rm -it -v \$(pwd):/movies aria2c run_aria2.sh [http://torrent_link.torrent]"
    exit 1
fi

TORRENT_URL="$1"
TORRENT_FILE=$(basename "$TORRENT_URL")

#wget --no-check-certificate "$TORRENT_URL" -O "$TORRENT_FILE"
curl -L -s --doh-url https://cloudflare-dns.com/dns-query -k "$TORRENT_URL" -o "$TORRENT_FILE"

if [ $? -ne 0 ]; then
    echo "Error: Failed to download torrent file from $TORRENT_URL."
    exit 1
fi

# Deleting dht.dat to resolve DHT routing table loading error in aria2
[ -f /root/.cache/aria2/dht.dat ] && rm /root/.cache/aria2/dht.dat

# Run aria2c with the downloaded torrent file
aria2c -c --conf-path=aria2.conf "$TORRENT_FILE" --dir=/movies --file-allocation=none
