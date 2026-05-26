---
name: openspec-apply-tdd
description: Implement OpenSpec change tasks using Test-Driven Development (red-green-refactor). Use when the user wants to start implementing, continue implementing, or work through OpenSpec changes with TDD methodology. Combines OpenSpec change workflow with TDD's vertical-slice approach for building features one test at a time.
---

# OpenSpec Apply with TDD

Integrate OpenSpec change execution with Test-Driven Development. For each task in an OpenSpec change, use a RED-GREEN-REFACTOR loop instead of writing code directly.

## How the Two Approaches Combine

| OpenSpec Phase | TDD Phase |
|---|---|
| Select change, read context | **Planning**: Understand requirements, identify behaviors |
| Identify pending task | **Decompose** task into observable behaviors |
| — | **RED**: Write ONE test for first behavior |
| — | **GREEN**: Write minimal code to pass |
| — | **REFACTOR**: Deepen modules, clean up |
| Mark task complete | Repeat RED-GREEN-REFACTOR for each behavior |
| Next task | Continue TDD loop |

## Workflow

### 1. Select the Change

If a name is provided, use it. Otherwise infer from conversation context or use `openspec list --json` to let the user select.

Announce: "Using change: <name>"

### 2. Check Status

```bash
openspec status --change "<name>" --json
```

Parse the JSON to understand the schema being used and which artifact contains the tasks.

### 3. Get Apply Instructions

```bash
openspec instructions apply --change "<name>" --json
```

Read all context files listed under `contextFiles`. Understand what the change is about before planning.

**Handle states:**
- `blocked`: Show message, suggest updating artifacts
- `all_done`: Congratulate, suggest archive
- Otherwise: proceed to TDD implementation

### 4. TDD Implementation Loop (per task)

For each pending task, **do NOT write all code first**. Instead, decompose the task into individual observable behaviors and implement them one at a time via RED-GREEN-REFACTOR.

#### Per-Behavior Cycle

```
┌─────────────────────────────────┐
│  PLANNING: "What behavior does  │
│  this task need? What is the    │
│  public interface?"             │
└──────────┬──────────────────────┘
           ▼
┌─────────────────────────────────┐
│  RED: Write ONE test for this   │
│  behavior → test fails          │
│  (test describes WHAT, not HOW) │
└──────────┬──────────────────────┘
           ▼
┌─────────────────────────────────┐
│  GREEN: Write minimal code to   │
│  pass this test only            │
│  (don't anticipate future       │
│   tests)                        │
└──────────┬──────────────────────┘
           ▼
┌─────────────────────────────────┐
│  REFACTOR: Clean up while       │
│  tests stay green               │
│  (deepen modules, extract       │
│   duplication, never refactor   │
│   while RED)                    │
└──────────┬──────────────────────┘
           ▼
    ┌──────────────┐
    │ More behaviors? │
    ├───────┬────────┘
    │ YES   │ NO
    ▼       ▼
  Repeat   Task complete →
           Mark `- [x]` in tasks
           Continue to next task
```

**Rules for each cycle:**
- One test at a time — no batching
- Only enough code to pass current test — no speculative features
- Test describes observable behavior through public interface — no implementation details
- Never refactor while RED — get GREEN first
- Run tests after each refactor step

#### Planning Phase Details

Before the first RED test for a task, confirm with the user:
1. What the public interface should look like
2. Which behaviors to test first (prioritize critical paths and complex logic)
3. Identify opportunities for deep modules (small interface, deep implementation)
4. Design interfaces for testability: accept dependencies, return results

#### Test Quality Guidelines

Write **integration-style tests** that exercise real code paths through public APIs:
- Test WHAT the system does, not HOW it does it
- A passing test should mean the behavior works, not that internal methods were called
- Tests should survive internal refactors

**Mock only at system boundaries**: external APIs, databases (sometimes prefer test DB), time/randomness, file system. Never mock your own modules or internal collaborators.

Reference files for deeper guidance:
- `references/tests.md` — good vs bad test examples
- `references/mocking.md` — when and how to mock
- `references/deep-modules.md` — designing small interfaces with deep implementations
- `references/interface-design.md` — designing interfaces for testability
- `references/refactoring.md` — refactoring candidates after GREEN

#### Per-Task Completion

When all behaviors for a task are implemented:
1. Run the full test suite — everything should pass
2. Update the task checkbox: `- [ ]` → `- [x]`
3. Show summary of what was implemented
4. Continue to next task

### 5. On Completion or Pause

**Completion:**
```
## Implementation Complete

**Change:** <change-name>
**Schema:** <schema-name>
**Progress:** 7/7 tasks complete ✓

All tasks complete! Ready to archive this change.
```

**Pause (Issue Encountered):**
```
## Implementation Paused

**Change:** <change-name>
**Progress:** 4/7 tasks complete

### Issue
<description>

### Options
1. <option 1>
2. <option 2>
3. Other approach

What would you like to do?
```

### Guardrails

- Decompose each OpenSpec task into behaviors — don't implement everything at once
- One RED-GREEN-REFACTOR cycle per behavior — this is the core TDD discipline
- Always read context files BEFORE planning what to implement
- If a task is ambiguous, pause and ask before starting RED
- If implementation reveals a design issue, suggest updating artifacts
- Keep code changes focused on passing the current test — no speculative scope
- On errors or blockers, report and wait for guidance
