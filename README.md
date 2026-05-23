# Language Learning Assistant

An interactive language learning system for [Claude Code](https://claude.ai/code), powered by AI. Import your own textbooks, extract structured learning materials, and follow a personalized curriculum — all through natural conversation.

Two skills: `/process-material` (import & extract) and `/learn-language` (learn & practice). Supports any language pair.

---

**Read this in other languages:**

[English](README.en.md) | [简体中文](README.zh-Hans.md) | [繁體中文](README.zh-Hant.md) | [Español](README.es.md)

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

See the language-specific README for full documentation.
