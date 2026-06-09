# 语言学习助手

基于 [Claude Code](https://claude.ai/code) 的 AI 交互式语言学习系统。导入你自己的教材，提取结构化学习内容，按个性化课程计划学习 —— 全程自然对话。

## v2 更新

| 功能 | v1 | v2 |
|------|----|----|
| 状态文件 | `progress.json` + `course.json` | 统一为 `state.json` |
| 复习系统 | 无 | 间隔重复（掌握度评分、自动排期复习） |
| 练习模式 | 无 | `/practise` —— 自由对话 + 实时纠错 |
| 复习课 | 无 | 每5课一次复习课 |
| 回到课程 | 重新走一遍设置流程 | 自动续课，显示进度卡片 |
| 课程模板 | 固定格式 | 示例驱动，灵活 |
| 词汇预热 | 无 | 学新词前先复习旧词 |

## 功能概览

三个命令协同工作：

| 命令 | 功能 |
|------|------|
| `/process-material` | 导入教材（PDF、Word、Excel 等），转换为结构化数据 |
| `/learn-language` | 交互式上课，含练习、间隔重复、自适应节奏 |
| `/practise` | 目标语言自由对话，实时纠错 |

系统支持**任意语言组合** —— 自动检测你的母语，用你的语言交互。

## 快速开始

### 1. 安装依赖

**一键安装（推荐）：**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python
```

**或克隆后手动安装：**

```bash
git clone https://github.com/mlkgrnt/Learn-Language.git
cd Learn-Language

# 任选其一：
python setup.py          # 跨平台（需要 Python）
bash setup.sh            # Linux / Mac
setup.bat                # Windows（双击或在 cmd 中运行）
```

**或仅安装依赖：**

```bash
pip install -r requirements.txt
```

安装内容：

| 包名 | 用途 |
|------|------|
| pymupdf + pymupdf4llm | PDF 文本提取和 Markdown 转换 |
| chardet | 自动检测文件编码（UTF-8、GBK、Shift-JIS 等） |
| python-docx | 读取 Word 文档（.docx） |
| openpyxl | 读取 Excel 表格（.xlsx） |
| easyocr | 扫描版/图片版 PDF 的 OCR 识别（支持 80+ 种语言） |

### 2. 添加教材（可选）

把学习材料放进 `materials/input/`：

```
materials/input/
├── 教材.pdf
├── 词汇表.xlsx
├── 语法笔记.docx
└── 单词表.csv
```

### 3. 处理教材（可选）

```
/process-material
```

重构机会：
1. 检测文件格式并转换（PDF → Markdown，.docx → 文本等）
2. 按章节拆分（教材类文件）
3. 提取词汇、语法点、阅读段落
4. 保存结构化数据到 `materials/`

### 4. 开始学习

```
/learn-language
```

或直接指定语言和等级：

```
/learn-language English B2
/learn-language Japanese N3
/learn-language French B1
```

学习机会：
1. 检测已有进度（`state.json`）—— 有的话自动续课
2. 新课程：分析教材、研究学时、生成课程序列
3. 交互式上课，含练习和反馈
4. 间隔重复 —— 词汇和语法点自动排期复习
5. 每5课一次复习课
6. 每课结束自动保存进度

## 支持的文件格式

| 格式 | 扩展名 | 处理方式 |
|------|--------|----------|
| PDF | .pdf | pymupdf4llm（自动）、在线工具、直接提取、OCR |
| Word | .docx | python-docx 文本提取 |
| Excel | .xlsx | openpyxl，自动识别词汇/语法列 |
| 文本 | .txt | 直接读取，自动检测编码 |
| CSV | .csv | 解析为词汇/语法库 |
| JSON | .json | 解析为结构化数据 |
| Markdown | .md | 分析语言模式 |

## 项目结构

```
.claude/skills/
├── process-material/              # 教材重构机
│   ├── SKILL.md                   # 导入、转换、提取
│   └── templates/
│       ├── material-format.md     # 输出 JSON 格式定义
│       ├── extract-vocabulary.md  # 词汇提取规则
│       ├── extract-grammar.md     # 语法提取规则
│       └── extract-reading.md     # 阅读段落提取规则
│
└── learn-language/                # 课程学习机
    ├── SKILL.md                   # 设置、排课、上课、进度
    ├── levels.md                  # CEFR A1-C2 课程大纲
    └── templates/
        ├── lesson-vocabulary.md   # 词汇课模板
        ├── lesson-grammar.md      # 语法课模板
        ├── lesson-reading.md      # 阅读课模板
        ├── lesson-culture.md      # 文化交流课模板
        └── lesson-writing.md      # 写作课模板

materials/                         # 共享数据层
├── input/                         # 放入原始教材
├── chapters/                      # PDF 转换后的章节文件
│   └── index.json
├── vocabulary.json                # 提取的词汇
├── grammar.json                   # 提取的语法点
└── topics.json                    # 提取的阅读段落

requirements.txt                   # Python 依赖
state.json                         # 统一的课程计划 + 进度（v2）
```

## 工作原理

### 教材处理管线

```
原始文件 → 格式检测 → 转换 → 章节拆分 → 结构化提取 → JSON
```

每种提取类型严格遵循模板：明确的提取规则、CEFR 等级估算、交叉引用、质量检查清单。

### 学习引擎

```
语言 + 等级 → 课程分析 → 学时研究 → 课程序列 → 交互式上课
```

课类型在序列中交替排列：
- **词汇课**：5-10 个新词，含发音、例句、预热复习旧词
- **语法课**：规则讲解、句型、例句、常见错误
- **阅读课**：文章 + 理解题
- **文化课**：文化主题、真实材料、场景角色扮演
- **写作课**：范文分析、引导写作、结构化反馈
- **复习课**（每5课）：间隔重复掌握度低于阈值的词汇和语法

### 间隔重复

每个词汇和语法点都有：
- **掌握度评分**：从 0 开始，答对上升，答错下降
- **下次复习日期**：根据表现自动排期
- **复习次数**：追踪复习了多少轮

掌握度低于 80% 的词汇会自动进入预热环节和复习课。

### 进度追踪

所有状态保存在单一的 `state.json` 中：
- 课程计划（总课数、序列、当前位置）
- 词汇及掌握度评分和复习日期
- 语法点及掌握度评分和复习日期
- 薄弱领域和学习历史
- 回来时自动续课 —— 不需要重新设置

## CEFR 等级

| 等级 | 词汇量 | 描述 |
|------|--------|------|
| A1 | ~500 词 | 入门 —— 基本短语和表达 |
| A2 | ~1,000 词 | 初级 —— 简单的个人和日常事务 |
| B1 | ~2,500 词 | 中级 —— 熟悉话题的主要要点 |
| B2 | ~4,000 词 | 中高级 —— 复杂文本和抽象话题 |
| C1 | ~6,000+ 词 | 高级 —— 高难度文本，隐含意义 |
| C2 | ~8,000+ 词 | 精通 —— 几乎所有听到或读到的内容 |

学时估算基于剑桥英语研究数据，并根据语言组合难度、已导入教材覆盖范围和用户当前水平调整。

## 许可证

本项目仅供个人使用。基于 Claude Code skill 系统构建。
