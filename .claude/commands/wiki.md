---
description: Set up a new Obsidian vault as a Rapid Reboot Brain knowledge base
---

# /wiki — Vault Setup

You're setting up a new Rapid Reboot Brain vault. This is a one-time operation per vault.

## Steps

1. **Confirm location.** Ask the user where the vault should live if it's not already obvious from the working directory. Default is the current directory.

2. **Check for existing vault.** If `CONTEXT.md` already exists in the target directory, stop and ask the user if they want to re-initialize (this will not delete existing notes but may overwrite templates).

3. **Create the folder structure:**
   ```
   Sources/
   Concepts/
   People/
   Projects/
   Daily/
   templates/
   ```

4. **Copy templates.** Copy all files from the skill's `templates/` directory into the vault's `templates/` folder. The template files are:
   - `Source.md`
   - `Concept.md`
   - `Person.md`
   - `Project.md`
   - `Daily.md`

5. **Create `CONTEXT.md`** at the vault root with this starter content:
   ```markdown
   # Vault Context

   This is the hot cache. Read this at the start of every session.

   ## Active projects
   _(None yet — add projects to Projects/ and link them here)_

   ## Recent sessions
   _(Session summaries will appear here, newest first)_

   ## Open loops
   _(Questions and follow-ups for later)_

   ## Quick-access links
   _(Frequently referenced notes)_

   ---
   Last updated: YYYY-MM-DD
   ```
   Replace YYYY-MM-DD with today's date.

6. **Create today's daily note** at `Daily/YYYY-MM-DD.md` using the Daily template.

7. **Create a `README.md`** at the vault root that briefly explains the structure so anyone opening the vault understands what they're looking at. Keep it short — 10-15 lines.

8. **Create `.gitignore`** at the vault root with:
   ```
   .obsidian/workspace*
   .obsidian/cache
   .trash/
   .DS_Store
   ```

9. **Confirm completion.** Tell the user:
   - The vault is set up
   - They should open the folder in Obsidian via "Manage Vaults > Open folder as vault"
   - They can now run `/ingest` with any file or pasted content
   - The graph view becomes useful once they have 5+ ingested sources

## Tone

Be brief. The user wants to get to the fun part (ingesting stuff). Don't over-explain.
