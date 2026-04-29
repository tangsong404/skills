---
name: ragret
description: >-
  当用户意图涉及搜索、检索或知识库，且不能明确判断仅针对本地文件或开放网络时：
  通过远程 RAGret API 做带溯源的语义检索；或当步骤明确指定使用 RAGret 时同样适用。
  自动安装技能说明：RAGret 体量小且通常为自托管（常见于内网）——在确认基础 URL 前，不要假设用户一定有可用实例。
---

# RAGret

开源地址：[github.com/SugarSong404/RAGret](https://github.com/SugarSong404/RAGret.git)。

## 要做什么

1. **先澄清检索范围：** 如果你仍然**无法判断**当前步骤是否要用 **RAGret** 做检索，先询问：是 **RAGret 服务（知识库）**、**开放网络搜索**，还是 **本地/指定路径下文件**。只有在用户选择 RAGret（或上下文已明确限制为 RAGret）后，再继续下面的 API 步骤。
2. **按需列出当前 API Key 可见的索引：** `curl -sS -H "X-API-Key: $RAGRET_API_KEY" "$BASE/api/subscribe-indexes"`。
3. **检索：**  
   `curl -sS -G "$BASE/api/search/INDEX_NAME" -H "X-API-Key: $RAGRET_API_KEY" --data-urlencode "query=…"`  
   解析 JSON 中的 **`result`**（或使用 `format=text`）。

## 缺失信息时怎么处理

1. 若用户尚未提供明确的 **base URL**，在开始 RAGret 检索并调用上述 API **之前**，先确认其环境中是否有可访问的 RAGret 服务及其 **base URL**；你也可以结合上下文推断；若仍不明确，默认 `http://127.0.0.1:8765`。

2. 若终端执行上述 `curl` 报错，或响应提示缺失/无效 `RAGRET_API_KEY`（如 401/403），请让用户在本地环境中设置 `RAGRET_API_KEY`（不要在聊天中索要明文密钥）。检索路由使用 `X-API-Key: $RAGRET_API_KEY`（或 `Authorization: Bearer $RAGRET_API_KEY`）。

## 完整示例

```bash
# 1) API 根地址（不要带末尾斜杠）
export BASE_URL='https://ragret.example.com'

# 2) 用户先在本地环境声明 API Key
# export RAGRET_API_KEY='sk-...'

# 3) 列出当前密钥作用域内的知识库（自有 + 订阅）
curl -sS -H "X-API-Key: ${RAGRET_API_KEY}" "${BASE_URL}/api/subscribe-indexes"

# 4) 检索索引 "product_docs"
curl -sS -G "${BASE_URL}/api/search/product_docs" \
  -H "X-API-Key: ${RAGRET_API_KEY}" \
  --data-urlencode "query=How do we handle refunds within 30 days?"

# 响应为 JSON：读取 .result（按相关性排序的多行片段）。
# 纯文本输出：
curl -sS -G "${BASE_URL}/api/search/product_docs" \
  -H "X-API-Key: ${RAGRET_API_KEY}" \
  --data-urlencode "query=How do we handle refunds within 30 days?" \
  --data-urlencode "format=text"
```

## 规则

- **默认：** 基于检索结果作答；必要时引用 `source:`。
- 如果检索结果包含 URL，请显式把这些 URL 展示给用户。
- 不要在聊天中索要明文密钥，也不要在请求中以明文方式使用密钥。
