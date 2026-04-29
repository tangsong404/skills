# skills

A set of Skills I personally create and maintain.

---

## Quick Start

Run the following command to install:

```bash
npx skills@latest add tangsong404/skills
```

## Skill Overview

### gen-spider

A code-generation skill for web scraping and browser automation, following an "explore first, implement later" workflow: the agent first completes the full user-requested flow, then distills practical documentation and request/response Schemas from real test results, providing reliable inputs for subsequent To-PRD and TDD stages.

Works best when used together with the [agent-browser](https://github.com/vercel-labs/agent-browser) skill.

```bash
npx skills@latest add tangsong404/skills/gen-spider
```

### everything-find

Uses Everything search to replace native lookup commands such as `where`, improving agent search efficiency across global or large path ranges.

Before using this skill, make sure your system is Windows.

```bash
npx skills@latest add tangsong404/skills/everything-find
```

### ragret

Provides agent query support for [RAGret](https://github.com/tangsong404/RAGret), the knowledge-base application I developed.

Before using this skill, make sure you or your organization has deployed the RAGret application.

```bash
npx skills@latest add tangsong404/skills/ragret
```
