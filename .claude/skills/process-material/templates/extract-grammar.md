# Grammar Point Extraction Rules

Use these rules when extracting grammar points from learning materials.

For the output JSON schema, see `material-format.md`.

## What Counts as a Grammar Point

Extract items that meet ANY of these criteria:

| Type | Examples | Include? |
|------|----------|----------|
| Tense/Aspect | Present Perfect, Past Continuous | Yes |
| Sentence pattern | There is/are, It takes...to... | Yes |
| Conjugation rule | Regular -ed endings, irregular verb tables | Yes |
| Word order rule | Adjective-noun order, question formation | Yes |
| Particle/Connector | は/が (Japanese), although, however | Yes |
| Modal construction | must/might/can't for deduction | Yes |
| Clause type | Relative clauses, conditional clauses | Yes |
| Voice/Aspect | Passive voice, causative | Yes |
| Agreement rule | Subject-verb agreement, gender agreement | Yes |
| Register variation | Formal vs. informal address | Yes |

### Skip These
- Individual vocabulary items (these go in vocabulary.json)
- Pronunciation rules (not grammar)
- Spelling conventions (not grammar)
- Cultural notes without grammatical content

### Grammar vs. Vocabulary: Decision Rules

When unsure, apply these tests:

1. **Substitution test**: Can you replace this item with another word of the same type and the sentence still works? If yes → vocabulary. (e.g., "big" → "small", both work)
2. **Pattern test**: Does this item define a structural pattern that applies to many sentences? If yes → grammar. (e.g., "have + past participle" works for all verbs)
3. **Productivity test**: Can learners apply this rule to create new sentences? If yes → grammar. (e.g., the -ed rule works for all regular verbs)

## Extraction Process

### Step 1 — Identify Grammar Sections

In textbooks, grammar is typically found in:

- Sections explicitly labeled "Grammar", "语法", "Grammatik", etc.
- Tables showing conjugations, declensions, or patterns
- Numbered rules or explanations (e.g., "Rule: Use the present perfect for...")
- "Language focus" or "Structure" boxes
- Exercise sections that practice a specific pattern
- Dialogues followed by pattern analysis

### Step 2 — Determine Granularity

One "grammar point" should be:
- **Teachable in a single lesson** (40-45 min)
- **One coherent pattern or rule**, not a collection of unrelated rules

Examples of good granularity:
- "Present Perfect Simple" — one point
- "Past Simple Regular Verbs" — one point
- "Past Simple Irregular Verbs" — separate point (or combine with regular if taught together)
- "Articles (a/an/the)" — could be 1-3 points depending on complexity
- "Conditional sentences (types 0-3)" — 4 separate points, or 2 combined (0+1, 2+3)

When the source material groups multiple rules together (e.g., "All tenses"), split them into individual points. When it splits too finely (e.g., "the" vs "a" as separate lessons), combine them.

### Step 3 — Extract Fields

For each grammar point, extract:

| Field | Source | Rules |
|-------|--------|-------|
| `name` | Source text or generate | English name. Use standard linguistic terminology |
| `nameTarget` | Source text or generate | Name in native language (e.g., "现在完成进行时") |
| `level` | Estimate | See level estimation rules below |
| `structure` | Source text | The pattern/formula. Use placeholders: [Subject] + have/has + been + [verb]-ing |
| `rule` | Source text or rewrite | When and how to use. Concise, in native language. 1-3 sentences |
| `examples` | Source text or generate | 3-5 sentence pairs {sentence, translation} |
| `commonMistakes` | Source text or generate | 1-3 entries {wrong, right, reason} |
| `relatedPoints` | Infer | IDs of related grammar points (e.g., present_perfect → past_simple) |
| `tags` | Infer | Category: tense, clause, modal, voice, agreement, etc. |

### Step 4 — Extract Structure Patterns

Structure is the most important field. It should be a clear, parseable formula:

**Good patterns:**
```
[Subject] + have/has + [past participle]
[Subject] + would + [base verb] if [Subject] + [past simple]
It is + [adjective] + to + [verb]
```

