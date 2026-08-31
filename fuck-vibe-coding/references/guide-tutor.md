# Tutoring Round Checklist (guide-tutor)

**Audience:** Per-round tutoring agent.  
**≤80 lines · pure checklist · skim before asking or after a wrong answer.**

**Forbidden:** Reading `guide-design.md` or the full SKILL “for compliance” inside the tutoring loop.

---

## Hard bar each round (3b0)

- [ ] **≤1 teaching block** this round (5–20 line citation + explanation)
- [ ] Code citation first → explain → then (optional) 1 question
- [ ] Sync `Chat Learned Content` (include **plain-language narrative** 2–4 sentences)

---

## Good vs bad questions

| Bad (forbidden) | Good (use) |
|-----------------|------------|
| “Which branch does this if take?” — one-line read | “Why two-phase reboot instead of sleep?” |
| Enum/literal parroting | “What if we remove this NTP registration?” |
| Unrelated to this round’s citation | “Should change X hook INIT or ACTIVE_DONE?” |
| Six blocks then one question on the last | One block this round; question tests that block’s design/pitfall |
| “Which callback did L81 register?” | “Why not sleep directly at L142?” |

**Ask what you showed:** every line referenced in the question **must appear in this round’s citation**.

---

## Misconception handling (3 steps)

1. **Counterexample** code citation (prediction vs actual)
2. **Point to line:** “Your prediction conflicts with `{file}:{line}` because…”
3. **Brief fix** → wait until user gets it → continue; no question-only drills

---

## Dual-model check (end of each teaching block)

- [ ] **Program model:** Where does control enter; next hop `{file}:{line}`?
- [ ] **Domain model:** What does this step mean for the product/state/data?

If either is missing, the block isn’t done — **don’t** advance segment.

---

## Fade questioning (`--level`)

| level | blocks/round | confirm questions |
|-------|--------------|-------------------|
| **beginner** | 1 | optional; design/pitfall only; or wait for “continue” |
| **intermediate** | 1–2 | at most 1 question per 2 blocks |
| **advanced** | 2–3 | Predict/Extend; minimal scaffold |

User says “ask about what you show” / “don’t phone it in” → immediately **1 block/round**; design questions only or no question this round.

---

## `--resume` add-on (see SKILL §Resume session)

- [ ] Pop **≤2** due items from `Spaced Review Queue` first
- [ ] Then anchor segment and continue; no re-dump of ✅ segments
