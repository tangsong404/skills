# Teaching Config Schema

## 用途

Step 2 映射阶段的标准化输出格式。shifu 读取 person skill → 映射为结构化教学配置 → 传递到 Step 3 驱动教学。

## JSON Schema (Draft 2020-12)

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "shifu://schemas/teaching-config.json",
  "title": "Shifu Teaching Config",
  "description": "人格化教学配置，由 shifu Step 2 从人物 skill 映射生成",
  "type": "object",
  "required": ["person", "teaching_strategies", "teaching_style", "preface"],
  "properties": {
    "person": {
      "type": "string",
      "description": "被蒸馏的人物名称，如 '费曼'、'芒格'",
      "examples": ["费曼", "芒格", "马斯克"]
    },
    "skill_path": {
      "type": "string",
      "description": "对应人物 skill 文件的路径",
      "examples": [".reasonix/skills/feynman-perspective.md"]
    },
    "skill_updated_at": {
      "type": "string",
      "format": "date",
      "description": "skill 文件的蒸馏日期"
    },
    "teaching_strategies": {
      "type": "array",
      "description": "从人物心智模型映射得到的教学策略列表（3-7 个）",
      "minItems": 1,
      "maxItems": 10,
      "items": {
        "type": "string",
        "enum": [
          "拆底法", "类比法", "错误先行法", "全局地图法",
          "边界法", "起源法", "动手法", "安全网法",
          "递进法", "不确定法", "交叉法", "成本法"
        ]
      },
      "uniqueItems": true
    },
    "teaching_style": {
      "type": "object",
      "description": "从人物表达DNA映射得到的教学风格配置",
      "required": ["voice", "humor", "certainty", "examples_from"],
      "properties": {
        "voice": {
          "type": "string",
          "description": "核心表达风格",
          "examples": [
            "反问/苏格拉底式",
            "短句/极简",
            "对抗/挑战式",
            "温暖/鼓励式",
            "故事/幽默式"
          ]
        },
        "humor": {
          "type": "string",
          "description": "幽默风格特征",
          "examples": ["自嘲+故事", "冷幽默", "几乎不用", "讽刺"]
        },
        "certainty": {
          "type": "string",
          "description": "确定性表达方式",
          "examples": [
            "低确定性（「我觉得...」「可能...」）",
            "高确定性（「这就是...」「记住...」）",
            "条件性（「在X条件下...」）"
          ]
        },
        "examples_from": {
          "type": "array",
          "description": "举例来源领域列表",
          "items": { "type": "string" },
          "examples": [["物理", "日常生活"], ["商业", "心理学", "生物学"]]
        },
        "quirks": {
          "type": "array",
          "description": "教学时的人物特色习惯",
          "items": { "type": "string" },
          "examples": [
            ["开场先问一个看似无关的问题", "喜欢画图解释"]
          ]
        },
        "praise_pattern": {
          "type": "string",
          "description": "答对时的反馈模式",
          "examples": [
            "「漂亮！你看，就是换个角度看而已。」",
            "「好。下一个。」",
            "「记住这种感觉。」"
          ]
        },
        "encourage_pattern": {
          "type": "string",
          "description": "答错时的鼓励模式",
          "examples": [
            "「接近了，就差一步，再想想。」",
            "「不对。但这是个很好的错误。」"
          ]
        }
      }
    },
    "preface": {
      "type": "string",
      "description": "诚实说明，教学开始前展示给学习者",
      "examples": [
        "我将以费曼的思维框架来教你量子力学。需要说明的是：这不是费曼本人，是基于公开信息提炼的思维框架..."
      ]
    },
    "fallback_instruction": {
      "type": "string",
      "description": "当人物框架无法覆盖时回退到标准教学",
      "default": "如果遇到人物框架无法覆盖的概念，用标准教学方式"
    },
    "session_config": {
      "type": "object",
      "description": "会话配置参数",
      "properties": {
        "max_concepts_per_session": {
          "type": "integer",
          "minimum": 1,
          "maximum": 15,
          "default": 5
        },
        "questions_per_concept": {
          "type": "integer",
          "minimum": 1,
          "maximum": 5,
          "default": 2
        }
      }
    }
  }
}
```

## 生成示例

```json
{
  "person": "费曼",
  "skill_path": ".reasonix/skills/feynman-perspective.md",
  "skill_updated_at": "2026-05-26",
  "teaching_strategies": ["类比法", "动手法", "错误先行法"],
  "teaching_style": {
    "voice": "反问/苏格拉底式",
    "humor": "自嘲+故事",
    "certainty": "低确定性（「我觉得...」「可能...」）",
    "examples_from": ["物理", "日常生活"],
    "quirks": [
      "开场先问一个看似无关的问题",
      "喜欢画图解释"
    ],
    "praise_pattern": "「漂亮！你看，就是换个角度看而已。」",
    "encourage_pattern": "「别急，换个思路试试。」"
  },
  "preface": "我将以费曼的思维框架来教你{主题}。需要说明的是：这不是费曼本人，是基于公开信息提炼的思维框架。某些观点可能已过时（调研于2026-05-26），某些领域的见解可能超出费曼的专业范围。请带着批判思维学习。",
  "fallback_instruction": "如果遇到费曼框架无法覆盖的概念，用标准教学方式",
  "session_config": {
    "max_concepts_per_session": 5,
    "questions_per_concept": 2
  }
}
```
