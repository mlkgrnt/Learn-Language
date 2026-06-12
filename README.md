# Language Learning Assistant

An interactive language learning system for [Claude Code](https://claude.ai/code), powered by AI. Import your own textbooks, extract structured learning materials, and follow a personalized curriculum — all through natural conversation.

Three skills: `/process-material` (import & extract), `/learn-language` (learn & practice), and `/practise` (free conversation). Supports any language pair.

---

**Read this in other languages:**

[English](README.en.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [Español](README.es.md)

---

## What's New in v2.1

- **Trigger conditions** — clear guidance on when to use each skill
- **16 examples** — detailed input→output examples for all scenarios
- **Quality checklists** — self-verification after each skill use
- **Error handling** — graceful fallbacks for common failures
- **Version history** — track changes across releases

### Previous v2 Features

- **Spaced repetition** — vocabulary mastery scores and grammar review scheduling built in. Every 5th lesson is a review lesson.
- **Unified state** — `progress.json` + `course.json` merged into a single `state.json`. One file to rule them all.
- **`/practise` mode** — free conversation in your target language with real-time error correction.
- **Auto-continuation** — returning to a course skips setup and shows your progress card immediately.

---

## Quick Start

**One-click install:**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python

# Or clone and run manually
git clone https://github.com/mlkgrnt/Learn-Language.git
cd Learn-Language
python setup.py          # cross-platform
bash setup.sh            # Linux / Mac
setup.bat                # Windows
```

1. Place materials in `materials/input/` (PDF, Word, Excel, CSV, etc.)
2. Open Claude Code and run `/process-material` to extract vocabulary, grammar, and passages
3. Run `/learn-language` to start interactive lessons
4. Use `/practise` anytime for free conversation practice

---

## Skills Overview

### `/process-material` — Material Processor

Import raw teaching materials and convert them to structured data.

**When to use:**
- You have textbooks (PDF, Word, Excel) to process
- You want to extract vocabulary, grammar, or reading passages
- You are setting up a new learning project

### `/learn-language` — Language Tutor

Interactive lessons with spaced repetition and progress tracking.

**When to use:**
- You want to learn a new language
- You want to continue a previous learning session
- You want structured vocabulary, grammar, reading, writing, or culture lessons

### `/practise` — Conversation Practice

Free-form conversation in your target language with real-time correction.

**When to use:**
- You want to practice speaking/writing
- You want informal conversation practice
- You want to test your skills in a low-pressure setting

---

## Error Handling

Each skill handles common failures gracefully:

- **Encoding detection failure** → Falls back to common encodings (UTF-8, GBK, Shift-JIS)
- **PDF conversion failure** → Suggests alternative methods (OCR, online tools)
- **State file corruption** → Auto-recovers from backup or starts fresh
- **Missing materials** → Suggests running `/process-material` first

---

## See Also

- [Cyber-Eros.skill](https://github.com/mlkgrnt/Cyber-Eros.skill) — Immersive roleplay system by the same author

---

## License

MIT
