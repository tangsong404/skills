<#
.SYNOPSIS
  RAGret API helper — list indexes and search knowledge bases.

.DESCRIPTION
  A thin wrapper around the RAGret HTTP API. Requires two environment variables:
    RAGRET_API_KEY  - API key for authentication
    BASE_URL        - RAGret server URL (default: http://127.0.0.1:8765)

.PARAMETER Command
  "list" to list available indexes, or "search" to search an index.

.PARAMETER Index
  The index name to search (required for "search" command).

.PARAMETER Query
  The search query text (required for "search" command).

.PARAMETER Format
  Output format: "json" (default) or "text".

.EXAMPLE
  .\ragret.ps1 list
  .\ragret.ps1 search product_docs -Query "refund policy" -Format text
#>

param(
  [Parameter(Position = 0, Mandatory)]
  [ValidateSet("list", "search")]
  [string]$Command,

  [Parameter(Position = 1)]
  [string]$Index,

  [Parameter()]
  [string]$Query,

  [Parameter()]
  [ValidateSet("json", "text")]
  [string]$Format = "json"
)

# --- Configuration ---
$ErrorActionPreference = "Stop"

$baseUrl = if ($env:BASE_URL) { $env:BASE_URL.TrimEnd('/') } else { "http://127.0.0.1:8765" }
$apiKey = $env:RAGRET_API_KEY

if (-not $apiKey) {
  Write-Error "RAGRET_API_KEY is not set. Set it in your environment: `$env:RAGRET_API_KEY = 'sk-...'"
  exit 1
}

$headers = @{ "X-API-Key" = $apiKey }

# --- Commands ---
switch ($Command) {
  "list" {
    $url = "$baseUrl/api/subscribe-indexes"
    Write-Host "Fetching indexes from $url ..." -ForegroundColor Cyan
    $result = curl.exe -sS -H "X-API-Key: $apiKey" $url
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
    $result | ConvertFrom-Json | ConvertTo-Json -Depth 3
  }

  "search" {
    if (-not $Index) { Write-Error "Index name is required for 'search' command."; exit 1 }
    if (-not $Query) { Write-Error "Query text is required for 'search' command."; exit 1 }

    $url = "$baseUrl/api/search/$Index"
    Write-Host "Searching index '$Index'..." -ForegroundColor Cyan

    $params = @("--data-urlencode", "query=$Query")
    if ($Format -eq "text") { $params += "--data-urlencode", "format=text" }

    $result = curl.exe -sS -G $url -H "X-API-Key: $apiKey" @params
    if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

    if ($Format -eq "text") {
      $result
    } else {
      $result | ConvertFrom-Json | ConvertTo-Json -Depth 3
    }
  }
}
