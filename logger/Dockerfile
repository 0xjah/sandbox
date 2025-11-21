FROM debian:stable-slim

# Use Debian slim to get a reliable `tshark` package across architectures.
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
	 tcpdump \
	 tshark \
	 ca-certificates \
 && rm -rf /var/lib/apt/lists/*

COPY capture.sh /usr/local/bin/capture.sh
RUN chmod +x /usr/local/bin/capture.sh

ENTRYPOINT ["/usr/local/bin/capture.sh"]
