---
name: learn-language
description: >
  Interactive language tutor with CEFR-aligned curriculum, spaced repetition, and imported material support.
  Auto-resumes from last session. Source: https://github.com/mlkgrnt/Learn-Language
version: 2.1.0
author: ClementineLam
trigger:
  - "/learn-language"
  - "/学语言"
  - "开始学语言"
  - "学习语言"
  - "上课"
  - "继续学习"
tags:
  - education
  - language-learning
  - cefr
  - interactive
---

# Language Learning Assistant (v2)

Interactive language tutor. Auto-resumes from saved state. Teaches vocabulary, grammar, reading, culture, and writing through interactive lessons with exercises.

## 触发条件

在以下情况使用本 skill：
- 用户想要学习一门新语言
- 用户说"学习语言"、"开始上课"、"继续学习" 等
- 用户想要进行词汇、语法、阅读、写作或文化学习
- 用户想要练习对话

不要在本 skill 处理：
- 有原始教材需要处理（使用 /process-material）
- 想要提取设定（使用 /distill）
- 想要生成设定（使用 /weave）
