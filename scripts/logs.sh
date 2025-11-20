#!/bin/bash
set -e
mkdir -p analysis
for f in logs/*; do
  [ -f "$f" ] || continue
  sha256sum "$f" >> analysis/hashes.txt
  if command -v yara >/dev/null 2>&1; then
    yara -r yara_rules/ "$f" >> analysis/yara_results.txt || true
  fi
done
echo "Analysis saved in ./analysis"
