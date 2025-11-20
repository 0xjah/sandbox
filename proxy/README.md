# proxy/

Lightweight proxy service used in the sandbox network for intercepting traffic or applying simple routing policies.

Important files
- `Dockerfile` — defines the proxy container image.

Usage
- The proxy is intended to run inside the compose network; modify the `docker-compose.yml` if you need custom ports or bindings.

Notes
- If you add configuration files for the proxy, document them here and mount them into the container via compose volumes.
