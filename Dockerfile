FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y nano curl wget aria2 ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /movies

COPY aria2.conf /aria2.conf
COPY run_aria2.sh /usr/local/bin/run_aria2.sh
RUN chmod +x /usr/local/bin/run_aria2.sh

VOLUME ["/movies"]

ENTRYPOINT ["/usr/local/bin/run_aria2.sh"]
