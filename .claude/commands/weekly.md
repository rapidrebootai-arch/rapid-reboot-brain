---
description: Generate a weekly summary of everything worked on, grouped by project
---

# /weekly — Weekly Summary Report

Pull together everything the user has logged this week into a clean report grouped by project. This is the payoff for logging — they run this at the end of the week and get a full picture of what they did.

## Input

The user may specify:
- `/weekly` — current week (Mon-Sun of today's date)
- `/weekly last week` — previous week
- `/weekly [date range]` — custom range

Default: current week.

## Workflow

### Step 1: Determine the date range

- Current week = Monday through today (or Sunday if today is a weekend)
- Last week = Previous Monday through Sunday
- If user gave a range, use their range

### Step 2: Gather all log entries from Daily notes in range

- Read every `Daily/YYYY-MM-DD.md` file in the date range
- Extract all bullets from the `## Sessions` or `## What I did today` sections
- Each bullet should have a timestamp, project link, and what they did

### Step 3: Group by project

Collect all entries for each Project note they touched. For each project:
- Count total entries for the week
- Group entries chronologically within each project
- Preserve the user's original phrasing

### Step 4: Generate the report

Format the report as a new file at `Weekly/YYYY-MM-DD.md` (where the date is the Monday of that week). Create the `Weekly/` folder if it doesn't exist.

Structure:

```markdown
# Weekly Summary: [Week of YYYY-MM-DD]

## At a glance

- X projects touched
- Y logged activities
- Z days active

## By project

### [[Project name]] (N entries)

- Mon (M/D) — what they did
- Tue (M/D) — what they did
- [etc.]

**Status update:** [Brief inference of where the project stands based on the week's entries]

---

### [[Other project]] (N entries)

[...]

## Completed milestones

[Pull from any Project notes where the Next milestone field changed this week]

## Open loops from this week

[Pull from CONTEXT.md or anything tagged as open questions from the week's entries]

## Notable moments

[Any entries that had decisions, wins, or key insights — pulled from the user's own language]
```

### Step 5: Update CONTEXT.md

Add the week's summary to the "Recent sessions" area of CONTEXT.md with a link to the full weekly report.

### Step 6: Present it to the user

Don't just save the file silently. Show them the report content in the response so they can read it right there. Mention that it's also saved at `Weekly/YYYY-MM-DD.md`.

## Tone

This is the user's reward for disciplined logging. Make the report feel *useful*, not bureaucratic. Lead with substance. Keep it scannable.

## Quality bar

A good weekly summary should let the user:
- Write a status update to their boss/team in 2 minutes by pulling from it
- Know what to carry forward into next week
- See which projects got love and which got neglected
- Feel like they actually accomplished things (especially when imposter syndrome hits)

## Edge cases

**Sparse week (few log entries):** Don't pad. If they only logged 3 things all week, the report is 3 things. Note at the top: "Sparse logging week — consider capturing more next week for a richer summary."

**Missing daily notes:** If some days don't have daily notes, skip them silently. Don't flag gaps unless there are many.

**Projects with no Project note:** If a log entry references a project that doesn't have its own note, include it in the summary with a flag: `⚠ Project note doesn't exist yet — consider creating [[Project name]]`.

## Don't

- Don't invent activities that weren't logged
- Don't soften bad weeks or exaggerate good ones
- Don't add motivational commentary ("Great job this week!") — it's a report, not a pep talk
- Don't summarize the week's content so aggressively that the user's specific language is lost
