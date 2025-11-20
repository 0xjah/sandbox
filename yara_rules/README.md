# yara_rules/

YARA rule files used to detect or classify files/artifacts found during analysis.

Files
- `example.yar` — sample YARA rule demonstrating basic matching.

Usage
- Test a file against rules locally:
  ```bash
  yara -r yara_rules/example.yar /path/to/file
  ```

Notes
- Keep rules small and well-documented. Use `-r` to recurse rule directories when scanning.
