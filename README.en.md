# Language Learning Assistant

An interactive language learning system for [Claude Code](https://claude.ai/code), powered by AI. Import your own textbooks, extract structured learning materials, and follow a personalized curriculum — all through natural conversation.

## What's New in v2

| Feature | v1 | v2 |
|---------|----|----|
| State files | `progress.json` + `course.json` | Single `state.json` |
| Review system | None | Spaced repetition (mastery scores, auto-scheduled reviews) |
| Practice mode | N/A | `/practise` — free conversation with error correction |
| Review lessons | None | Every 5th lesson is a review |
| Returning to course | Full setup flow again | Auto-continuation with progress card |
| Templates | Rigid format prescriptions | Example-driven, flexible |
| Vocabulary warmup | None | Review old words before new ones |

## Features

Two independent skills that work together:

| Skill | Command | What it does |
|-------|---------|--------------|
| **Material Processor** | `/process-material` | Import textbooks (PDF, Word, Excel, etc.), convert to structured data |
| **Language Tutor** | `/learn-language` | Interactive lessons with exercises, spaced repetition, adaptive pacing |
| **Practice Mode** | `/practise` | Free conversation in target language with real-time error correction |

The system supports **any language pair** — it detects your native language from conversation and adapts all interactions accordingly.

## Quick Start

### 1. Install Dependencies

**One-click install (recommended):**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python
```

**Or clone and install manually:**

```bash
git clone https://github.com/mlkgrnt/Learn-Language.git
cd Learn-Language

# Choose one:
python setup.py          # cross-platform (requires Python)
bash setup.sh            # Linux / Mac
setup.bat                # Windows (double-click or run in cmd)
```

**Or install dependencies only:**

```bash
pip install -r requirements.txt
```

This installs:

| Package | Purpose |
|---------|---------|
| pymupdf + pymupdf4llm | PDF text extraction and markdown conversion |
| chardet | Auto-detect file encoding (UTF-8, GBK, Shift-JIS, etc.) |
| python-docx | Read Word documents (.docx) |
| openpyxl | Read Excel spreadsheets (.xlsx) |
| easyocr | OCR for scanned/image-only PDFs (80+ languages) |

### 2. Add Your Materials (Optional)

Place your learning materials in `materials/input/`:

```
materials/input/
├── textbook.pdf
├── vocabulary.xlsx
├── grammar_notes.docx
└── word_list.csv
```

### 3. Process Materials (Optional)

```
/process-material
```

The skill will:
1. Detect file format and convert (PDF → markdown, .docx → text, etc.)
2. Split into chapters (for textbooks)
3. Extract vocabulary, grammar points, and reading passages
4. Save structured data to `materials/`

### 4. Start Learning

```
/learn-language
```

Or jump directly to a specific language and level:

```
/learn-language English B2
/learn-language Japanese N3
/learn-language French B1
```

The skill will:
1. Check for existing progress (`state.json`) — auto-continues if found
2. If new: analyze materials, research study hours, generate lesson sequence
3. Run interactive lessons with exercises and feedback
4. Apply spaced repetition — words and grammar points get mastery scores
5. Schedule review lessons every 5th lesson
6. Save progress automatically after each lesson

## Supported File Formats

| Format | Extension | Processing |
|--------|-----------|------------|
| PDF | .pdf | pymupdf4llm (auto), online tool, direct extraction, or OCR |
| Word | .docx | python-docx text extraction |
| Excel | .xlsx | openpyxl, auto-detects vocabulary/grammar columns |
| Text | .txt | Direct read with auto encoding detection |
| CSV | .csv | Parsed as vocabulary/grammar bank |
| JSON | .json | Parsed as structured data |
| Markdown | .md | Analyzed for language patterns |

## Project Structure

```
.claude/skills/
├── process-material/              # Material Processor skill
│   ├── SKILL.md                   # Import, convert, extract
│   └── templates/
│       ├── material-format.md     # Output JSON schema
│       ├── extract-vocabulary.md  # Vocabulary extraction rules
│       ├── extract-grammar.md     # Grammar extraction rules
│       └── extract-reading.md     # Reading passage extraction rules
│
└── learn-language/                # Language Tutor skill
    ├── SKILL.md                   # Setup, scheduling, lessons, progress
    ├── levels.md                  # CEFR A1-C2 curriculum reference
    └── templates/
        ├── lesson-vocabulary.md   # Vocabulary lesson template
        ├── lesson-grammar.md      # Grammar lesson template
        ├── lesson-reading.md      # Reading lesson template
        ├── lesson-culture.md      # Cultural exchange lesson template
        └── lesson-writing.md      # Writing lesson template

materials/                         # Shared data layer
├── input/                         # Raw materials go here
├── chapters/                      # Converted chapter files (from PDFs)
│   └── index.json
├── vocabulary.json                # Extracted vocabulary
├── grammar.json                   # Extracted grammar points
└── topics.json                    # Extracted reading passages

requirements.txt                   # Python dependencies
state.json                         # Unified course plan + progress (v2)
```

## How It Works

### Material Processing Pipeline

```
Raw File → Format Detection → Conversion → Chapter Splitting → Structured Extraction → JSON
```

Each extraction type follows strict templates with clear rules, CEFR level estimation, cross-referencing, and quality checklists.

### Learning Engine

```
Language + Level → Curriculum Analysis → Study Hours → Lesson Sequencing → Interactive Lessons
```

Lesson types alternate throughout the sequence:
- **Vocabulary**: 5-10 new words with pronunciation, examples, warmup review of old words
- **Grammar**: Rule explanation, patterns, examples, common mistakes
- **Reading**: Passages with comprehension questions
- **Culture**: Cultural topics, authentic materials, scenario role-plays
- **Writing**: Model text analysis, guided writing, structured feedback
- **Review** (every 5th lesson): Spaced repetition of words and grammar below mastery threshold

### Spaced Repetition

Every vocabulary word and grammar point has:
- **Mastery score**: Starts at 0, increases with correct answers, decreases with errors
- **Next review date**: Scheduled automatically based on performance
- **Review count**: Tracks how many times the item has been reviewed

Words below 80% mastery are automatically pulled into warmup sections and review lessons.

### Progress Tracking

All state lives in a single `state.json`:
- Course plan (total lessons, sequence, current position)
- Vocabulary with mastery scores and review dates
- Grammar points with mastery scores and review dates
- Weak areas and session history
- Auto-continues on return — no need to re-setup

## CEFR Levels

| Level | Vocabulary | Description |
|-------|-----------|-------------|
| A1 | ~500 words | Beginner — basic phrases and expressions |
| A2 | ~1,000 words | Elementary — simple personal and routine matters |
| B1 | ~2,500 words | Intermediate — main points on familiar matters |
| B2 | ~4,000 words | Upper Intermediate — complex texts and abstract topics |
| C1 | ~6,000+ words | Advanced — demanding texts, implicit meaning |
| C2 | ~8,000+ words | Mastery — virtually everything heard or read |

Study hours are estimated based on Cambridge English research and adjusted for language pair difficulty, imported materials coverage, and current level.

## License

This project is for personal use. Built as a Claude Code skill system.
