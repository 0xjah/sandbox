# logger/

Contains logging and capture tools used to collect network traffic and artifacts.

Important files
- `Dockerfile` — image used for logging/capture container (includes `tcpdump` and `tshark`).
- `capture.sh` — entrypoint that runs both `tcpdump` (raw pcap) and `tshark` (JSON parsed output).

Usage
- Run via docker-compose (service named `logger`) or build and run the image directly.

Environment variables / CLI-friendly options
- `OUT_DIR` : output directory inside container (default `/var/log/sandbox`).
- `INTERFACE` : capture interface (default `any`).
- `PCAP_FILE` : path to raw pcap file (default `$OUT_DIR/capture.pcap`).
- `JSON_FILE` : path to JSON parsed output (default `$OUT_DIR/packets.json`).
- `PCAP_FILTER` : BPF capture filter passed to `tcpdump` (optional).
- `TSHARK_DISPLAY_FILTER` : display filter passed to `tshark` (optional).

Example (docker run):
```bash
docker build -t sandbox-logger ./logger
docker run --cap-add=NET_ADMIN --rm -v $(pwd)/tmp:/var/log/sandbox sandbox-logger
```

Example (docker-compose):
```yaml
services:
  logger:
    build: ./logger
    cap_add:
      - NET_ADMIN
    volumes:
      - ./tmp:/var/log/sandbox
```

Notes
- `tcpdump` writes a raw `pcap` file; `tshark` writes a live JSON file suitable for downstream processing.
- Container requires elevated capabilities to capture network traffic (`NET_ADMIN` or `CAP_NET_RAW`).
- Clean up `tmp/` regularly — packet captures can grow large.
