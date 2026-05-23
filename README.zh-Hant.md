# 語言學習助手

基於 [Claude Code](https://claude.ai/code) 的 AI 互動式語言學習系統。匯入你自己的教材，提取結構化學習內容，按個人化課程計畫學習 —— 全程自然對話。

## 功能概覽

兩個獨立 skill 協同工作：

| Skill | 指令 | 功能 |
|-------|------|------|
| **教材重構機** | `/process-material` | 匯入教材（PDF、Word、Excel 等），轉換為結構化資料 |
| **課程學習機** | `/learn-language` | 互動式上課，含練習、進度追蹤、自適應節奏 |

系統支援**任意語言組合** —— 自動偵測你的母語，用你的語言互動。

## 快速開始

### 1. 安裝相依套件

**一鍵安裝（推薦）：**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python
```

**或複製後手動安裝：**

```bash
git clone https://github.com/mlkgrnt/Learn-Language.git
cd Learn-Language

# 任選其一：
python setup.py          # 跨平台（需要 Python）
bash setup.sh            # Linux / Mac
setup.bat                # Windows（雙擊或在 cmd 中執行）
```

**或僅安裝相依套件：**

```bash
pip install -r requirements.txt
```

安裝內容：

| 套件名 | 用途 |
|--------|------|
| pymupdf + pymupdf4llm | PDF 文字提取和 Markdown 轉換 |
| chardet | 自動偵測檔案編碼（UTF-8、GBK、Shift-JIS 等） |
| python-docx | 讀取 Word 文件（.docx） |
| openpyxl | 讀取 Excel 試算表（.xlsx） |
| easyocr | 掃描版/圖片版 PDF 的 OCR 辨識（支援 80+ 種語言） |

### 2. 新增教材（選擇性）

把學習材料放進 `materials/input/`：

```
materials/input/
├── 教材.pdf
├── 詞彙表.xlsx
├── 語法筆記.docx
└── 單字表.csv
```

### 3. 處理教材（選擇性）

```
/process-material
```

重構機會：
1. 偵測檔案格式並轉換（PDF → Markdown，.docx → 文字等）
2. 按章節拆分（教材類檔案）
3. 提取詞彙、語法點、閱讀段落
4. 儲存結構化資料到 `materials/`

### 4. 開始學習

```
/learn-language
```

或直接指定語言和等級：

```
/learn-language English B2
/learn-language Japanese N3
/learn-language French B1
```

學習機會：
1. 偵測已處理的教材（沒有則使用內建 CEFR 大綱）
2. 研究目標等級所需學時
3. 生成個人化課程序列
4. 互動式上課，含練習和回饋
5. 每堂課結束自動儲存進度

## 支援的檔案格式

| 格式 | 副檔名 | 處理方式 |
|------|--------|----------|
| PDF | .pdf | pymupdf4llm（自動）、線上工具、直接提取、OCR |
| Word | .docx | python-docx 文字提取 |
| Excel | .xlsx | openpyxl，自動辨識詞彙/語法欄位 |
| 文字 | .txt | 直接讀取，自動偵測編碼 |
| CSV | .csv | 解析為詞彙/語法庫 |
| JSON | .json | 解析為結構化資料 |
| Markdown | .md | 分析語言模式 |

## 專案結構

```
.claude/skills/
├── process-material/              # 教材重構機
│   ├── SKILL.md                   # 匯入、轉換、提取
│   └── templates/
│       ├── material-format.md     # 輸出 JSON 格式定義
│       ├── extract-vocabulary.md  # 詞彙提取規則
│       ├── extract-grammar.md     # 語法提取規則
│       └── extract-reading.md     # 閱讀段落提取規則
│
└── learn-language/                # 課程學習機
    ├── SKILL.md                   # 設定、排課、上課、進度
    ├── levels.md                  # CEFR A1-C2 課程大綱
    └── templates/
        ├── lesson-vocabulary.md   # 詞彙課模板
        ├── lesson-grammar.md      # 語法課模板
        ├── lesson-reading.md      # 閱讀課模板
        ├── lesson-culture.md      # 文化交流課模板
        └── lesson-writing.md      # 寫作課模板

materials/                         # 共享資料層
├── input/                         # 放入原始教材
├── chapters/                      # PDF 轉換後的章節檔案
│   └── index.json
├── vocabulary.json                # 提取的詞彙
├── grammar.json                   # 提取的語法點
└── topics.json                    # 提取的閱讀段落

requirements.txt                   # Python 相依套件
setup.py                           # 跨平台安裝腳本
setup.sh                           # Linux / Mac 安裝腳本
setup.bat                          # Windows 安裝腳本
course.json                        # 生成的課程計畫
progress.json                      # 學習進度
```

## 工作原理

### 教材處理管線

```
原始檔案 → 格式偵測 → 轉換 → 章節拆分 → 結構化提取 → JSON
```

每種提取類型嚴格遵循模板：
- 明確的提取規則
- CEFR 等級估算標準
- 詞彙、語法、段落之間的交叉引用
- 品質檢查清單

### 學習引擎

```
語言 + 等級 → 課程分析 → 學時研究 → 課程序列 → 互動式上課
```

課型在序列中交替排列：
- **詞彙課**：5-10 個新詞，含發音、例句、搭配
- **語法課**：規則講解、句型、例句、常見錯誤
- **閱讀課**：文章 + 理解題
- **文化課**：文化主題、真實材料、場景角色扮演
- **寫作課**：範文分析、引導寫作、結構化回饋

### 進度追蹤

每堂課結束後自動儲存到 `progress.json`：
- 已學詞彙及掌握度
- 已覆蓋語法點
- 薄弱領域
- 學習歷史

進度跨工作階段保留 —— 隨時繼續上次的學習。

## CEFR 等級

系統使用歐洲共同語言參考標準：

| 等級 | 詞彙量 | 描述 |
|------|--------|------|
| A1 | ~500 詞 | 入門 —— 基本片語和表達 |
| A2 | ~1,000 詞 | 初級 —— 簡單的個人和日常事務 |
| B1 | ~2,500 詞 | 中級 —— 熟悉話題的主要要點 |
| B2 | ~4,000 詞 | 中高級 —— 複雜文本和抽象話題 |
| C1 | ~6,000+ 詞 | 高級 —— 高難度文本，隱含意義 |
| C2 | ~8,000+ 詞 | 精通 —— 幾乎所有聽到或讀到的內容 |

學時估算基於劍橋英語研究資料，並根據以下因素調整：
- 語言組合難度（相近語言學得更快）
- 已匯入教材的涵蓋範圍（有教材可減少學時）
- 使用者目前水平

## 授權條款

本專案僅供個人使用。基於 Claude Code skill 系統建構。
