---
name: everything-find
description: "在 Windows 上使用 Everything 的 es.exe CLI 进行快速文件/目录搜索。适用于用户要求全局查找文件、在大范围内搜索模式、定位可执行文件或比较搜索速度的场景，不适应于工作目录中的查找。触发语义：'find'、'search'、'where is'、'locate'。"
---

# everything-find

在 Windows 上使用 Everything 的索引搜索进行快速文件/目录查找（比原生查找要快很多）。

## 用法

在 Windows 上使用 `es.exe` 进行索引文件搜索，`es.exe` 与 `everything.exe`都在当前技能目录的`scripts`子目录中

## 快速开始

1. 使用前，确认 `es.exe` 与 `everything.exe` 两个应用都存在，否则前往<https://www.voidtools.com/downloads/>进行下载。
2. 若 `es.exe` 返回代码 `8`，启动 `everything.exe` 后重试。
3. 使用 `es.exe` 执行搜索，仅使用满足用户请求所需的选项。

## 常见模式

| 目标 | 模式 |
| ---- | ---- |
| 按名称查找文件 | `es.exe <keyword>` |
| 仅查找目录 | `es.exe <keyword> -ad` |
| 仅查找文件 | `es.exe <keyword> /a-d` |
| 限制结果数量 | `es.exe <keyword> -n <count>` |
| 正则匹配 | `es.exe -r "<pattern>"` |
| 区分大小写匹配 | `es.exe -i <keyword>` |
| 在指定路径内搜索 | `es.exe <keyword> -path "<folder>"` |

## 错误处理

| 返回码 | 含义                    | 动作                               |
| ------ | ----------------------- | ---------------------------------- |
| 0      | 成功                    | 返回结果                           |
| 8      | Everything 未运行       | 启动 `everything.exe` 后重试           |
| 其他   | 错误                    | 返回错误细节并停止                 |

## 重要说明

- **下载**：如果进行下载，请下载Everything便捷版，形似`Everything-*.zip` ；及其命令行工具，形似`ES-*.zip`
- **速度**：Everything 返回结果约需 1-2 秒，`find` 常需 60+ 秒
- **索引**：实时索引；新文件出现可能会有几秒延迟
- **无 GUI 要求**：`everything.exe` 在后台静默运行

## 返回码

| 代码 | 含义                                              |
| ---- | ------------------------------------------------- |
| 0    | 成功                                              |
| 8    | Everything 未运行 —— 先启动 `everything.exe`          |
