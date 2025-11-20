# scripts/

Helper scripts used to manage the sandbox.

Files
- `logs.sh` — helper to fetch or tail logs from containers or files.
- `reset.sh` — resets state (clean volumes, tmp files) to a fresh state.

Usage examples
- Tail compose logs:
  ```bash
  ./logs.sh
  ```
- Reset the sandbox state (be careful — this can drop data):
  ```bash
  ./reset.sh
  ```

Notes
- Review scripts before running. Some actions may remove local files or Docker volumes.
