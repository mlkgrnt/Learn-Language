# Vocabulary Extraction Rules

Use these rules when extracting vocabulary items from learning materials.

For the output JSON schema, see `material-format.md`.

## What Counts as a Vocabulary Item

Extract items that meet ANY of these criteria:

| Type | Examples | Include? |
|------|----------|----------|
| Single word | "accomplish", "environment" | Yes |
| Phrasal verb | "give up", "look forward to" | Yes |
| Idiom | "break the ice", "piece of cake" | Yes |
| Collocation | "make a decision", "heavy rain" | Yes, if taught as a unit |
| Proper noun | "London", "Shakespeare" | Only if culturally important |
| Function word | "the", "of", "and" | Only at A1 level |

### Skip These
- Words that are clearly below the target level (e.g., "cat", "big" at B2)
- Variant forms of already-extracted words (e.g., don't add "running" if "run" is already extracted — note the form in tags instead)
- Grammar-only items (e.g., "was" as part of past tense rule — this belongs in grammar.json)

## Extraction Process

### Step 1 — Identify the Target Language

From the source material, determine:
- **Target language**: the language being taught
- **Native language**: the language used for explanations/translations (determine from the source material or the user's communication language)

If the material is monolingual, the target language is the material's language. Translations must be generated, not left blank.

### Step 2 — Scan for Vocabulary Items

Go through the source text systematically:

1. **Word lists / glossaries**: Extract every entry directly. These are the easiest — the author already curated them.
2. **Bolded or highlighted words**: In textbooks, words in bold/italic/underline are typically vocabulary items.
3. **Marginal annotations**: Side notes with translations are vocabulary items.
4. **Contextual identification**: For materials without explicit markers, identify words that:
   - Are above the expected level of the surrounding text
   - Are used repeatedly in the chapter (suggesting they're being taught)
   - Appear in example sentences that demonstrate their usage
   - Are part of a themed vocabulary set (food, travel, etc.)

### Step 3 — Extract Fields for Each Item

For each vocabulary item, extract:

| Field | Source | Rules |
|-------|--------|-------|
| `word` | Source text | The dictionary/base form, not conjugated. E.g., "go" not "went" |
| `pronunciation` | Source text or generate | IPA if available. For CJK: romanization (pinyin, romaji, etc.) |
| `partOfSpeech` | Source text or infer | noun, verb, adj, adv, prep, conj, phr.v, idiom, etc. |
| `meaning` | Source text or generate | Translation in native language. Be concise: 1-3 meanings max |
| `meaningEn` | Generate | English definition. Include for B1+ levels. Keep to one sentence |
| `example` | Source text | The sentence where the word appeared. If none in source, create one |
| `exampleTranslation` | Generate | Translate the example sentence to native language |
| `collocations` | Source text or generate | 2-4 common pairings. Prioritize ones from the source material |
| `level` | Estimate | See level estimation rules below |
| `tags` | Infer | Category tags: academic, daily, business, travel, etc. |

### Step 4 — Generate Missing Fields

Some fields may not be in the source material. Generate them:

- **Pronunciation**: If missing, generate IPA (or romanization for non-Latin scripts). Verify accuracy.
- **meaningEn**: If missing and level is B1+, write a one-sentence definition in English.
- **Example sentence**: If the source only has a word list without sentences, create a natural, level-appropriate sentence.
- **Collocations**: If the source doesn't provide them, generate 2-3 of the most common pairings.

Mark generated fields internally — if you're unsure about a generated value, prefer the source material's version.

## CEFR Level Estimation

Estimate the level based on these criteria:

### Word Frequency Tier

| Frequency | Typical Level | Examples |
|-----------|---------------|----------|
| Top 500 most common | A1 | go, eat, big, good |
| Top 1000 | A2 | afford, describe, necessary |
| Top 2500 | B1 | accomplish, efficient, significant |
| Top 5000 | B2 | ambiguous, pragmatic, undermine |
| Top 10000 | C1 | ubiquitous, ephemeral, sycophant |
| Beyond 10000 | C2 | sesquipedalian, defenestrate |

### Adjustments

- **Register**: Formal/academic words get +1 level. E.g., "purchase" (formal) is B1, while "buy" (informal) is A1.
- **Domain-specific**: Technical jargon (medical, legal, IT) is typically B2+.
- **Idioms/Phrasal verbs**: Basic idioms are A2-B1. Complex idioms are B2+. Most phrasal verbs are A2-B1.
- **Multi-word expressions**: Generally +1 level compared to their component words.
- **Source material level**: If the material states a CEFR level, use it as the primary reference. Adjust only if clearly wrong.

## Deduplication

Before adding a new item, check existing `materials/vocabulary.json`:

1. **Exact match** (same word, same part of speech): Skip. Update if the new source has better examples.
2. **Same word, different POS**: Add as a separate entry. E.g., "run" (verb) and "run" (noun) are two entries.
3. **Variant form** (running, ran, runs): Don't add. Note in the existing entry's tags if needed.
4. **Similar meaning, different word**: Add as separate entries. Link via tags if useful.

## Quality Checklist

Before writing to `vocabulary.json`, verify each item:

- [ ] Word is in base/dictionary form
- [ ] Pronunciation is accurate (IPA or correct romanization)
- [ ] Part of speech is correct
- [ ] Meaning translation is natural and concise (not word-for-word)
- [ ] Example sentence is grammatically correct and demonstrates the word's usage
- [ ] Example translation is natural (not literal)
- [ ] Level is reasonable (cross-check with frequency data)
- [ ] No duplicate of an existing entry
- [ ] Collocations are real and commonly used (not invented)

## Common Pitfalls

- **Don't extract every word**: Only extract words that are being taught or are above the target level. "The", "is", "and" are not vocabulary items at B2.
- **Don't confuse word forms**: "Beautiful" and "beautifully" are the same base word. Extract "beautiful" and note the adverb form.
- **Don't use literary/unnatural examples**: Example sentences should sound like something a real person would say or write.
- **Don't over-collocate**: 2-4 collocations per word is enough. Don't list every possible combination.
- **Don't estimate level by gut feeling**: Use the frequency tier table above. When in doubt, check against CEFR word lists.
