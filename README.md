# Studyjam Sandbox

Small local sandbox orchestrated with Docker Compose. It provides lightweight components for experimenting with browser automation, local DNS filtering, packet capture, and a small proxy/logger pipeline.

Quick start
- Build and run the compose stack:
  ```bash
  docker compose up --build
  ```

Key directories
- `browser/` — Browser container and entrypoint for automated browsing tests.
- `dns/` — DNS configuration and blocklists (dnsmasq-style `blocklist.conf`).
- `logger/` — Capture and store logs/pcaps.
- `proxy/` — Lightweight proxy service used in the compose network.
- `scripts/` — Helper scripts for logs, resetting environment, etc.
- `tmp/` — Ephemeral files (e.g. `capture.pcap`).
- `yara_rules/` — YARA rules used for file/traffic inspection.

Notes
- Keep `dns/blocklist.conf` updated and version-controlled.
- Use the per-directory README files for specific build/run instructions.
