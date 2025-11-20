#!/bin/bash
set -e
docker compose down --volumes --remove-orphans
# optionally prune images, networks (use with caution)
docker volume rm $(docker volume ls -qf name=sandbox_logs) || true
docker network rm sandbox-net || true
# recreate network
docker network create sandbox-net
