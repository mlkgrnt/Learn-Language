# Language Learning Assistant

An interactive language learning system for [Claude Code](https://claude.ai/code), powered by AI. Import your own textbooks, extract structured learning materials, and follow a personalized curriculum — all through natural conversation.

## Features

Two independent skills that work together:

| Skill | Command | What it does |
|-------|---------|--------------|
| **Material Processor** | `/process-material` | Import textbooks (PDF, Word, Excel, etc.), convert to structured data |
| **Language Tutor** | `/learn-language` | Interactive lessons with exercises, progress tracking, adaptive pacing |

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
1. Check for processed materials (or use built-in CEFR curriculum)
2. Research study hours needed for your target level
3. Generate a personalized lesson sequence
4. Run interactive lessons with exercises and feedback
5. Save progress automatically after each lesson

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
setup.py                           # Cross-platform install script
setup.sh                           # Linux / Mac install script
setup.bat                          # Windows install script
course.json                        # Generated course plan
progress.json                      # Learning progress
```

## How It Works

### Material Processing Pipeline

```
Raw File → Format Detection → Conversion → Chapter Splitting → Structured Extraction → JSON
```

Each extraction type follows strict templates with:
- Clear rules for what to extract
- CEFR level estimation criteria
- Cross-referencing between vocabulary, grammar, and passages
- Quality checklists

### Learning Engine

```
Language + Level → Curriculum Analysis → Study Hours Research → Lesson Sequencing → Interactive Lessons
```

Lesson types alternate throughout the sequence:
- **Vocabulary**: 5-10 new words with pronunciation, examples, collocations
- **Grammar**: Rule explanation, patterns, examples, common mistakes
- **Reading**: Passages with comprehension questions
- **Culture**: Cultural topics, authentic materials, scenario role-plays
- **Writing**: Model text analysis, guided writing, structured feedback

### Progress Tracking

After every lesson, progress is saved to `progress.json`:
- Words learned with mastery levels
- Grammar points covered
- Weak areas identified
- Session history

Progress persists across sessions — pick up where you left off anytime.

## CEFR Levels

The system uses the Common European Framework of Reference for Languages:

| Level | Vocabulary | Description |
|-------|-----------|-------------|
| A1 | ~500 words | Beginner — basic phrases and expressions |
| A2 | ~1,000 words | Elementary — simple personal and routine matters |
| B1 | ~2,500 words | Intermediate — main points on familiar matters |
| B2 | ~4,000 words | Upper Intermediate — complex texts and abstract topics |
| C1 | ~6,000+ words | Advanced — demanding texts, implicit meaning |
| C2 | ~8,000+ words | Mastery — virtually everything heard or read |

Study hours are estimated based on Cambridge English research and adjusted for:
- Language pair difficulty (e.g., related languages are faster)
- Imported materials coverage (reduces hours if materials are used)
- User's current level

## License

This project is for personal use. Built as a Claude Code skill system.
