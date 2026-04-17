---
name: rapid-reboot-brain
description: Build and maintain a personal or team knowledge base ("second brain") inside an Obsidian vault. Use this skill whenever the user wants to ingest sources (meeting notes, articles, transcripts, brain dumps, recipes, research, project docs) into a linked wiki, query their notes, save a conversation into their vault, or set up a new vault. Triggers on words like "second brain", "knowledge base", "vault", "wiki", "Obsidian", "my notes", "ingest this", "save this to my notes", "remember this", and on any request to organize, extract concepts from, or link content across saved material. Works for any source type — it adapts to what it's given rather than forcing content into rigid buckets.
---

# Rapid Reboot Brain

A skill for building and maintaining a self-organizing Obsidian vault that turns any source material into interlinked atomic notes.

## What this skill does

It turns an Obsidian vault into a living knowledge base. When the user gives it a source (meeting transcript, article, recipe, brain dump, whatever), it:

1. Saves the raw source as a `Source` note
2. Extracts the key concepts from that source
3. Creates or updates individual `Concept` notes — one idea per file
4. Links everything together using Obsidian's `[[wiki link]]` syntax
5. Updates the hot-cache context file so future sessions start with memory

It also answers questions against the vault with citations, and saves conversation insights back into the vault.

## Vault structure

The vault uses this folder layout. Commands assume it exists — if it doesn't, run `/wiki` first.

```
Vault/
├── CONTEXT.md          # Hot cache — read at start of every session
├── Sources/            # Raw ingested material (one file per source)
├── Concepts/           # Atomic ideas extracted from sources
├── People/             # Clients, coworkers, contacts
├── Projects/           # Active work
├── Daily/              # Session logs and daily notes
└── templates/          # Note templates (copied in during setup)
```

Everything is plain markdown. Links use `[[Note Name]]` syntax, which Obsidian resolves automatically and displays in its graph view.

## Core principles

**One idea per Concept note.** If a source mentions five distinct ideas, that's five Concept notes, not one. This is what makes the graph useful — atomic notes create dense linking, which is how you discover unexpected connections later.

**Link aggressively.** Every Concept note should link to the Source it came from, to related Concepts, and to any People or Projects it touches. If a concept is mentioned but doesn't have a note yet, create a stub note with a `#stub` tag so it exists in the graph.

**Preserve the user's voice.** When summarizing sources, keep the user's actual language where possible. Don't sanitize brain dumps into corporate-speak.

**Never delete. Only add or amend.** If new information contradicts an old note, add the new info and note the contradiction — don't overwrite. The vault is an append-mostly system.

**Write short.** Notes are meant to be scanned. A Concept note should be readable in under 30 seconds. If it's longer, it probably contains multiple concepts and should be split.

## Command reference

This skill includes four slash commands. When the user invokes one, read the corresponding file in `.claude/commands/` and follow its instructions.

- `/wiki` — First-time vault setup. Creates folder structure, templates, and the initial CONTEXT.md.
- `/ingest [source]` — Takes a file path, pasted text, or URL and creates Source + Concept notes.
- `/query [question]` — Searches the vault and answers with citations to specific notes.
- `/save [optional topic]` — Saves the current conversation into the vault as a Source with extracted concepts.

## Session startup behavior

At the start of every session where this skill is active, do this **before responding to the user's first message**:

1. Check if `CONTEXT.md` exists in the vault root. If it does, read it.
2. Check the `Daily/` folder for today's daily note. If it exists, read it. If not, create it.
3. Briefly acknowledge what you've loaded: "Loaded context from your vault — last session you were working on X. Today's daily note is ready."

This is the "hot cache" — it's what makes the brain feel continuous across sessions.

## Source types and how to handle them

The skill is format-agnostic. When given a source, infer the type from the content and adjust extraction accordingly:

- **Meeting notes / transcripts** → Extract decisions, action items, people mentioned, and key concepts. Create/update People notes for everyone named.
- **Articles / blog posts** → Extract claims, frameworks, and notable quotes. Link to the author if they're a recurring figure.
- **Book highlights** → Each highlight usually maps to one Concept note. Group by theme when several highlights cover the same idea.
- **Brain dumps / personal notes** → Preserve the user's voice. Extract the half-formed ideas and make stubs for ideas that need more thought later.
- **Recipes** → The recipe itself is the Source. Extract techniques, ingredients of interest, and any principles (e.g., "resting meat", "acid balance") as Concepts.
- **Project docs / specs** → Link to or create the relevant Project note. Extract decisions and open questions.
- **Research papers / reports** → Extract findings, methodology notes, and cited claims. Stub any cited work as its own Source for future ingestion.

If the source type isn't obvious, just extract atomic ideas and link them. The graph doesn't care what kind of source they came from.

## Templates

Templates live in `templates/` and get copied into the vault by `/wiki`. They're starting points — feel free to deviate when a particular note calls for it.

- `Source.md` — For raw ingested material
- `Concept.md` — For atomic ideas
- `Person.md` — For people (clients, coworkers, authors)
- `Project.md` — For active work
- `Daily.md` — For session and daily notes

See the files in `templates/` for the exact structure.

## Naming conventions

- **Source notes**: `YYYY-MM-DD - Short descriptive title.md` (e.g., `2026-04-17 - Marketing standup notes.md`)
- **Concept notes**: `Concept name in natural case.md` (e.g., `Compression therapy recovery timing.md`)
- **Person notes**: `First Last.md`
- **Project notes**: `Project name.md`
- **Daily notes**: `YYYY-MM-DD.md`

Concept note titles should be the idea itself, phrased as a noun phrase, not a sentence. Good: `Email welcome series structure`. Bad: `How to structure an email welcome series`.

## The hot cache (CONTEXT.md)

`CONTEXT.md` sits at the vault root and is the first thing to read each session. It should contain:

- **Active projects** — What the user is currently working on, with links to Project notes
- **Recent sessions** — Last 3–5 session summaries, newest first
- **Open loops** — Questions, follow-ups, and things flagged for later
- **Quick-access links** — Frequently referenced notes

Update CONTEXT.md at the end of any substantive session (or when `/save` is called). Keep it under ~200 lines — if it's growing past that, move older content into Daily notes.

## When things are ambiguous

If the user gives you a source and it's not obvious where it fits, ask one clarifying question — but only one. Default answer is to put it in `Sources/` with today's date and extract concepts; that's always safe.

If a Concept note already exists for an idea you want to create, append to the existing note rather than creating a duplicate. Use `## Update YYYY-MM-DD` as the section header.

## Good taste

The vault belongs to the user. Your job is to be a careful librarian, not an opinionated editor. When in doubt: preserve more, summarize less, link more.
