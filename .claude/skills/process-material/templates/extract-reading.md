# Reading Passage & Dialogue Extraction Rules

Use these rules when extracting reading passages, dialogues, and thematic content from learning materials.

For the output JSON schema, see `material-format.md`.

## What Counts as a Topic Entry

Extract any text that can serve as reading/listening material:

| Type | Examples | Include? |
|------|----------|----------|
| Reading passage | Articles, stories, essays, descriptions | Yes |
| Dialogue/Conversation | Two or more speakers exchanging lines | Yes |
| Mixed text | Passage with embedded dialogue | Yes |
| Letter/Email | Formal or informal correspondence | Yes |
| Announcement/Notice | Public signs, ads, instructions | Yes, if level-appropriate |
| Song/Poem | Lyrics, poems with educational value | Yes, if level-appropriate |
| Table/Infographic text | Data descriptions, chart interpretations | Yes, if there's enough text |

### Skip These
- Single example sentences (these belong in vocabulary.json or grammar.json)
- Pure grammar explanations without narrative context
- Exercise prompts ("Fill in the blank: ___")
- Index pages, table of contents, copyright pages

## Extraction Process

### Step 1 — Identify Passage Boundaries

A passage starts and ends based on:

- **Explicit markers**: Headings, titles, "Reading:", "Text:", "Dialogue:", numbered sections
- **Topic shift**: A change in subject, setting, or speaker set
- **Length**: If a continuous text exceeds ~800 words, consider splitting into logical sub-sections
- **Structural markers**: Blank lines, horizontal rules, page breaks in converted text

### Step 2 — Classify the Genre

Assign one genre tag to each passage:

| Genre | Description | When to Use |
|-------|-------------|-------------|
| `narrative` | Stories, personal experiences, biographies | Has characters, events, timeline |
| `expository` | Informational, factual, explanatory | Presents facts, explains concepts |
| `dialogue` | Conversation between two or more speakers | Has speaker labels, turn-taking |
| `descriptive` | Descriptions of places, people, things | Focuses on sensory details |
| `instructional` | Instructions, recipes, how-to guides | Imperative mood, sequential steps |
| `persuasive` | Arguments, opinions, reviews | Has a thesis, supporting points |
| `letter` | Formal or informal correspondence | Has greeting, body, closing |
| `news` | News articles, reports | Who-what-when-where-why structure |

### Step 3 — Extract Fields

For each topic entry, extract:

| Field | Source | Rules |
|-------|--------|-------|
| `title` | Source text or generate | Descriptive title. If none in source, create one based on content |
| `level` | Estimate | See level estimation below |
| `genre` | Classify | From the genre table above |
| `content` | Source text | The full passage in target language. Clean up formatting |
| `contentTranslation` | Generate | Full translation in native language |
| `vocabularyIds` | Cross-reference | IDs from vocabulary.json that appear in this passage |
| `grammarIds` | Cross-reference | IDs from grammar.json that are demonstrated in this passage |
| `comprehensionQuestions` | Source text or generate | See question generation rules below |
| `tags` | Infer | Topic tags: travel, daily-life, business, culture, etc. |

### Step 4 — Clean Up Content

When extracting from converted PDFs or messy source text:

**Remove:**
- Page numbers, headers/footers
- Exercise instructions embedded in the passage ("Answer the following questions:")
- Margin notes that aren't part of the passage
- Formatting artifacts (random line breaks, extra spaces)

**Preserve:**
- Paragraph structure
- Speaker labels in dialogues
- Emphasis markers (bold, italic) if they indicate vocabulary items
- Punctuation and spacing

**Dialogue formatting:**
Standardize speaker labels to a consistent format:
```
A: Hello, how are you?
B: I'm fine, thank you. And you?
A: I'm doing well.
```

If the source uses different formats (names, dashes, colons), convert to the above. Preserve the speaker's name if it's meaningful (e.g., "Maria:", "Teacher:").

### Step 5 — Generate Comprehension Questions

If the source material already has comprehension questions, extract them directly.

If not, generate questions following this template:

