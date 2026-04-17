---
description: Search the vault and answer a question with citations to specific notes
---

# /query — Question Answering

Answer a question using the user's vault as the knowledge source. Every claim in your answer must cite the note it came from.

## Input

The user provides a question after `/query`. Examples:
- `/query what did we decide about the summer campaign launch?`
- `/query what are my notes on email segmentation?`
- `/query who was the client I talked to last week about custom colors?`

If no question follows the command, ask: "What do you want to know?"

## Workflow

### Step 1: Search the vault

Search across all vault folders using these strategies in order:

1. **Exact and near-exact title matches** — if the question names a concept, project, or person, check those notes first.
2. **Full-text search across Concepts/** — the meat of the answer usually lives here.
3. **Sources/ for date-specific or event-specific questions** — "what did I take away from the Tuesday meeting" goes here.
4. **People/ and Projects/** — for questions about specific people or workstreams.
5. **CONTEXT.md** — for recent/active questions ("what am I working on?").

Use Claude Code's file reading and grep tools to do this efficiently.

### Step 2: Evaluate what you found

If you found relevant notes:
- Pull the specific passages that answer the question
- Note which notes they came from
- Check if multiple notes agree or contradict each other

If you found nothing relevant:
- Tell the user honestly that nothing in the vault addresses this
- Suggest what they might ingest to fill the gap
- Do NOT make up an answer from outside the vault

### Step 3: Write the answer

Structure:
- **Direct answer first** — 1-3 sentences answering the question
- **Supporting details** — with citations to specific notes
- **Citations format** — after each claim, cite like this: `([[Note title]])` or `([[Note title#Section]])` for a specific section
- **Related notes** — at the end, list 2-3 related notes the user might want to read next

Example answer format:

> The summer campaign launches July 15th with the compression sleeves as the hero product ([[2026-04-10 - Marketing planning session]]). The messaging angle is "recovery between doubles" targeting youth soccer parents ([[Summer campaign positioning]]), and the email sequence starts two weeks before launch ([[Email pre-launch sequence]]).
>
> Related: [[Compression sleeve product page]], [[Youth soccer audience research]]

### Step 4: Flag gaps and contradictions

If:
- Notes disagree → show both perspectives, cite both, and flag the conflict
- Information is outdated → note when it was last updated
- There's a relevant stub note (no real content yet) → mention it so the user knows the concept exists but hasn't been fleshed out

## Tone

Be direct. This is a search over the user's own notes — they don't need hedging or "I think" language. State what the notes say, cite them, and let the user decide what to do with it.

## What NOT to do

- Don't answer from outside knowledge. If the vault doesn't have it, say so.
- Don't invent citations. Only cite notes that actually exist and actually say what you're attributing to them.
- Don't summarize so heavily that the user loses the original context. Quote or near-quote when the specific wording matters.
- Don't run `/ingest` or modify the vault as part of `/query`. This is read-only.
