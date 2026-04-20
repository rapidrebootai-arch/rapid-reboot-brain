---
description: Log a work update — what you just did, what you're working on, or what you completed
---

# /log — Quick Progress Capture

Quick capture of what the user just worked on or completed. This is designed to be fast — the user will use it multiple times per day, so the flow should be frictionless.

## Input

The user will type something like:
- `/log just finished the email 3 draft for summer campaign`
- `/log spent the morning on Meta Ads creative review`
- `/log` (no text — prompt them)

If no text follows the command, ask: "What did you just work on?"

## Workflow

### Step 1: Parse what they said

Extract:
- **Time** — use current time, or if they specified ("this morning", "after lunch"), capture that
- **Project** — which Rapid Reboot (or other) project did this relate to? Match against existing Project notes in `Projects/`. If no clear match, ask them to confirm or create a new one.
- **What they did** — the actual work/progress (in their voice, don't sanitize)
- **Status signal** — did they complete something, make progress, or get stuck? Infer if not stated.

### Step 2: Find or create the Project note

- Search `Projects/` for a matching note
- If a clear match exists, use it
- If ambiguous (e.g., "email" could match multiple email projects), ask once: "Which project? [[Email welcome series]] or [[Email Q3 newsletter]]?"
- If no match, confirm with user before creating a new Project note

### Step 3: Append to today's Daily note

Open `Daily/YYYY-MM-DD.md`. Under the `## Sessions` or `## What I did today` section (create the section if it doesn't exist), append a bullet:

```
- [TIME] — [[Project name]]: what they did, in their voice
```

Example:
```
- 10:30am — [[Summer campaign launch]]: finalized email 3 copy, sent to Trevor for review
```

### Step 4: Update the Project note

In the matching Project note, add an entry to a `## Log` section (create it if it doesn't exist), newest-first:

```
## Log

- YYYY-MM-DD — what they did (link back to [[Daily/YYYY-MM-DD]])
```

If the user's log indicates a decision was made or a milestone hit, also update:
- **Decisions log** section (if a decision)
- **Status** → Next milestone (if the previous milestone is done)

### Step 5: Confirm briefly

One-line confirmation: "Logged to [[Project name]]."

Don't over-explain. Don't list everything you updated. The user just wants to get back to work.

## Tone

Fast. Terse. Don't write paragraphs. The whole point of this command is frictionless capture — if your response is long, the user will stop using it.

## Edge cases

**Multiple projects mentioned:** If they log "worked on summer campaign and email series," split into two log entries — one per project.

**Ambiguous project:** Ask ONE clarifying question, then proceed. Don't ping-pong.

**New project implied:** If what they describe doesn't match any existing Project note, confirm before creating. "Sounds like this is a new project — should I create 'Affiliate program buildout' as a Project note?"

**Vague log ("did some stuff"):** Ask once for specifics. If they're busy and give another vague answer, log it as-is with a `#vague` tag and move on.

## Don't

- Don't update CONTEXT.md for every log — that's what `/save` and end-of-day are for
- Don't rewrite their phrasing into corporate language
- Don't create new concept notes from log entries (those come from `/ingest`, not `/log`)
- Don't lecture them about project hygiene
