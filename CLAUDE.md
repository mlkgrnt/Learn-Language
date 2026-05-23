# Language Learning Assistant

An interactive language learning system for Claude Code, split into two independent skills.

## Skills

```
/learn-language              # 课程学习机 — 选择语言、等级，开始上课
/learn-language English B2   # 直接跳到指定语言和等级

/process-material            # 教材重构机 — 导入教材，解析提取，结构化存储
```

## Project Structure

```
.claude/skills/
├── process-material/              # 教材重构机
│   ├── SKILL.md                   # 材料导入、PDF转换、章节拆分、结构化提取
│   └── templates/
│       ├── material-format.md     # JSON schema（vocabulary/grammar/topics）
│       ├── extract-vocabulary.md  # 词汇提取规则与质量检查
│       ├── extract-grammar.md     # 语法提取规则与质量检查
│       └── extract-reading.md     # 阅读段落/对话提取规则与质量检查
│
└── learn-language/                # 课程学习机
    ├── SKILL.md                   # 选语言、排课程、上课、练习、存档
    ├── levels.md                  # CEFR A1-C2 课程大纲
    └── templates/
        ├── lesson-vocabulary.md   # 词汇课模板
        ├── lesson-grammar.md      # 语法课模板
        ├── lesson-reading.md      # 阅读课模板
        ├── lesson-culture.md      # 文化交流课模板
        └── lesson-writing.md      # 写作课模板

materials/                         # 共享数据层（重构机写入，学习机读取）
├── input/                         # 用户放入原始教材
│   └── README.txt
├── chapters/                      # PDF转换后的章节markdown文件
│   └── index.json
├── vocabulary.json                # 提取的结构化词汇
├── grammar.json                   # 提取的结构化语法
└── topics.json                    # 提取的结构化段落

requirements.txt                   # Python依赖（pymupdf, pymupdf4llm, chardet, python-docx, openpyxl, easyocr)
course.json                        # 课程计划（学习机创建）
progress.json                      # 学习进度（学习机创建）
```

## Workflow

1. `/process-material` — 导入教材，处理完得到 `materials/` 下的结构化文件
2. `/learn-language` — 检测已处理材料，开始学习（无材料则用内置大纲）
