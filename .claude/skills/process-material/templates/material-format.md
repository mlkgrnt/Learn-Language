# Imported Materials Storage Format

When the user imports learning materials, extract and store them in structured JSON files under a `materials/` directory in the project root.

## Directory Structure

```
materials/
├── vocabulary.json    # Extracted word list
├── grammar.json       # Extracted grammar points
└── topics.json        # Extracted themes and passages
```

## vocabulary.json

Each entry represents one vocabulary item extracted from imported materials.

```json
{
  "source": "filename or description of imported material",
  "importDate": "2026-05-24",
  "language": "English",
  "words": [
    {
      "id": 1,
      "word": "accomplish",
      "pronunciation": "/əˈkʌmplɪʃ/",
      "partOfSpeech": "verb",
      "meaning": "完成，达成",
      "meaningEn": "to succeed in doing something",
      "example": "She accomplished her goal of running a marathon.",
      "exampleTranslation": "她完成了跑马拉松的目标。",
      "collocations": ["accomplish a task", "accomplish a goal", "accomplish a mission"],
      "level": "B2",
      "tags": ["academic", "formal"],
      "reviewCount": 0,
      "mastery": 0
    }
  ]
}
```

### Field Descriptions

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Unique identifier within the word list |
| `word` | string | The word in target language |
| `pronunciation` | string | IPA or romanization |
| `partOfSpeech` | string | noun, verb, adj, adv, prep, conj, etc. |
| `meaning` | string | Translation in user's native language |
| `meaningEn` | string | Definition in target language (optional, for higher levels) |
| `example` | string | Example sentence |
| `exampleTranslation` | string | Translation of example sentence |
| `collocations` | string[] | Common word pairings |
| `level` | string | Estimated CEFR level |
| `tags` | string[] | Category tags (academic, daily, business, etc.) |
| `reviewCount` | int | Times reviewed in lessons |
| `mastery` | int | 0-100 mastery percentage |

## grammar.json

Each entry represents one grammar point extracted from imported materials.

```json
{
  "source": "filename or description of imported material",
  "importDate": "2026-05-24",
  "language": "English",
  "grammarPoints": [
    {
      "id": 1,
      "name": "Present Perfect Continuous",
      "nameTarget": "现在完成进行时",
      "level": "B1",
      "structure": "Subject + have/has + been + verb-ing",
      "rule": "表示从过去开始持续到现在的动作，强调动作的持续性。",
      "examples": [
        {
          "sentence": "I have been studying English for three years.",
          "translation": "我已经学英语学了三年了。"
        },
        {
          "sentence": "She has been waiting for the bus since morning.",
          "translation": "她从早上就在等公交车。"
        }
      ],
      "commonMistakes": [
        {
          "wrong": "I am studying English for three years.",
          "right": "I have been studying English for three years.",
          "reason": "用 for/since 表示持续时间时，应用完成进行时而非进行时。"
        }
      ],
      "relatedPoints": ["present_perfect_simple", "present_continuous"],
      "tags": ["tense", "aspect"],
      "reviewCount": 0,
      "mastery": 0
    }
  ]
}
```

### Field Descriptions

| Field | Type | Description |
|-------|------|-------------|
| `id` | int | Unique identifier |
| `name` | string | Grammar point name in English |
| `nameTarget` | string | Grammar point name in user's native language |
| `level` | string | CEFR level |
| `structure` | string | The grammatical pattern/formula |
| `rule` | string | Explanation of when and how to use |
| `examples` | object[] | Array of {sentence, translation} pairs |
| `commonMistakes` | object[] | Array of {wrong, right, reason} |
| `relatedPoints` | string[] | IDs of related grammar points |
| `tags` | string[] | Category tags (tense, clause, modal, etc.) |
| `reviewCount` | int | Times reviewed in lessons |
| `mastery` | int | 0-100 mastery percentage |

## topics.json

Each entry represents a reading passage or thematic content extracted from imported materials.

```json
{
  "source": "filename or description of imported material",
  "importDate": "2026-05-24",
  "language": "English",
  "topics": [
    {
      "id": 1,
      "title": "A Day in London",
      "level": "A2",
      "genre": "narrative",
      "content": "Last summer, I visited London with my family...",
      "contentTranslation": "去年夏天，我和家人去了伦敦...",
      "vocabularyIds": [1, 2, 3],
      "grammarIds": [1],
      "comprehensionQuestions": [
        {
          "question": "When did the author visit London?",
          "answer": "Last summer."
        }
      ],
      "tags": ["travel", "daily-life"],
      "used": false
    }
  ]
}
```

## Extraction Rules

When importing materials, follow these rules:

1. **Vocabulary extraction**: Identify words that are above the user's current level or marked as important. Include context (the sentence where the word appeared).
2. **Grammar extraction**: Identify grammatical structures, patterns, and rules. Preserve the original explanation if clear, otherwise rewrite.
3. **Topic extraction**: Preserve passages that can serve as reading material. Note which vocabulary and grammar points appear in each passage.
4. **Deduplication**: Check against existing materials before adding. Update rather than duplicate.
5. **Level estimation**: Estimate CEFR level for each item based on complexity and the levels.md reference.
6. **Cross-referencing**: Link vocabulary and grammar items that appear in the same topic.
