---
description: Save the current conversation into the vault as a Source with extracted concepts
---

# /save — Save Conversation to Vault

Take the current Claude Code conversation and save the useful parts into the vault.

## Input

The user may optionally provide a topic label after `/save` (e.g., `/save email strategy thinking`). If they do, use it in the note title. If not, infer one from the conversation.

## Workflow

### Step 1: Decide what to save

Not every conversation deserves to be saved wholesale. Evaluate:

- **Skip saving entirely** if the conversation was purely operational (asking Claude to run a command, fix a typo, look up a factual thing). Just tell the user "This conversation was mostly operational — nothing worth saving. Let me know if you disagree."
- **Save as a focused Source** if there was substantive thinking: decisions made, ideas explored, plans drafted, problems worked through.

If in doubt, lean toward saving — the user invoked `/save` intentionally.

### Step 2: Create the Source note

Title: `YYYY-MM-DD - [Topic] conversation.md` (e.g., `2026-04-17 - Email strategy conversation.md`)

Use `templates/Source.md`. Populate:

- **Type**: `Conversation`
- **Original content**: The conversation itself, lightly cleaned up. Preserve the back-and-forth but strip out operational back-and-forth (tool calls, corrections, "wait actually..." moments). Keep the user's voice intact.
- **Summary**: 3-5 sentences capturing what was figured out, decided, or drafted
- **Key concepts**: Bulleted list of the atomic ideas from the conversation
- **People mentioned**: Any real people named in the conversation
- **Projects touched**: Any projects discussed

### Step 3: Extract Concept notes

Same pattern as `/ingest`:
- One atomic idea per Concept note
- Check for existing notes and append rather than duplicate
- Link back to this conversation Source
- Link to related Concepts and create stubs for missing ones

### Step 4: Update CONTEXT.md

This is especially important for `/save`. Update:

- **Active projects** — if the conversation advanced a project, link to it
- **Recent sessions** — add a 1-2 sentence summary of this session at the top
- **Open loops** — any unresolved questions or follow-ups from the conversation

### Step 5: Update today's daily note

Append to `Daily/YYYY-MM-DD.md` under `## Sessions`:
- Link to the new Source note
- One-line description

### Step 6: Confirm

Tell the user what was saved: source note, how many concepts (new vs updated), what was added to CONTEXT.md, and any loose ends flagged in open loops.

## Quality bar

The test for a good `/save` is: if the user comes back in a month and runs `/query` about this topic, will they find what they need? Aim for yes. That means:
- The key decisions and ideas exist as standalone Concept notes (searchable)
- The full context is preserved in the Source note (if they need the whole picture)
- The connections to existing projects and people are made (so the graph is useful)

## Don't

- Don't save sycophantic exchanges, greetings, or context-establishing back-and-forth
- Don't invent decisions that weren't actually made
- Don't flatten the user's voice into generic corporate prose
