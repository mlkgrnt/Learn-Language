# 语言学习助手

基于 [Claude Code](https://claude.ai/code) 的 AI 交互式语言学习系统。导入你自己的教材，提取结构化学习内容，按个性化课程计划学习 —— 全程自然对话。

三个技能：`/process-material`（导入与提取）、`/learn-language`（学习与练习）、`/practise`（自由对话）。支持任意语言组合。

---

## v2.1 更新

- **触发条件** — 明确指导何时使用每个技能
- **16 个示例** — 所有场景的详细输入→输出示例
- **质量检查清单** — 每次使用技能后的自我验证
- **错误处理** — 优雅处理常见故障
- **版本历史** — 跟踪各版本变更

### v2 功能

- **间隔重复** — 内置词汇掌握度评分和语法复习调度。每 5 课一次复习课。
- **统一状态** — `progress.json` + `course.json` 合并为单个 `state.json`。
- **`/practise` 模式** — 目标语言自由对话 + 实时纠错。
- **自动续课** — 返回课程时跳过设置，直接显示进度卡片。

---

## 技能概览

### `/process-material` — 教材处理器

导入原始教材并转换为结构化数据。

**何时使用：**
- 你有教材（PDF、Word、Excel）需要处理
- 你想提取词汇、语法或阅读段落
- 你正在设置新的学习项目

### `/learn-language` — 语言导师

带间隔重复和进度跟踪的交互式课程。

**何时使用：**
- 你想学习一门新语言
- 你想继续之前的学习会话
- 你想要结构化的词汇、语法、阅读、写作或文化课程

### `/practise` — 对话练习

用目标语言进行自由对话，实时纠错。

**何时使用：**
- 你想练习口语/写作
- 你想要非正式的对话练习
- 你想在低压环境中测试你的技能

---

## 错误处理

每个技能都能优雅处理常见故障：

- **编码检测失败** → 回退到常见编码（UTF-8、GBK、Shift-JIS）
- **PDF 转换失败** → 建议替代方法（OCR、在线工具）
- **状态文件损坏** → 从备份自动恢复或重新开始
- **教材缺失** → 建议先运行 `/process-material`

---

## 快速开始

**一键安装：**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python
```

1. 将教材放入 `materials/input/`（PDF、Word、Excel、CSV 等）
2. 打开 Claude Code，运行 `/process-material` 提取词汇、语法和段落
3. 运行 `/learn-language` 开始交互式课程
4. 随时使用 `/practise` 进行自由对话练习

---

## 另请参阅

- [Cyber-Eros.skill](https://github.com/mlkgrnt/Cyber-Eros.skill) — 同一作者的沉浸式角色扮演系统

---

## 许可证

MIT
