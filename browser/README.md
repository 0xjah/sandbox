# browser/

Contains the browser container used for automated browsing or testing within the sandbox.

Important files
- `Dockerfile` — Container image definition for the browser environment.
- `entrypoint.sh` — Container entrypoint; performs startup tasks.

Usage
- Build/run with docker compose (the top-level `docker-compose.yml` wires this container into the sandbox network).

Notes
- If you modify the `Dockerfile`, rebuild images with `docker compose build browser`.
- The container expects to run inside the sandbox compose network; avoid running it standalone unless you adapt networking and volumes.
