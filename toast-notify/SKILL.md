---
name: toast-notify
description: |
  INVOKE THIS SKILL AT THE END OF EVERY RESPONSE, before waiting for user input.
  This skill sends a Windows toast notification to the user's desktop reporting that
  the AI has completed its work. It MUST fire on EVERY completed turn — long or short,
  simple or complex — so the user knows when to return to their terminal. The only
  exception is if the user explicitly says they do NOT want notifications. ANY agent
  or subagent that can invoke skills MUST use this one at the end of every response.
---

# toast-notify

Sends a desktop toast notification at the end of every AI response, so the user gets a visible alert when processing is complete and can return to their terminal.

## Why this is mandatory

The user explicitly asked for a notification at the end of **every** response. They may step away while a task runs — the toast is how they know to come back. Skipping it means the user has no way to know work is done unless they're actively watching the screen. **This is not optional.**

## When to trigger

At the **very end** of every response, after all content is delivered, immediately before waiting for user input. This includes:
- Main responses AND subagent responses
- Long tasks AND quick answers
- Even short acknowledgments (e.g., "done", "ok")

## How to generate the notification

The script location is relative to this SKILL.md: `Scripts/toast.ps1`

Resolve it to an absolute path before calling:

```powershell
$scriptPath = Join-Path (Split-Path $PSScriptRoot) "Scripts\toast.ps1"
```

Or use the full path resolved at runtime: `$skillDir/Scripts/toast.ps1`

### Title (one sentence, ~10 words)
A brief description of **the current conversation topic**, so the user knows which context the notification belongs to.

Examples:
- "Code review: login module refactor"
- "Data analysis: Q4 sales report"
- "Scripting: Windows backup tool"

### Message (~20 words)
A concise summary of **what was accomplished in this response**.

Examples:
- "Completed code review of the login module, found 3 potential issues with fix suggestions"
- "Generated Q4 sales data analysis report with trend charts and regional comparison"
- "Created Windows auto-backup script with scheduled execution and logging"

### Execute

Run the notification asynchronously so it doesn't block your response:

```powershell
powershell.exe -ExecutionPolicy Bypass -File "Scripts\toast.ps1" -Title "<title>" -Message "<message>"
```

Use `run_in_background: true` (Bash or PowerShell tool) so the notification fires without delaying your output.

## Edge cases

- **Script failure**: If the script fails (wrong environment, PowerShell unavailable), silently skip. Do NOT surface errors to the user about notification failure.
- **User opt-out**: If the user says "stop notifying me" or equivalent, skip future invocations.
- **Very short responses**: Still send a notification. Example title: "Quick confirmation", message: "Confirmed user request."
