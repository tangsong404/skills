# Design Guide (guide-design)

**Audience:** Whoever designs `learning-path`, `tutor-brief`, and segment splits — or the first-pass **tutor study** agent.  
**Not** the per-round tutoring manual — see [`guide-tutor.md`](guide-tutor.md) for that.

---

## When to read this

| Scenario | Action |
|----------|--------|
| New topic or code change | **Required** — §Design checklist + §Step design |
| Splitting Step → segments | **Required** — §Segment split |
| Each tutoring round | **Do not read**; at most skim `guide-tutor.md` |

---

## Why it’s designed this way (1 page)

The seven pillars are already in SKILL; here we only map **essence → SKILL section** — no third repetition.

| Pillar | Essence (2 lines) | SKILL reference |
|--------|-------------------|-----------------|
| **Mastery learning** | Don’t advance until mastered; mastery = can edit code, not “seen the term” | Core rules 5–6; §3g segment ✅ |
| **Cognitive apprenticeship** | Expert thinking must be externalized: code first, then explain; fade scaffolds | Core rules 1–2; §3b teaching block |
| **Hypothesis-driven reading** | Goal = hypothesis to test; find beacons in code | §Learning step order; each Step Goal |
| **Dual mental models** | Program model (control flow) + domain model (business meaning) — both required | §Step mastery bar; guide-tutor dual-model check |
| **Flexible switching** | Top-down and bottom-up anytime; no line-by-line scan | §3b segment pacing |
| **Three architecture views** | Module → C&C → Allocation | §learning-path format; §Step templates |
| **Cognitive load** | One architecture question at a time; 1 block per round | §3b0; `--level` table |

**Questioning principle** (aligned with SKILL, not “ask more, explain less”): **code citation → explain → optional 1 design/pitfall question**. See SKILL §3c and [`guide-tutor.md`](guide-tutor.md).

---

## Step design (learning-path)

1. **Order:** Module overview → C&C main path → data flow/domain → Allocation/config → exceptions/helpers to fill lines
2. **One Step = one architecture hypothesis**, not “finish reading file X”
3. **Split each Step into 3–8 segments**, each a digestible sub-question (SKILL §Learning step design rule 7)
4. **Files & lines** = Step-level scope index, **≠** single session / single chat goal
5. Assign every countable line to a Step·segment; record in `line-coverage.md`

### Segment split example

```
Step 2 Goal: INIT→ACTIVE main path
  seg 1: main + deep-sleep gate
  seg 2: SM init/start + thread model
  seg 3: HAL callback registration chain
  …
```

---

## tutor-brief must include

- [ ] Architecture Summary (2–5 paragraphs)
- [ ] Module → Files table
- [ ] Key Call Chains (cross-file)
- [ ] File Coupling (core input for segment design)
- [ ] Confusing Boundaries (easy to mix up — flag for teaching)
- [ ] Open Questions cleared or labeled

---

## Design checklist (before study is “done”)

- [ ] Step order **Module → C&C → Allocation**?
- [ ] Each Step Goal is an architecture question/hypothesis, not “read file X”?
- [ ] Large Steps split into segments, each startable in 1 block/round?
- [ ] Each Step exercises **program model + domain model**?
- [ ] Real codebase, not a toy example?
- [ ] All lines assigned to Step·segment with no gaps?

---

## Misconceptions (anticipate at design time)

Mark **Confusing Boundaries** and typical vibe-coding traps (name-as-understanding, reversed causality, wrong plan).  
Counterexample handling at tutor time: [`guide-tutor.md`](guide-tutor.md) §Misconception handling.
