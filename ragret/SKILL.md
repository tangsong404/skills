---
name: ragret
description: >-
  Use RAGret for any semantic search, retrieval, or knowledge-base query — especially
  when the user asks to search "my data", "the docs", "the wiki", "knowledge base",
  "previous reports", "internal notes", or anything that sounds like it lives in a
  private or internal knowledge store (not the open web). Also triggers when the user
  explicitly says "RAGret". This is the skill to use for RETRIEVAL-AUGMENTED tasks
  where you need to find information from a known internal source. Do NOT use for
  web search (use WebSearch) or local file search (use Grep/Glob).
---

# RAGret

RAGret is an open-source, self-hosted semantic retrieval service. It indexes documents and provides a JSON API for searching them. Think of it as your private search engine for internal knowledge bases.

For more info: [github.com/SugarSong404/RAGret](https://github.com/SugarSong404/RAGret.git).

★ Insight ──────────────────────────────────────────
RAGret fits between web search and local file search:
- **Web search** → public, up-to-date, any topic
- **RAGret** → private/internal knowledge, semantically indexed, with provenance
- **Local grep** → raw text search in files you can see
────────────────────────────────────────────────────

## Quick start

Once the user confirms they have a RAGret instance:

1. **Verify environment** — check `$env:RAGRET_API_KEY` and `$env:BASE_URL` (or ask user to set them)
2. **List indexes** — see what knowledge bases are available
3. **Search** — query the right index with a natural-language question

## Setup

### Configuration

Two environment variables are required. Ask the user to set these in their terminal **before** you start (never ask for raw secrets in chat):

| Variable | Purpose | Example |
|---|---|---|
| `RAGRET_API_KEY` | API authentication | `sk-...` |
| `BASE_URL` | RAGret server address | `http://127.0.0.1:8765` or `https://ragret.example.com` |

### Verify connection

```powershell
# Check variables are set
if (-not $env:RAGRET_API_KEY) { "Missing RAGRET_API_KEY" }
if (-not $env:BASE_URL) { "Missing BASE_URL" }
```

If `BASE_URL` is not provided, default to `http://127.0.0.1:8765`.

## Usage

### 1. List available indexes

Shows all knowledge bases your API key can access:

```powershell
curl.exe -sS -H "X-API-Key: $env:RAGRET_API_KEY" "$env:BASE_URL/api/subscribe-indexes"
```

### 2. Search an index

```powershell
curl.exe -sS -G "$env:BASE_URL/api/search/INDEX_NAME" `
  -H "X-API-Key: $env:RAGRET_API_KEY" `
  --data-urlencode "query=your natural language question"
```

**Response format:** JSON with a `result` field containing ranked passages. Add `--data-urlencode "format=text"` for plain text output.

### 3. Use the results

- Answer from retrieval output; cite `source:` when useful
- If the response includes URLs, show them to the user explicitly

## Error handling

| Symptom | Likely cause | What to do |
|---|---|---|
| `curl: (6) Could not resolve host` | Wrong `BASE_URL` | Ask the user to verify the URL |
| HTTP 401/403 | Missing/invalid `RAGRET_API_KEY` | Ask the user to set the key in their env (not in chat) |
| HTTP 404 on search | Wrong index name | List indexes first to find the correct name |
| Empty result set | No matching documents | Try rephrasing the query |
| Connection refused | RAGret not running | Ask the user to start their RAGret instance |

## Full example

```powershell
# 1) Check configuration
$env:BASE_URL = 'https://ragret.example.com'
# User sets: $env:RAGRET_API_KEY = 'sk-...'

# 2) List available indexes
curl.exe -sS -H "X-API-Key: $env:RAGRET_API_KEY" "${env:BASE_URL}/api/subscribe-indexes"

# 3) Search "product_docs" for refund policy
curl.exe -sS -G "${env:BASE_URL}/api/search/product_docs" `
  -H "X-API-Key: ${env:RAGRET_API_KEY}" `
  --data-urlencode "query=How do we handle refunds within 30 days?" `
  --data-urlencode "format=text"
```

## Scripts

For a streamlined experience, use the bundled helper script:

- `scripts/ragret.ps1` — PowerShell wrapper for listing indexes and searching

Read the script's header for usage: `Get-Content "$PSScriptRoot/scripts/ragret.ps1"`

## Rules

- **Never** ask for raw API keys in chat or use them as plain-text arguments
- Always verify environment variables exist before making API calls
- Default `BASE_URL` to `http://127.0.0.1:8765` if the user doesn't provide one
