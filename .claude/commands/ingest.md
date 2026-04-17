---
description: Ingest a source (file, URL, or pasted text) into the vault and extract linked concept notes
---

# /ingest — Source Ingestion

Take any source material and turn it into a Source note plus linked Concept notes.

## Input handling

The user will provide one of:
- A file path (e.g., `/ingest ~/Downloads/meeting-transcript.txt`)
- A URL (e.g., `/ingest https://example.com/article`)
- Pasted text directly after the command
- A filename in the current vault that needs to be reprocessed

If nothing follows the command, ask: "What should I ingest? Paste the content, give me a file path, or drop a URL."

## Workflow

### Step 1: Read the source

- **File path** → Read it. Handle common formats (txt, md, pdf, docx).
- **URL** → Fetch the page content.
- **Pasted text** → Use it directly.

### Step 2: Identify the source type

Infer from content. Common types:
- Meeting notes / transcript
- Article / blog post
- Book highlights
- Brain dump / personal note
- Recipe
- Project doc / spec
- Research paper / report
- Podcast transcript
- Other

This informs the note title and which metadata to extract.

### Step 3: Create the Source note

Use `templates/Source.md` as the starting point. Fill in:
- **Title**: `YYYY-MM-DD - [Short descriptive title]`
- **Type**: The inferred source type
- **Original content**: The full source, preserved verbatim (or a link to the original file if it's huge)
- **Summary**: 3-5 sentences, in the user's voice where possible
- **Key concepts**: Bulleted list of the atomic ideas you'll extract (these become individual Concept notes)
- **People mentioned**: Link to People notes (create stubs if they don't exist)
- **Projects touched**: Link to Project notes (create stubs if needed)

Save to `Sources/YYYY-MM-DD - [title].md`.

### Step 4: Extract Concept notes

For each key concept identified:

1. **Check if a Concept note already exists** for this idea. Search `Concepts/` for similar titles and for notes that mention the concept.
2. **If it exists**, append an `## Update YYYY-MM-DD` section with the new information and a link back to the Source.
3. **If it doesn't exist**, create a new note using `templates/Concept.md`. Keep it atomic — one idea, under 30 seconds to read.
4. **Link back to the Source.** Every Concept note must cite where it came from.
5. **Link to related Concepts.** If the idea connects to others in the vault, add `[[links]]` to them. Do this generously — the graph gets more useful with more links.
6. **Create stubs for missing linked concepts.** If you reference an idea that doesn't have a note yet, create a minimal stub with `#stub` tag so the link isn't broken.

### Step 5: Update People and Project notes

For each person mentioned:
- If no note exists, create one using `templates/Person.md` with just their name and the context (e.g., "Mentioned in [[Source note]]").
- If a note exists, add a bullet under `## Mentions` linking to the new Source.

Same pattern for Projects.

### Step 6: Update CONTEXT.md

If this ingestion surfaced anything active (a new project, an open question, a decision), update the relevant sections of `CONTEXT.md`.

### Step 7: Summarize for the user

Report back:
- How many Concept notes were created vs updated
- Which People and Projects were touched
- Any stubs that need fleshing out later (flag these)
- A one-line suggestion for what to ingest next if it seems natural (e.g., "You mentioned the Q2 campaign brief — if you have that doc, ingesting it would link everything up")

## Quality checks before finishing

- Every Concept note links back to its Source ✓
- Every Concept note title is a noun phrase, not a sentence ✓
- No Concept note is longer than ~200 words ✓
- People and Projects mentioned have notes (even if stubs) ✓
- The Source note's `Key concepts` list matches the Concept notes created ✓

## Edge cases

**Source is huge (>10k words)**: Summarize in the Source note, store the raw content in an attachment or separate file, but still extract atomic concepts.

**Source is tiny (<100 words)**: It probably becomes one Concept note directly, with a reference back to where it came from. Skip creating a separate Source note unless the user asked for one.

**Source contradicts existing notes**: Don't overwrite. Add the new info with an `## Update YYYY-MM-DD` section and note the contradiction. Flag it in your summary to the user.

**Content is sensitive (personal, confidential)**: Process it normally — the vault is the user's private knowledge base. But don't surface sensitive content in your summary back to the user unless they ask.
