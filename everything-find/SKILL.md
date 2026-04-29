---
name: everything-find
description: "Fast file/directory search on Windows using Everything's es.exe CLI. Use when users ask for global file lookup, pattern search across large scopes, executable location, or search speed comparisons. Not intended for searching within the current working directory. Trigger semantics: 'find', 'search', 'where is', 'locate'."
---

# everything-find

Use Everything indexed search on Windows for fast file/directory lookup (much faster than native search).

## Usage

Use `es.exe` for indexed file search on Windows. Both `es.exe` and `everything.exe` are in the `scripts` subdirectory under this skill directory.

## Quick Start

1. Before use, verify both `es.exe` and `everything.exe` are present. If not, download them from <https://www.voidtools.com/downloads/>.
2. If `es.exe` returns code `8`, start `everything.exe` and retry.
3. Run searches with `es.exe`, using only the options needed for the user request.

## Common Patterns

| Goal | Pattern |
| ---- | ------- |
| Find file by name | `es.exe <keyword>` |
| Find directories only | `es.exe <keyword> -ad` |
| Find files only | `es.exe <keyword> /a-d` |
| Limit result count | `es.exe <keyword> -n <count>` |
| Regex match | `es.exe -r "<pattern>"` |
| Case-sensitive match | `es.exe -i <keyword>` |
| Search inside a path | `es.exe <keyword> -path "<folder>"` |

## Error Handling

| Return Code | Meaning                 | Action                           |
| ----------- | ----------------------- | -------------------------------- |
| 0           | Success                 | Return results                   |
| 8           | Everything not running  | Start `everything.exe` and retry |
| Other       | Error                   | Return error details and stop    |

## Important Notes

- **Download**: If downloading, use the Everything portable package (for example, `Everything-*.zip`) and its CLI tool package (for example, `ES-*.zip`)
- **Speed**: Everything returns results in ~1-2 seconds vs 60+ seconds for `find`
- **Index**: Real-time index. New files may take a few seconds to appear
- **No GUI required**: `everything.exe` runs silently in the background

## Return Codes

| Code | Meaning                                           |
| ---- | ------------------------------------------------- |
| 0    | Success                                           |
| 8    | Everything not running — start `everything.exe` first |
