# logger/

Contains logging and capture tools used to collect network traffic and artifacts.

Important files
- `Dockerfile` — image used for logging/capture container.
- `capture.sh` — helper to capture network traffic into `tmp/capture.pcap`.

Usage
- Run via docker compose or use the `capture.sh` script directly (may require sudo):
  ```bash
  ./capture.sh -i <interface> -o ../tmp/capture.pcap
  ```

Notes
- Captured pcaps are stored in `tmp/` by default. Clean up large pcaps regularly.
