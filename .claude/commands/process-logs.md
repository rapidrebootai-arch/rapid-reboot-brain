---
description: Process all pending log entries from the quick-capture inbox file into Daily and Project notes
---

# /process-logs — Batch Process Captured Logs

Reads pending log entries from a plain-text capture file and routes each one into the right Daily note and Project note, same as if the user had run `/log` for each. Designed to be fast and batch-oriented so the user can capture dozens of entries throughout the day via a keyboard Shortcut and process them all at once.

## The capture file

Path: `~/Documents/rapid-reboot-vault/_inbox/pending-logs.txt`
(Adjust path if operating in a different vault — check the current working directory and use `<vault>/_inbox/pending-logs.txt`.)

Each line in the file is one captured entry, in this format:
```
YYYY-MM-DDTHH:MM | [optional project hint] | what I did
```

Example lines:
```
2026-04-20T10:32 | summer campaign | finished email 3 draft, sent to Trevor
2026-04-20T11:45 |  | reviewed Meta ads performance, paused 2 underperforming variants
2026-04-20T14:10 | normatec video | filmed b-roll at the gym
```

The middle field (project hint) may be empty — in that case, infer the project from the content.

## Workflow

### Step 1: Check if the inbox file exists

- Look for `<vault>/_inbox/pending-logs.txt`
- If it doesn't exist or is empty: tell the user "No pending logs to process" and stop.

### Step 2: Read and parse all entries

- Read every line in the file
- Skip empty lines
- Parse each line into `{timestamp, project_hint, content}`
- If a line doesn't fit the expected format, still process it — treat the whole line as `content` with no hint, no timestamp (use current time).

### Step 3: Group entries by project and day

For each entry, determine:
- **Which project** — use the project hint if provided, otherwise match content against existing Project notes in `Projects/`. If no clear match, flag it for user review rather than creating a new project automatically.
- **Which Daily note** — based on the timestamp's date

Group all entries going to the same Daily note together, and all entries going to the same Project note together. This minimizes file reads/writes.

### Step 4: Write to Daily notes

For each date with entries:
- Open (or create) `Daily/YYYY-MM-DD.md`
- Append each entry as a bullet under `## Sessions` (create the section if missing), in time order:
  ```
  - HH:MM — [[Project name]]: content as user wrote it
  ```

### Step 5: Update Project notes

For each Project note with entries:
- Under `## Log` section (create if missing), add entries newest-first:
  ```
  - YYYY-MM-DD — content (from [[Daily/YYYY-MM-DD]])
  ```

### Step 6: Handle unmatched entries

If any entries couldn't be routed to a project (ambiguous or no match and no hint):
- Still add them to the Daily note under `## Unfiled logs` section
- Flag them in the summary for user review
- Don't block processing of the rest

### Step 7: Archive the inbox file

After successful processing:
- Move `_inbox/pending-logs.txt` to `_inbox/archive/pending-logs-YYYY-MM-DD-HHMM.txt` (preserving history)
- Create a new empty `_inbox/pending-logs.txt` ready for next captures

### Step 8: Report back to the user

Brief summary:
- How many entries processed
- Which projects got updates (list with counts)
- Any unfiled entries that need their attention
- A one-line note if anything looked off

Example response:
> Processed 8 pending logs.
> - [[Summer campaign launch]]: 3 entries
> - [[Meta Ads Q2 refresh]]: 2 entries
> - [[Normatec comparison video]]: 2 entries
> - 1 entry unfiled (see today's Daily note) — about "coffee chat with Marcus"

## Performance

This command is about speed. If there are 20 entries, don't narrate each one — do the work, report the totals. The user wants to see the batch done and move on.

## Don't

- Don't create new Project notes for unmatched entries — flag them instead
- Don't rewrite user content into cleaner prose — preserve their voice
- Don't update CONTEXT.md (that's what `/save` is for at end of day)
- Don't delete the archive files (they're the user's audit trail if something goes wrong)
