---
name: ragret
description: >-
  用于任何语义搜索、检索或知识库查询场景 —— 尤其是当用户需要搜索"我的数据"、"文档"、"Wiki"、"知识库"、
  "之前的报告"、"内部笔记"，或任何听起来像是存储在私有/内部知识库（非开放网络）的内容时触发。
  当用户明确提到"RAGret"时同样触发。本技能用于检索增强型任务，需要从已知的内部来源查找信息。
  不要用于网络搜索（使用 WebSearch）或本地文件搜索（使用 Grep/Glob）。
---

# RAGret

RAGret 是一个开源、自托管的语义检索服务。它负责索引文档，并通过 JSON API 提供搜索能力。可以把它理解为你私有的内部知识库搜索引擎。

更多信息：[github.com/SugarSong404/RAGret](https://github.com/SugarSong404/RAGret.git)。

★ 小贴士 ──────────────────────────────────────────
RAGret 处于网络搜索和本地文件搜索之间：
- **网络搜索** → 公开的、最新的、任意主题
- **RAGret** → 私有/内部知识库，语义索引，带有来源追溯
- **本地 grep** → 对可见文件的原始文本搜索
────────────────────────────────────────────────────

## 快速开始

用户确认他们有 RAGret 实例后：

1. **检查环境** — 确认 `$env:RAGRET_API_KEY` 和 `$env:BASE_URL`（或让用户设置）
2. **列出索引** — 查看可用的知识库
3. **搜索** — 用自然语言问题查询正确的索引

## 设置

### 配置

需要两个环境变量。请让用户在终端中**先设置好**再开始（绝不要在聊天中索要明文密钥）：

| 变量 | 用途 | 示例 |
|---|---|---|
| `RAGRET_API_KEY` | API 认证 | `sk-...` |
| `BASE_URL` | RAGret 服务器地址 | `http://127.0.0.1:8765` 或 `https://ragret.example.com` |

### 验证连接

```powershell
# 检查变量是否已设置
if (-not $env:RAGRET_API_KEY) { "缺少 RAGRET_API_KEY" }
if (-not $env:BASE_URL) { "缺少 BASE_URL" }
```

如果用户未提供 `BASE_URL`，默认使用 `http://127.0.0.1:8765`。

## 使用

### 1. 列出可用索引

查看当前 API Key 可以访问的所有知识库：

```powershell
curl.exe -sS -H "X-API-Key: $env:RAGRET_API_KEY" "$env:BASE_URL/api/subscribe-indexes"
```

### 2. 搜索索引

```powershell
curl.exe -sS -G "$env:BASE_URL/api/search/索引名称" `
  -H "X-API-Key: $env:RAGRET_API_KEY" `
  --data-urlencode "query=你的自然语言问题"
```

**响应格式：** JSON，包含 `result` 字段（含排序后的段落）。添加 `--data-urlencode "format=text"` 可以获取纯文本输出。

### 3. 使用结果

- 基于检索结果作答；必要时引用 `source:`
- 如果结果包含 URL，将其显式展示给用户

## 错误处理

| 现象 | 可能原因 | 处理方法 |
|---|---|---|
| `curl: (6) Could not resolve host` | BASE_URL 错误 | 请用户确认 URL |
| HTTP 401/403 | API Key 缺失/无效 | 让用户在环境中设置密钥（不要在聊天中） |
| HTTP 404 | 索引名错误 | 先列出索引找到正确的名称 |
| 结果为空 | 无匹配文档 | 尝试改写查询语句 |
| 连接被拒绝 | RAGret 未运行 | 请用户启动 RAGret 实例 |

## 完整示例

```powershell
# 1) 检查配置
$env:BASE_URL = 'https://ragret.example.com'
# 用户设置：$env:RAGRET_API_KEY = 'sk-...'

# 2) 列出可用索引
curl.exe -sS -H "X-API-Key: $env:RAGRET_API_KEY" "${env:BASE_URL}/api/subscribe-indexes"

# 3) 在 "product_docs" 中搜索退款政策
curl.exe -sS -G "${env:BASE_URL}/api/search/product_docs" `
  -H "X-API-Key: ${env:RAGRET_API_KEY}" `
  --data-urlencode "query=How do we handle refunds within 30 days?" `
  --data-urlencode "format=text"
```

## 脚本

如需更便捷的操作，可以使用附带的辅助脚本：

- `scripts/ragret.ps1` — PowerShell 封装的索引列表和搜索功能

使用方法见脚本头部：`Get-Content "$PSScriptRoot/scripts/ragret.ps1"`

## 规则

- **绝不**在聊天中索要明文 API Key，也不以明文形式用于参数
- 在调用 API 前始终验证环境变量是否已设置
- 如果用户未提供 `BASE_URL`，默认使用 `http://127.0.0.1:8765`
