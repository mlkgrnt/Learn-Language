# 語言學習助手

基於 [Claude Code](https://claude.ai/code) 的 AI 互動式語言學習系統。匯入你自己的教材，提取結構化學習內容，按個人化課程計畫學習 —— 全程自然對話。

三個技能：`/process-material`（匯入與提取）、`/learn-language`（學習與練習）、`/practise`（自由對話）。支援任意語言組合。

---

## v2.1 更新

- **觸發條件** — 明確指導何時使用每個技能
- **16 個範例** — 所有場景的詳細輸入→輸出範例
- **品質檢查清單** — 每次使用技能後的自我驗證
- **錯誤處理** — 優雅處理常見故障
- **版本歷史** — 追蹤各版本變更

### v2 功能

- **間隔重複** — 內建詞彙掌握度評分和語法複習排程。每 5 課一次複習課。
- **統一狀態** — `progress.json` + `course.json` 合併為單一 `state.json`。
- **`/practise` 模式** — 目標語言自由對話 + 即時糾錯。
- **自動續課** — 返回課程時跳過設定，直接顯示進度卡片。

---

## 技能概覽

### `/process-material` — 教材處理器

匯入原始教材並轉換為結構化資料。

**何時使用：**
- 你有教材（PDF、Word、Excel）需要處理
- 你想提取詞彙、語法或閱讀段落
- 你正在設定新的學習專案

### `/learn-language` — 語言導師

帶間隔重複和進度追蹤的互動式課程。

**何時使用：**
- 你想學習一門新語言
- 你想繼續之前的學習會話
- 你想要結構化的詞彙、語法、閱讀、寫作或文化課程

### `/practise` — 對話練習

用目標語言進行自由對話，即時糾錯。

**何時使用：**
- 你想練習口語/寫作
- 你想要非正式的對話練習
- 你想在低壓環境中測試你的技能

---

## 錯誤處理

每個技能都能優雅處理常見故障：

- **編碼偵測失敗** → 回退到常見編碼（UTF-8、GBK、Shift-JIS）
- **PDF 轉換失敗** → 建議替代方法（OCR、線上工具）
- **狀態檔案損壞** → 從備份自動恢復或重新開始
- **教材缺失** → 建議先執行 `/process-material`

---

## 快速開始

**一鍵安裝：**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python
```

1. 將教材放入 `materials/input/`（PDF、Word、Excel、CSV 等）
2. 開啟 Claude Code，執行 `/process-material` 提取詞彙、語法和段落
3. 執行 `/learn-language` 開始互動式課程
4. 隨時使用 `/practise` 進行自由對話練習

---

## 另請參閱

- [Cyber-Eros.skill](https://github.com/mlkgrnt/Cyber-Eros.skill) — 同一作者的沉浸式角色扮演系統

---

## 授權條款

MIT