| Question Type | Count | Purpose | Example |
|---------------|-------|---------|---------|
| Literal comprehension | 2 | Test understanding of explicit information | "Where did the author go?" |
| Inferential | 1 | Test reading between the lines | "Why do you think she felt sad?" |
| Vocabulary in context | 1 | Test understanding of a word's meaning in context | "What does 'accomplished' mean here?" |
| Personal response | 1 | Encourage opinion and connection | "Have you ever had a similar experience?" |

Rules for question generation:
- Questions should be answerable from the passage
- Literal questions should have clear, unambiguous answers
- Inferential questions should be reasonable, not tricky
- Vocabulary questions should target words that are being taught
- Personal response questions should be open-ended

## Length Guidelines

| Level | Passage Length | Dialogue Length |
|-------|---------------|-----------------|
| A1 | 50-100 words | 4-6 exchanges |
| A2 | 80-150 words | 6-10 exchanges |
| B1 | 150-250 words | 8-14 exchanges |
| B2 | 200-350 words | 10-20 exchanges |
| C1 | 300-500 words | 15-25 exchanges |
| C2 | 400+ words | 20+ exchanges |

If a passage in the source material is significantly longer, consider splitting it into 2-3 linked entries with sequential titles (e.g., "A Day in London (Part 1)", "A Day in London (Part 2)").

## CEFR Level Estimation

Estimate based on these factors:

| Factor | A1-A2 | B1-B2 | C1-C2 |
|--------|-------|-------|-------|
| Sentence structure | Simple, short | Mixed simple/complex | Complex, embedded clauses |
| Vocabulary range | High-frequency words | Mixed frequency | Low-frequency, specialized |
| Text length | Short | Medium | Long |
| Cohesion devices | and, but, because | however, although, despite | nevertheless, notwithstanding |
| Implicit meaning | None | Some | Significant |
| Cultural references | None | Common | Nuanced, idiomatic |

### Adjustment Rules
- If the source material states a level, use it as primary reference
- A passage's level should be no higher than the chapter/unit it appears in
- Dialogues tend to be slightly easier than passages of the same level (spoken language is simpler)

## Cross-Referencing

After extracting all passages, link them to vocabulary and grammar:

1. Scan each passage for words in `vocabulary.json` → add their IDs to `vocabularyIds`
2. Scan each passage for grammar patterns in `grammar.json` → add their IDs to `grammarIds`
3. If a passage introduces NEW vocabulary or grammar not yet extracted, extract those items first, then link

**Important**: Only link items that are ACTUALLY demonstrated in the passage, not items that happen to appear. A passage about travel that uses past tense should link to "past_simple" only if the past tense usage is notable or instructive, not just because past tense verbs exist in the text.

## Quality Checklist

Before writing to `topics.json`, verify each entry:

- [ ] Content is clean (no artifacts, proper formatting)
- [ ] Title is descriptive and level-appropriate
- [ ] Genre classification is accurate
- [ ] ContentTranslation is natural (not word-for-word literal)
- [ ] At least 3 comprehension questions exist
- [ ] Comprehension questions are answerable from the passage
- [ ] vocabularyIds and grammarIds reference real items in the other JSON files
- [ ] Length is within guidelines for the estimated level
- [ ] Dialogue formatting is consistent (if applicable)
- [ ] No content that belongs in vocabulary.json or grammar.json instead

## Handling Special Cases

### Bilingual Texts
If the source has side-by-side translation (target language + native language), use the target language as `content` and the native language as `contentTranslation`. Do not include both in `content`.

### Illustrated Content
If the source has images, diagrams, or charts that are essential to understanding:
- Describe the visual in a note within `content`: "[Image: A map of London showing the route from the hotel to the museum]"
- Do not attempt to reproduce the image

### Graded Readers
If the source is a graded reader (a book designed for language learners at a specific level):
- Extract chapters as individual topic entries
- The reader's stated level should be the primary level reference
- Include chapter titles and sequential ordering in tags

### Mixed Exercises and Text
If a page has both a reading passage and exercises intermixed:
- Extract only the passage text into `content`
- Extract comprehension questions if they're about the passage
- Skip unrelated exercises (fill-in-the-blank, matching, etc.) — these are for the lesson engine, not the material store
