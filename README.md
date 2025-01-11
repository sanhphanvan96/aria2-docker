# Aria2 Super High-Speed Torrent Downloader

This repository provides a Docker setup for downloading torrents at `maximum speed` using [aria2c](https://aria2.github.io/) with a custom configuration and bash script.

**Note**: *This project is configured to download torrent files at the maximum speed supported by your network.*

## Features
- Uses a lightweight Ubuntu base image.
- Downloads torrent files and their contents with `aria2c`.
- Supports custom configurations via `aria2.conf`.
- Outputs downloaded files to a shared volume (`/movies`).

  ## Prerequisites
- Docker installed on your machine.

## Usage

### 1. Build the Docker Image
```bash
docker build -t aria2c .
```

### 2. Run the Container
To download a torrent, run the container with the required arguments:
```bash
docker run --rm -it -v $(pwd)/movies:/movies aria2c [http://torrent_link.torrent]
```
- Replace `[http://torrent_link.torrent]` with the actual torrent URL.
- The downloaded files will be saved in the current directory (`$(pwd)/movies`).
