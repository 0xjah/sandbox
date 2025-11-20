FROM alpine:3.18
RUN apk add --no-cache tcpdump
COPY capture.sh /usr/local/bin/capture.sh
RUN chmod +x /usr/local/bin/capture.sh
ENTRYPOINT ["/usr/local/bin/capture.sh"]
