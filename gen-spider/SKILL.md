---
name: gen-spider
description: Generate deliverable spider/web automation implementations through a gated workflow, including real-site probing, API-first execution, compliance confirmation, and code delivery. Use when users ask to write crawler code, scrape website data, handle login-initialized extraction, or convert exploration results into runnable code.
---

# Gen-Spider

Use this skill to transform spider/web automation requests into runnable code and enforce strict gates.

Recommended execution flow uses `curl` or `agent browser`.

## Input Contract

Normalize user intent into five slots:

- `src`: target URL/domain
- `do`: business goal and success criteria
- `scope`: boundaries (pages, volume, frequency, depth)
- `auth`: auth/session assumptions
- `output`: expected format and destination

If information is incomplete, apply **lenient trigger** behavior: state assumptions explicitly and ask only one critical question per turn.

## Mandatory Workflow

1. **Default Real-Site Probe**
   - Probe `src` by default (unless the user explicitly forbids).
   - Return an evidence summary: page type, auth/friction signals, candidate interfaces.
2. **Entry Shape + Strategy Decision**
   - Classify entry shape (static/dynamic/form/pagination/download/auth flow).
   - Present execution strategy and rationale.
3. **API-First Execution**
   - Final task execution must prioritize API calls.
   - Browser automation is allowed only for initialization (for example login/click) to obtain credentials/session artifacts.
4. **All-Source API Allowance**
   - Candidate APIs may include official APIs, page-observed private endpoints, and reverse-engineered signed endpoints.
5. **Risk Double Confirmation**
   - If legal/TOS/platform risk is explicit, clearly warn and require explicit user confirmation before continuing.
6. **Mandatory Request/Response Schema Artifacts**
   - Before coding, generate and save schemas for all critical interfaces (request fields, response fields, types, required/optional, example values).
   - At minimum, persist:
     - `schemas/request/*.json`
     - `schemas/response/*.json`
     - `schemas/examples/*.json`
   - If schema artifacts are incomplete, coding gate is not passed.
7. **Mandatory Pre-Coding Exploration Markdown**
   - Before coding, generate `EXPLORATION_REPORT.md` including:
     - exploration path and key trial-and-error steps
     - failed attempts and rejection reasons
     - final viable chain and supporting evidence
     - risks and boundaries
   - Without this report, coding is blocked.
8. **Coding Start Gate**
   - Do not generate implementation code until all are true:
     - explicit user intent to start coding
     - at least one reproducible API sample (URL/headers/payload/response)
     - one minimum end-to-end loop succeeds and satisfies `do`
9. **Command-Locked Start**
   - When gates are met, ask user to send this exact command:
   - `I confirm this plan is feasible, acknowledge the legal risks, and authorize coding to begin.`
   - Only exact match unlocks implementation.
10. **Implementation Delivery**
   - Follow user-specified stack first; default to Python if unspecified.
   - Deliver fixed five artifacts:
     - `main.*`
     - dependency manifest (`requirements/lock`)
     - `README`
     - `config.example`
     - `sample_output`
11. **Failure Guardrail**
   - After two consecutive failures on the same key action, stop blind retries, return to probe/strategy, and escalate to HITL if still uncertain.

## Autonomy Hard Constraints

- The agent must autonomously complete the full `do` path, including trial-and-error.
- Do not ask users for mid-process page clicking or manual takeover, except when required credential files/keys/accounts are missing.
- Do not output solutions that depend on user clicking pages during runtime.
- If full automation is impossible, explicitly mark as non-automatable and explain the blocking point.

## TDD Rules (when TDD is enabled)

- Write failing tests before implementation (red-green-refactor).
- **Schema validation is mandatory**. At minimum include:
  - request schema validation (missing fields, wrong types, invalid enum)
  - response schema validation (field drift, type drift, missing required fields)
  - schema/example consistency validation
- If schema validation tests are missing, TDD is not complete.

## Interaction Rules

- One question per turn during clarification.
- Do not mix clarification turns with implementation code.
- If user statements conflict with probe evidence, prioritize evidence and ask single-point confirmation.
- Keep all assumptions explicit and revisable.
- In non-credential-gap scenarios, do not request user “midway page clicking” assistance.

## Output Templates

### Probe Summary

- Target: `<src>`
- Entry shape: `<type>`
- Auth/friction signals: `<signals>`
- Candidate APIs: `<list>`
- Chosen strategy: `<why this path>`
- Risks: `<none or explicit>`
- Next single question: `<only one>`

### Gate-Ready Notice

- Reproducible API sample: `yes/no`
- Minimum loop success for `do`: `yes/no`
- Risk confirmation needed: `yes/no`
- Schema artifacts complete and saved: `yes/no`
- `EXPLORATION_REPORT.md` generated: `yes/no`
- If all pass, ask user to send exact command:
- `I confirm this plan is feasible, acknowledge the legal risks, and authorize coding to begin.`

### Final Delivery Checklist

- [ ] `main.*` is runnable
- [ ] dependency manifest is present
- [ ] `README` includes run steps and caveats
- [ ] `config.example` includes required fields
- [ ] `sample_output` matches requested data shape