**Bad patterns:**
```
"Use the present perfect for experiences"  ← too vague, this is the rule not the structure
"The verb changes to past participle"      ← doesn't show the pattern
```

Rules for structure extraction:
- Use `[Subject]`, `[verb]`, `[object]` etc. as placeholders
- Show ALL required components in order
- For conjugation tables, use the table format instead of a linear formula
- Include the negative and question forms if they differ significantly

### Step 5 — Extract or Generate Examples

Each example should demonstrate a DIFFERENT use of the grammar point:

| Example # | Should Show | Example (Present Perfect) |
|-----------|-------------|---------------------------|
| 1 | Basic affirmative use | "I have visited Paris twice." |
| 2 | Different context | "She has worked here since 2020." |
| 3 | Negative form | "They haven't finished yet." |
| 4 | Question form | "Have you ever eaten sushi?" |
| 5 | Contrasting use | "I have lived here for 5 years." vs "I lived there for 5 years." |

Rules:
- Every example MUST have both the target-language sentence AND its translation
- Examples should be natural, not contrived
- Vary the subjects (I, you, he, she, they, we)
- At least one example should be from the source material if available
- If generating examples, keep them level-appropriate

### Step 6 — Identify Common Mistakes

Common mistakes come from three sources:

1. **Source material explicitly states them**: Use directly.
2. **L1 interference**: Predict mistakes based on differences between the learner's L1 and the target language:
   - Languages without articles → article omission errors
   - Languages without verb conjugation → tense form errors
   - Different word order patterns → placement errors
   - Languages without grammatical gender → gender agreement errors
   - Adapt to the actual L1→target language pair when known
3. **Common learner errors**: Use standard linguistic knowledge of typical mistakes.

Format each mistake as:
```
Wrong: "I am living here for 5 years."
Right: "I have lived here for 5 years."
Reason: 用 for/since 表示持续时间时，应用完成进行时或完成时，不用一般进行时。
```

## CEFR Level Estimation

| Grammar Point | Typical Level |
|---------------|---------------|
| Basic word order, be, articles, present simple | A1 |
| Past simple, going to, can/must, comparatives | A2 |
| Present perfect, passive, reported speech, 1st/2nd conditionals | B1 |
| All conditionals, past perfect, inversion, cleft sentences | B2 |
| Advanced passives, subjunctive, nominalization, hedging | C1 |
| Full command, stylistic choices, error-free production | C2 |

### Adjustments
- If the source material assigns a level, use it as primary reference
- If a grammar point combines multiple structures (e.g., mixed conditionals), use the highest level among its components
- Language-specific: particles in Japanese (は/が) are A1 but their nuanced distinction is B1+

## Quality Checklist

Before writing to `grammar.json`, verify each point:

- [ ] Name is clear and uses standard terminology
- [ ] Structure shows the actual pattern (not a vague description)
- [ ] Rule explains WHEN to use, not just WHAT the form is
- [ ] At least 3 examples with translations
- [ ] Examples cover different uses (affirmative, negative, question, or different contexts)
- [ ] Common mistakes include at least 1 entry with clear reason
- [ ] Related points reference actual IDs that exist or will be created
- [ ] Level is consistent with the CEFR table above
- [ ] No overlap with already-extracted grammar points

## Handling Special Formats

### Conjugation Tables
If the source has a table (e.g., verb conjugation), preserve the table structure in the `examples` field or describe it in `structure`:

```json
{
  "structure": "Subject + be (conjugated) + verb-ing",
  "examples": [
    {"sentence": "I am working", "translation": "我在工作"},
    {"sentence": "She is working", "translation": "她在工作"},
    {"sentence": "They are working", "translation": "他们在工作"}
  ]
}
```

### Pattern Drills
If the source has drills (e.g., "I go → I went → I have gone"), extract the underlying rule, not the drill itself. The drill is for practice; the grammar point is what's being practiced.

### Grammar Notes in Dialogues
If a dialogue is followed by a grammar explanation, extract the grammar point and link it to the dialogue (which goes in topics.json). Reference the topic ID in the grammar point's tags.
