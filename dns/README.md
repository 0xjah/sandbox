# dns/

Holds DNS-related configuration and blocklists used by the sandbox DNS service.

Important files
- `blocklist.conf` — dnsmasq-friendly blocklist entries and usage notes.
- `blocklist.conf` is formatted with `address=/domain/0.0.0.0` entries by default.

Usage
- To apply changes when using dnsmasq inside a container, restart the dns service or the container:
  ```bash
  docker compose restart <dns-service-name>
  ```

Notes
- Replace example domains in `blocklist.conf` with your production/test targets.
- If you want hosts-style entries, use the hosts section inside `blocklist.conf` or convert lists to your desired format.
