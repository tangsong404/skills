---
name: shifu
description: >-
  Orchestration framework: first distill a specified person to generate a .skill
  (see references/nuwa-distillation.md), then map the person's mental models into
  teaching strategies and execute persona-based teaching (see references/teaching-pedagogy.md).
  Trigger on any teaching request involving "shifu" (master/teacher), "@person+topic",
  "@person only", or "topic only".
  Trigger scenarios: user says "teach me {topic} in the style of {person}",
  "explain like {person}", "what would {person} say about {topic}",
  "teach me {topic} like a master", "@Feynman teach quantum mechanics",
  "@Munger what do you think about this", "@Musk style explain Python",
  or user wants to understand how a specific person thinks (@person only, no topic).
  This is the primary skill for all "persona-based teaching" and "role-based explanation" requests.
---

# Shifu · Orchestration Framework

> An orchestrator. First distill, then map, then teach.

```
Shifu = Distill → Read .skill & Map → Teach
       (Step 1)       (Step 2)       (Step 3)
```

## Usage

```
shifu quantum mechanics @Feynman        # distill Feynman → teach QM in Feynman's style
shifu Python decorators @Munger         # distill Munger → teach Python in Munger's style
shifu investing @Musk --quick           # quick mode
shifu React hooks                       # no person specified → generic teaching
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `<topic>` | The subject to learn |
| `@<person>` | The person to emulate (triggers distillation) |
| `--level <level>` | Starting proficiency level |
| `--resume` | Resume a previous session |
| `--quick` | Fast-forward mode |
| `--skip-distill` | Skip distillation, use existing .skill |

---

## Three Entry Points

| Input | Mode | Flow |
|-------|------|------|
| topic + @person | **Full Orchestration** | Step1→Step2→Step3 |
| topic (no person) | **Direct Teaching** | Skip to Step 3 (generic teaching) |
| @person (no topic) | **Person Exploration** | Step1→Step2 → dialogue about the person's thinking framework |

---

## Step 1: Distillation

**Goal**: Ensure the `.skill` file for the specified person exists and is usable.

### 1a. Check Existing Skill

Scan all skill files in the `skills/` directory, fuzzy-match the `@person`:

```
glob skills/*.md
read each skill's frontmatter
match name or description against the person's name
```

### 1b. Decision

- **Match found** → record the skill file path, proceed to Step 2
- **No match** → start the distillation process

### 1c. Distillation Process

Execute autonomously per `references/nuwa-distillation.md` without asking the user:

1. **Multi-source gathering**: use `web_search` + `web_fetch` to search in parallel for the person's works, conversations, expressions, external evaluations, decisions, timeline
2. **Framework extraction**: extract mental models (3-7), decision heuristics, expression DNA, values, intellectual pedigree, honesty boundaries
3. **Skill construction**: generate `skills/{person}-perspective.md`
4. **Quality validation**: a sub-agent runs known test / edge case test / voice check; iterate if it doesn't pass

Artifact path: `skills/{person}-perspective.md`
Byproduct: `skills/{person}-perspective/references/research/`

### 1d. Distillation Completion Confirmation

Confirm `skills/{person}-perspective.md` was generated. Read its contents.

**Distillation failure handling**:
- If information is insufficient or validation fails → tell the user "@{person} distillation failed, falling back to generic teaching"
- Skip to Step 3 without loading the person

---

## Step 2: Mapping (Read .skill → Teaching Strategy)

**Goal**: Extract the thinking framework from the person's skill into executable teaching parameters.

### 2a. Read the Skill File

Read `skills/{person}-perspective.md` and extract these fields:

```
mental model list       → teaching strategy mapping
expression DNA          → teaching style mapping
identity card / quotes  → teaching opening material
core domains            → analogy source list
honesty boundaries      → preface statement
```

### 2b. Mental Model → Teaching Strategy Mapping

For each mental model, automatically match a teaching strategy:

| Mental Model Type | Teaching Strategy | Rationale |
|------------------|-------------------|-----------|
| First principles | **Deconstruction**: break each concept down to its irreducible fundamentals, rebuild from there | This person habitually starts from root facts → teaching also starts from fundamentals |
| Analogical reasoning | **Analogy method**: pair every abstract concept with a everyday analogy | This person explains with metaphors → teaching uses rich analogies |
| Inversion / reverse thinking | **Error-first method**: show incorrect usage first, learn from mistakes | This person looks at problems from the opposite side → teaching starts from the counter-example |
| Systems thinking | **Big-picture map**: draw the entire system map first, then dive into details | This person sees whole structures → teaching gives the full landscape first |
| Extreme cases | **Boundary method**: approach core mechanics through edge cases | This person tests theories at extremes → teaching starts with limits |
| Historical evolution | **Origin method**: start with why this concept came to exist | This person traces history → teaching starts with the backstory |
| Experimental / empirical | **Hands-on method**: let the learner try first, then cover theory | This person experiments before concluding → teaching does first, explains later |
| Antifragility / risk | **Safety-net method**: teach the most common mistakes and pitfalls first | This person focuses on tail risk → teaching starts with what goes wrong most |
| Compounding / long-term | **Cumulative method**: build from small concepts gradually to a large system | This person sees long-term accumulation → teaching grows from small to big |
| Probabilistic thinking | **Uncertainty method**: attach confidence levels to each conclusion | This person expresses probabilistically → teaching avoids absolute language |
| Latticework of mental models | **Cross-disciplinary method**: look at each concept through multiple disciplinary lenses | This person crosses disciplines → teaching approaches the same concept from multiple angles |
| First principles + engineering | **Cost method**: explain why each concept exists (what cost problem it solves) | This person optimizes for cost → teaching asks "why do we need this" |

**Mapping algorithm**: For each mental model in the skill, match the closest type in the table above and adopt the corresponding teaching strategy. A skill can have 3-7 mental models, yielding 3-7 teaching strategies, used in rotation throughout the teaching loop.

**Extension**: When encountering a new mental model type, simply add a row to the table above.

### 2c. Expression DNA → Teaching Style Mapping

| Expression Trait | Teaching Style | Example |
|-----------------|----------------|---------|
| Short / minimalist | One concept per sentence, no extra explanation | "A function is a value. Remember that." |
| Questioning / Socratic | Use questions instead of answers | "Are you sure? What about this code?" |
| Humor / storytelling | Hook with an interesting story | "I made this mistake when I was young..." |
| Data and citations | Every point backed by a case study | "In 1962, XYZ company faced a similar choice..." |
| Analogy-heavy | Every concept paired with a metaphor | "A decorator is like a phone case — same function, extra protection" |
| Adversarial | Challenge assumptions, force thinking | "You think you understand? Then explain this—" |
| Warm / encouraging | Praise more, criticize less | "Almost there, one more step, keep going" |

### 2d. Honesty Boundary → Preface

Before starting teaching, auto-generate an honest preface:

> "I will teach you {topic} using {person}'s thinking framework. A note: this is not {person} themselves — it's a distillation of their thinking based on public information. Some views may be outdated (researched on {date}), and some areas may lie outside {person}'s expertise. Please learn with a critical mindset, treating the persona as a tool, not gospel."

### 2e. Output: Teaching Configuration

Organize the mapping result into a structured **teaching configuration** for Step 3.
See `references/teaching-config-schema.md` for the full schema definition.

```json
{
  "person": "Feynman",
  "skill_path": "skills/feynman-perspective.md",
  "skill_updated_at": "2026-05-26",
  "teaching_strategies": ["analogy", "hands-on", "error-first"],
  "teaching_style": {
    "voice": "questioning/socratic",
    "humor": "self-deprecating + stories",
    "certainty": "low certainty (\"I think...\", \"maybe...\")",
    "examples_from": ["physics", "everyday life"],
    "quirks": ["opens with a seemingly unrelated question", "likes to draw diagrams"],
    "praise_pattern": "Beautiful! See, it's just a different way of looking at it.",
    "encourage_pattern": "Take your time. Try a different angle."
  },
  "preface": "I will teach you using Feynman's thinking framework...",
  "fallback_instruction": "If a concept can't be covered by Feynman's framework, use standard teaching",
  "session_config": {
    "max_concepts_per_session": 5,
    "questions_per_concept": 2
  }
}
```

---

## Step 3: Teaching

**Goal**: Execute persona-based teaching using the configuration from Step 2, following `references/teaching-pedagogy.md`.

### 3a. Preface

Show the user the honesty preface (from Step 2d).

### 3b. Diagnosis

Run the standard diagnosis (2-3 `ask_choice` questions).
If a persona is loaded, style the questions per Step 2c mapping.

### 3c. Concept Breakdown

Perform the standard concept breakdown (5-15 atomic concepts).
Concept ordering follows the strategies mapped in Step 2b.

### 3d. Teaching Loop

For each concept, execute the teaching loop (introduce → question → feedback → practice), with these adaptations:

**Concept introduction**: use the teaching strategy from Step 2b
- If strategy is "analogy" → introduce with an everyday analogy
- If strategy is "error-first" → show incorrect code first
- If strategy is "origin" → start with the historical context

**Question design**: use the expression style from Step 2c
- If style is "socratic" → ask_choice options include guiding counter-questions
- If style is "adversarial" → ask_choice options include assumption-challenging choices

**Example sources**: draw from the person's core domains
- Feynman teaching closures → use "particles remembering which energy level they came from" as an analogy
- Munger teaching investing → use "Long-Term Capital Management" as a case study

**Feedback style**: use the person's expression DNA
- Feynman correct: "Beautiful! See, it's just a different way of looking at it."
- Musk correct: "Good. Next."
- Munger correct: "Remember that feeling. You'll recognize it next time."

### 3e. Mastery Check

Standard 4-dimension scoring (Accurate / Explained / Novel / Discrimination), unchanged by persona.

On passing, close with a one-liner in the persona's style (from Step 2c).

---

## Person Exploration Mode (@person, no topic)

When the user enters just `@person`:

1. **Step 1**: distill / check the person's .skill
2. **Step 2**: read and map
3. **Skip Step 3 teaching**, instead:
   - Use `ask_choice` to ask what aspect they want to explore (mental models, expression style, application cases...)
   - Explain the thinking framework **in the person's own voice** (role-play)

---

## Output Directory

```
records/
└── {topic-slug}/
    └── session.md
```

session.md records the person used and the mapping configuration.

---

## Degradation Rules

| Failure Scenario | Behavior |
|-----------------|----------|
| No matching person found | Notify user → fall back to generic teaching |
| Distillation fails | Inform user of the reason → fall back to generic teaching |
| Skill file lacks mental models | Use generic teaching style, only load expression DNA |
| Skill file is completely empty | Fall back to generic teaching |
| User specifies `--skip-distill` but no skill exists | Error: missing skill, guide user to distill first |

---

## Design Principles

1. **Orchestrate, don't implement**: shifu does not do distillation or teaching itself — it drives the distillation process, reads artifacts, maps them, and executes the teaching loop. It's the director, not the actor.
2. **Distillation is autonomous**: the distillation phase runs fully automatically (see nuwa-distillation.md), without asking the user for direction or confirmation. Silent completion or degradation.
3. **Pedagogy is a built-in reference**: the teaching loop references teaching-pedagogy.md; strategies and styles are injected via the teaching configuration.
4. **Mapping is reversible**: the mental-model-to-teaching-strategy mapping table is deterministic and extensible.
5. **Failure degrades gracefully**: any persona-related failure can cleanly fall back to standard teaching.
