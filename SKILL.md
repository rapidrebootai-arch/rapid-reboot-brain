---
name: second-brain
description: Build and maintain a personal or team knowledge base ("second brain") inside an Obsidian vault. Use this skill whenever the user wants to ingest sources (meeting notes, articles, transcripts, brain dumps, recipes, research, project docs, supplier conversations) into a linked wiki, query their notes, save a conversation into their vault, capture a quick thought, log daily work progress, or generate a weekly summary. Triggers on words like "second brain", "knowledge base", "vault", "wiki", "Obsidian", "my notes", "ingest this", "save this to my notes", "remember this", "capture this", "log this", "what did I work on", "weekly summary", and on any request to organize, extract concepts from, or link content across saved material. Works for any source type and any domain — professional, personal, or both.
---

# Second Brain Skill

A skill for building and maintaining a self-organizing Obsidian vault that turns any source material into interlinked atomic notes.

## What this skill does

It turns an Obsidian vault into a living knowledge base. When the user gives it a source (meeting transcript, article, recipe, brain dump, supplier conversation, whatever), it:

1. Saves the raw source as a `Source` note
2. Extracts the key concepts from that source
3. Creates or updates individual `Concept` notes — one idea per file
4. Links everything together using Obsidian's `[[wiki link]]` syntax
5. Updates the hot-cache context file so future sessions start with memory

It also answers questions against the vault with citations, saves conversation insights back into the vault, logs daily work progress, captures quick thoughts, and generates weekly summaries.

## Vault structure

```
Vault/
├── CONTEXT.md          Hot cache — read at start of every session
├── _inbox/             Quick capture inbox
│   ├── pending-logs.txt
│   └── archive/
├── Sources/            Raw ingested material
├── Concepts/           Atomic ideas extracted from sources
├── People/             Clients, contacts, anyone worth remembering
├── Projects/           Active work with logs and decision tracking
├── Daily/              Daily notes and session logs
├── Weekly/             Weekly summary reports
└── templates/          Note templates
```

Everything is plain markdown. Links use `[[Note Name]]` syntax, which Obsidian resolves automatically and displays in its graph view.

## Core principles

**One idea per Concept note.** If a source mentions five distinct ideas, that's five Concept notes. Atomic notes create dense linking, which is how unexpected connections emerge later.

**Link aggressively.** Every Concept note should link to its Source, to related Concepts, and to any People or Projects it touches. If a concept is mentioned but doesn't have a note yet, create a stub with a `#stub` tag so it exists in the graph.

**Preserve the user's voice.** When summarizing sources, keep their actual language. Don't sanitize brain dumps into corporate-speak.

**Never delete. Only add or amend.** If new information contradicts an old note, add the new info with an `## Update YYYY-MM-DD` section and note the contradiction. The vault is append-mostly.

**Write short.** Notes are meant to be scanned. A Concept note should be readable in under 30 seconds. If it's longer, it probably contains multiple concepts.

**Speed for capture commands.** `/capture` and `/log` are high-frequency commands. Responses should be brief — confirm what was saved and get out of the way.

## Command reference

| Command | File | When to use |
|---|---|---|
| `/wiki` | `commands/wiki.md` | First-time vault setup |
| `/ingest` | `commands/ingest.md` | Processing a full source |
| `/capture` | `commands/capture.md` | Quick thought, idea, or observation |
| `/log` | `commands/log.md` | Logging project progress |
| `/process-logs` | `commands/process-logs.md` | Batching keyboard-shortcut log entries |
| `/query` | `commands/query.md` | Searching the vault with citations |
| `/save` | `commands/save.md` | Saving the current conversation |
| `/weekly` | `commands/weekly.md` | Generating a weekly summary |

## Session startup behavior

At the start of every session where this skill is active, before responding to the user's first message:

1. Check if `CONTEXT.md` exists in the vault root. If it does, read it.
2. Check the `Daily/` folder for today's daily note. If it exists, read it. If not, create it.
3. Briefly acknowledge what's been loaded: "Loaded your vault context. Last session you were working on X. Today's daily note is ready."

This is the hot cache — it makes the brain feel continuous across sessions.

## Source types and how to handle them

The skill is format-agnostic. Infer the source type from the content and adjust extraction accordingly:

- **Meeting notes / transcripts** → Extract decisions, action items, people mentioned, key concepts. Create/update People notes for everyone named.
- **Articles / blog posts** → Extract claims, frameworks, notable ideas. Link to the author if they're a recurring figure.
- **Book highlights** → Each highlight usually maps to one Concept note. Group by theme when several highlights cover the same idea.
- **Brain dumps / personal notes** → Preserve the user's voice. Extract half-formed ideas and make stubs for things that need more thought.
- **Voice memo transcripts** → Treat like a brain dump. Raw is fine.
- **Recipes** → The recipe is the Source. Extract techniques and principles (e.g. "acid balance", "resting proteins") as Concepts.
- **Project docs / specs** → Link to or create the relevant Project note. Extract decisions and open questions.
- **Research / reports** → Extract findings, methodology notes, cited claims. Stub any cited work as its own Source for future ingestion.
- **Supplier / client conversations** → Create or update the Person note. Extract key terms: pricing, timelines, decisions, impressions.

If the source type isn't obvious, extract atomic ideas and link them. The graph doesn't care what kind of source they came from.

## Naming conventions

- **Source notes**: `YYYY-MM-DD - Short descriptive title.md`
- **Concept notes**: `Concept name as noun phrase.md` (e.g. `Recovery as lifestyle positioning.md`)
- **Person notes**: `First Last.md` or `Company Contact Name.md`
- **Project notes**: `Project name.md`
- **Daily notes**: `YYYY-MM-DD.md`
- **Weekly notes**: `Week of YYYY-MM-DD.md`

Concept note titles should be noun phrases, not sentences. Good: `High-performing ads need a villain`. Bad: `Why high-performing ads need a villain`.

## The hot cache (CONTEXT.md)

Read at the start of every session. Should contain:

- **Active projects** — what's currently in progress, with links to Project notes
- **Recent sessions** — last 3-5 session summaries, newest first
- **Open loops** — unresolved questions, follow-ups, things flagged for later
- **Quick-access links** — frequently referenced notes

Update CONTEXT.md at the end of any substantive session (when `/save` is called). Keep it under ~200 lines. If it's growing past that, move older content into Daily notes.

## When things are ambiguous

If the user gives you a source and it's not obvious where it fits, ask one clarifying question — but only one. Default is to put it in `Sources/` with today's date and extract concepts; that's always safe.

If a Concept note already exists for an idea, append to the existing note rather than creating a duplicate. Use `## Update YYYY-MM-DD` as the section header.

## The vault belongs to the user

Be a careful librarian, not an opinionated editor. When in doubt: preserve more, summarize less, link more. The user's voice matters more than tidy structure.
